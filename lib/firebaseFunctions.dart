import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions{

  Future<void> signUp(String email, String password) {
     FirebaseAuth.instance.createUserWithEmailAndPassword
      (email: email,
        password: password);
  }

  Future<void> signIn(String email, String password)  {
     FirebaseAuth.instance.signInWithEmailAndPassword
      (email: email,
        password: password);
  }

  Future<void> sendResetMail(String email)  {
     FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}