import 'package:firebase_auth/firebase_auth.dart';
import 'package:oria/models/user.dart';
import 'package:oria/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Create user object based on firebase user
  UserFB _userFromFirebaseUser(User user) {
    return user != null ? UserFB(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserFB> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password,
      String personName, DateTime birthdate) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid)
          .setUserDetails(personName, birthdate, email);
      //create a new document for the user with the uid
      // await DatabaseService(uid: user.uid).updateUserData('0', personName, 100);
      await user.sendEmailVerification();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with E-mail and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
