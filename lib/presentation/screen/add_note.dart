import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/models/notes.dart';
import 'package:notesapp/presentation/screen/home_screen.dart';
import 'package:notesapp/providers/notes_provider.dart';

class AddNote extends StatefulWidget {
  Notes currentNote;
  bool isEditing = false;
  AddNote({required this.currentNote, required this.isEditing});
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late FocusNode noteTitleNode;

  late FocusNode noteContentNode;

  String noteTitle = "";

  String noteContet = "";

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isSaving = false;

  late TextEditingController _titleController;

  late TextEditingController _contentController;

  @override
  void initState() {
    initializeController(widget.isEditing);
    noteContentNode = new FocusNode();
    noteTitleNode = new FocusNode();
    super.initState();
  }

  void initializeController(bool isEditing) {
    _titleController = new TextEditingController(
        text: isEditing ? widget.currentNote.title : "");

    _contentController = new TextEditingController(
        text: isEditing ? widget.currentNote.content : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Note',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  "Title",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              TextFormField(
                focusNode: noteTitleNode,
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title of Note',
                  hintStyle: Theme.of(context).textTheme.caption,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  fillColor: Colors.white24,
                  filled: true,
                ),
                validator: (value) {
                  if (value == "") {
                    return 'Note title cannot be empty!';
                  }
                  return null;
                },
                onSaved: (value) {
                  noteTitle = value.toString().trim();
                },
                onFieldSubmitted: (value) {
                  noteTitleNode.unfocus();
                  FocusScope.of(context).requestFocus(noteContentNode);
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  "Content",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              TextFormField(
                focusNode: noteContentNode,
                controller: _contentController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Note Content',
                  hintStyle: Theme.of(context).textTheme.caption,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  fillColor: Colors.white24,
                  filled: true,
                ),
                validator: (value) {
                  if (value == "") {
                    return 'Note Content cannot be empty!';
                  }
                  return null;
                },
                onSaved: (value) {
                  noteContet = value.toString().trim();
                },
                onFieldSubmitted: (value) {
                  noteContentNode.unfocus();
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: isSaving
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await _saveForm();
                          },
                          child: Text(
                            "Submit",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 20),
                          )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    NotesProvider notesProvier = Get.find<NotesProvider>();
    setState(() {
      isSaving = true;
    });
    bool isValid = _key.currentState!.validate();
    if (isValid) {
      if (widget.isEditing) {
        _key.currentState!.save();
        Notes note = Notes(
            id: widget.currentNote.id,
            content: noteContet,
            editTimeStamp: Timestamp.now().millisecondsSinceEpoch,
            isStarred: false,
            timeStamp: Timestamp.now().millisecondsSinceEpoch,
            title: noteTitle);
        await notesProvier.updateNote(updatedNote: note);
        Get.snackbar('Note Updated Successfully', '');
      } else {
        _key.currentState!.save();
        Notes note = Notes(
            id: '',
            content: noteContet,
            editTimeStamp: Timestamp.now().millisecondsSinceEpoch,
            isStarred: false,
            timeStamp: Timestamp.now().millisecondsSinceEpoch,
            title: noteTitle);
        await notesProvier.addNote(note);
        Get.snackbar('Note Added Successfully', '');
      }
    }
    setState(() {
      isSaving = false;
    });

    Get.offAll(() => HomeScreen());
  }
}
