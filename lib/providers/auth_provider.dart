import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notesapp/core/models/user_model.dart';
import 'package:notesapp/presentation/screen/home_screen.dart';

class AuthProvider extends GetxController {
  GoogleSignIn googleSignIn = GoogleSignIn();
  late final User? _user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  set setUser(User user) {
    _user = user;
    update();
  }

  User? get user => _user;

  //google sign in
  Future<bool> signInGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential authResult =
            await auth.signInWithCredential(credential);
        setUser = authResult.user!;
        UserModel userData = UserModel(
            email: googleSignInAccount.email,
            name: googleSignInAccount.displayName.toString(),
            photoUrl: googleSignInAccount.photoUrl.toString());

        users.doc(user?.uid).get().then((doc) {
          if (doc.exists) {
            doc.reference.update(UserModel.toJson(userData));
          } else {
            users.doc(user?.uid).set(UserModel.toJson(userData));
          }
        });
      }
      Get.to(HomeScreen());
      return true;
    } catch (PlatformException) {
      print(PlatformException.toString());
      Get.snackbar('Error', PlatformException.toString());
      return false;
    }
  }
}
