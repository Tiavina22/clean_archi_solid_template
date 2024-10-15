import 'package:flutter/material.dart';
import 'package:clean_archi_solid_template/data/models/note_model.dart';
import 'package:clean_archi_solid_template/presentation/providers/note_provider..dart';
import 'package:clean_archi_solid_template/presentation/widgets/note_form.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  NoteItem({required this.note});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.content),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => NoteForm(note: note),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<NoteProvider>(context, listen: false)
                  .deleteNote(note.id!);
            },
          ),
        ],
      ),
    );
  }
}
