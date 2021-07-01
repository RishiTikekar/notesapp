import 'package:get/get.dart';
import 'package:notesapp/providers/auth_provider.dart';
import 'package:notesapp/providers/notes_provider.dart';

void initProvider() {
  AuthProvider authProvider = Get.put(AuthProvider());

  NotesProvider notesProvider = Get.put(NotesProvider());
}
