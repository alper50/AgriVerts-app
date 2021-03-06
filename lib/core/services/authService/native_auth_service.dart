import 'package:firebase_auth/firebase_auth.dart';

class NativeAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Future<bool> nativeSignIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<bool> nativeSignUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      auth.authStateChanges().listen((user) {
        if (user != null) {
          user.updateDisplayName(username);
        }
      });
      // await sendEmailConfirmation();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> sendEmailConfirmation() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
    }
  }

  void nativeSignOut() {
    FirebaseAuth.instance.signOut();
  }
}
