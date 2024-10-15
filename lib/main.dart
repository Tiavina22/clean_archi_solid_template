import 'package:flutter/material.dart';
import 'package:clean_archi_solid_template/presentation/pages/note_list_page.dart';
import 'package:clean_archi_solid_template/presentation/providers/note_provider..dart';
import 'package:provider/provider.dart';
import 'data/repositories/note_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String apiUrl = 'http://192.168.44.89:3000';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(NoteRepository(apiUrl)),
      child: MaterialApp(
        title: 'Note Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: NoteListPage(),
      ),
    );
  }
}
