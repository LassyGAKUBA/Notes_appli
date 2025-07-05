import 'package:flutter/material.dart';
import 'notes.dart';
import 'note_service.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final NoteService _noteService = NoteService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: StreamBuilder(
        stream: _noteService.getNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final List<Note> notes = snapshot.data ?? [];

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notes[index].title),
                subtitle: Text(notes[index].content),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _noteService.deleteNote(notes[index].id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Note'),
                content: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: _contentController,
                      decoration: InputDecoration(labelText: 'Content'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Note note = Note(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: _titleController.text,
                        content: _contentController.text,
                      );
                      _noteService.addNote(note);
                      Navigator.of(context).pop();
                      _titleController.clear();
                      _contentController.clear();
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}