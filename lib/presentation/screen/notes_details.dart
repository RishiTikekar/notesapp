import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/models/notes.dart';
import 'package:notesapp/presentation/screen/add_note.dart';
import 'package:notesapp/presentation/screen/home_screen.dart';
import 'package:notesapp/providers/notes_provider.dart';

class NotesDetails extends StatelessWidget {
  Notes currentNote;

  NotesDetails({required this.currentNote});

  NotesProvider _notesProvider = Get.find<NotesProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        onPressed: () {
          Get.to(() => AddNote(
                currentNote: currentNote,
                isEditing: true,
              ));
        },
        child: Icon(
          Icons.edit,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Note Detail',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _notesProvider.deleteCurrentNote(currentNote.id);
              Get.off(() => HomeScreen());
            },
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Title of Note :\n" + currentNote.title,
                  style: Theme.of(context).textTheme.headline1),
              Text("Content of Note :\n" + currentNote.content,
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
        ),
      ),
    );
  }
}
