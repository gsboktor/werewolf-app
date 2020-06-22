import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:werewolfapp/models/User.dart';

class DatabaseService {
  String _gameString;
  User _usr;
  CollectionReference collection;

  DatabaseService(this._gameString, this._usr){
    collection = Firestore.instance.collection(_gameString);
  }

  Future<void> updateGameRoom() async {
    print('here');
    return await collection.document(_usr.uid).setData({
      'role': '',
      'name': _usr.name,
      'isMinion': false
    });
  }
}
