import 'package:flutter/material.dart';
import 'package:clean_archi_solid_template/presentation/providers/note_provider..dart';
import 'package:clean_archi_solid_template/presentation/widgets/note_form.dart';
import 'package:clean_archi_solid_template/presentation/widgets/note_item.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => NoteForm(),
              );
            },
          ),
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          return FutureBuilder(
            future: noteProvider.fetchNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView.builder(
                  itemCount: noteProvider.notes.length,
                  itemBuilder: (context, index) {
                    return NoteItem(note: noteProvider.notes[index]);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
