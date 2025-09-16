import 'dart:developer';
import 'package:fake_store/core/services/fire_store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FireStoreService fireStoreService = FireStoreService();
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('Password should be at least 6 characters');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw ('There was an error creating the account. Please try again.');
      }
    } catch (e) {
      throw ('There was an error creating the account. Please try again.');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return credential.user!;

      // تسجيل الدخول تم بنجاح
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('Email address not found');
      } else if (e.code == 'wrong-password') {
        throw ('Password is incorrect');
      } else {
        throw ('There was an error signing in. Please try again.');
      }
    } catch (e) {
      log(
        'there an error in firebaseAuth service.signinwithemail and password${e.toString()}',
      );
      throw ('There was an error signing in. Please try again.');
    }
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  bool isLogedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
