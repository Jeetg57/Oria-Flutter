import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference doctorsCollection =
      Firestore.instance.collection('doctors');

  // Future updateUserData(String sugars, String name, int strength) async {
  //   return await brewCollection
  //       .document(uid)
  //       .setData({'sugars': sugars, 'name': name, 'strength': strength});
  // }

  Future setUserDetails(String name, DateTime birthdate, String email) async {
    return await userCollection
        .document(uid)
        .setData({"email": email, "name": name, "birthdate": birthdate});
  }

  // Future getUserDetails()
  //brew list from snapshot
  List<DoctorData> _doctorListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((document) {
      return DoctorData(
        id: document.documentID,
        name: document.data['name'] ?? "",
        speciality: document.data['speciality'] ?? "",
        appointmentPrice: document.data['appointmentPrice'] ?? 0,
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      // birthdate: snapshot.data['birthdate']);
    );
  }

  DoctorData _doctorDataFromSnapshot(DocumentSnapshot snapshot) {
    return DoctorData(
      name: snapshot.data['name'] ?? "",
      speciality: snapshot.data['speciality'] ?? "",
      appointmentPrice: snapshot.data['appointmentPrice'] ?? 0,
      location: snapshot.data['location'] ?? 0,
      experience: snapshot.data['experience'] ?? 0,
      description: snapshot.data['description'] ?? "",
      numRated: snapshot.data['numRated'] ?? 0,
      pictureLink: snapshot.data['pictureLink'] ?? "",
      totalRatings: snapshot.data['totalRatings'] ?? 0,
    );
  }

  // get brews stream
  Stream<List<DoctorData>> get doctors {
    return doctorsCollection.snapshots().map(_doctorListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<DoctorData> doctorData(doctorId) {
    return doctorsCollection
        .document(doctorId)
        .snapshots()
        .map(_doctorDataFromSnapshot);
  }
}
