import 'package:flutter/material.dart';
import 'package:clean_archi_solid_template/data/models/note_model.dart';
import 'package:clean_archi_solid_template/presentation/providers/note_provider..dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  final Note? note;

  NoteForm({this.note});

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title = widget.note!.title;
      _content = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: _title,
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) => _title = value,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
            ),
            TextFormField(
              initialValue: _content,
              decoration: InputDecoration(labelText: 'Content'),
              onChanged: (value) => _content = value,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter content' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final note = Note(
                    id: widget.note?.id,
                    title: _title,
                    content: _content,
                  );
                  if (widget.note == null) {
                    Provider.of<NoteProvider>(context, listen: false)
                        .addNote(note);
                  } else {
                    Provider.of<NoteProvider>(context, listen: false)
                        .updateNote(note);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(widget.note == null ? 'Add Note' : 'Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}
