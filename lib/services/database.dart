import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oria/models/brew.dart';
import 'package:oria/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((document) {
      return Brew(
          name: document.data['name'] ?? "",
          strength: document.data['strength'] ?? 0,
          sugars: document.data['sugars'] ?? "0");
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        strength: snapshot.data['strength'],
        sugars: snapshot.data['sugars']);
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
