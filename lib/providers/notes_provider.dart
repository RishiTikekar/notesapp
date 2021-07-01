import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/models/notes.dart';
import 'package:notesapp/providers/auth_provider.dart';

class NotesProvider extends GetxController {
  AuthProvider _authProvider = Get.find();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Notes _blankNote = Notes(
      content: '',
      editTimeStamp: 0,
      id: '',
      isStarred: false,
      timeStamp: 0,
      title: '');

  Notes get blankNote => _blankNote;

  Future<void> addNote(Notes note) async {
    CollectionReference ref = _firebaseFirestore
        .collection('users')
        .doc(_authProvider.user!.uid)
        .collection('notes');
    await ref.add(Notes.toJson(note));
  }

  Future<List<Notes>> getAllNotes() async {
    List<Notes> listOfNotes = [];
    CollectionReference ref = _firebaseFirestore
        .collection('users')
        .doc(_authProvider.user!.uid)
        .collection('notes');
    QuerySnapshot? snapshot = await ref.get();
    snapshot.docs.forEach((snapshot) {
      listOfNotes.add(
          Notes.fromJson(snapshot.data() as Map<String, dynamic>, snapshot.id));
    });
    listOfNotes.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
    return listOfNotes;
  }

  Future<bool> deleteCurrentNote(String id) async {
    try {
      CollectionReference reference = _firebaseFirestore
          .collection('users')
          .doc(_authProvider.user!.uid)
          .collection('notes');
      await reference.doc(id).delete();
      return true;
    } catch (PlatformException) {
      Get.snackbar('Error', PlatformException.toString());
      return false;
    }
  }

  Future<bool> updateNote({required Notes updatedNote}) async {
    try {
      CollectionReference _reference = _firebaseFirestore
          .collection('users')
          .doc(_authProvider.user!.uid)
          .collection('notes');
      _reference.doc(updatedNote.id).update(Notes.toJson(updatedNote));
      return true;
    } catch (PlatformException) {
      Get.snackbar('Error', PlatformException.toString());
      return false;
    }
  }
}
