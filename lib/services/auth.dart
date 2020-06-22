import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:werewolfapp/models/User.dart';
import 'package:werewolfapp/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnonHost(String name, String gameString) async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser tempUser = result.user;

      //TODO Add user to the database collection before returning
      User usr = _createUserFromFirebase(tempUser, name);
      await DatabaseService(gameString, usr).updateGameRoom();

      return usr;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    return await _auth.signOut();
  }

  Future signInAnonGuest(String name) async {
    return;
  }

  User _createUserFromFirebase(FirebaseUser tempUser, String name){
    return User(tempUser.uid, name);
  }
}
