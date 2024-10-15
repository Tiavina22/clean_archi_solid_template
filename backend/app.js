const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

const pool = new Pool({
    user: 'titi',
    host: 'localhost',
    database: 'notes',
    password: 'titi',
    port: 5432,
});

// CRUD operations for notes
app.get('/notes', async (req, res) => {
    const result = await pool.query('SELECT * FROM notes');
    res.json(result.rows);
});

app.post('/notes', async (req, res) => {
    const { title, content } = req.body;
    const result = await pool.query('INSERT INTO notes (title, content) VALUES ($1, $2) RETURNING *', [title, content]);
    res.status(201).json(result.rows[0]);
});

app.put('/notes/:id', async (req, res) => {
    const { id } = req.params;
    const { title, content } = req.body;
    const result = await pool.query('UPDATE notes SET title = $1, content = $2 WHERE id = $3 RETURNING *', [title, content, id]);
    res.json(result.rows[0]);
});

app.delete('/notes/:id', async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM notes WHERE id = $1', [id]);
    res.status(204).send();
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
