import 'package:flutter/material.dart';
import 'note_model.dart';

class NotesListScreen extends StatefulWidget {
  final List<NoteModel> notes;

  const NotesListScreen({super.key, required this.notes});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Notes"),
        backgroundColor: Colors.cyanAccent,
      ),
      body: widget.notes.isEmpty
          ? Center(child: Text("No notes yet"))
          : ListView.builder(
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          final note = widget.notes[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(note.topic),
              subtitle: Text("${note.date}\n${note.details}"),
              isThreeLine: true,
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    widget.notes.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
