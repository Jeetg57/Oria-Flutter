import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final StorageReference storageReferenceUser =
      FirebaseStorage().ref().child("userImages");

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference doctorsCollection =
      FirebaseFirestore.instance.collection('doctors');

  // Future updateUserData(String sugars, String name, int strength) async {
  //   return await brewCollection
  //       .document(uid)
  //       .setData({'sugars': sugars, 'name': name, 'strength': strength});
  // }

  Future setUserDetails(String name, DateTime birthdate, String email) async {
    return await userCollection
        .doc(uid)
        .set({"email": email, "name": name, "birthdate": birthdate});
  }

  // Future getUserDetails()
  //brew list from snapshot
  List<DoctorData> _doctorListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return DoctorData(
        id: document.id,
        name: document.data()['name'] ?? "",
        specialty: document.data()['specialty'] ?? "",
        appointmentPrice: document.data()['appointmentPrice'] ?? 0,
        city: document.data()['city'] ?? "",
        totalRatings: document.data()['totalRatings'] ?? 0,
        numRated: document.data()['numRated'] ?? 0,
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      profilePicture: snapshot.data()['profilePicture'],
      // birthdate: snapshot.data['birthdate']);
    );
  }

  DoctorData _doctorDataFromSnapshot(DocumentSnapshot snapshot) {
    return DoctorData(
      name: snapshot.data()['name'] ?? "",
      specialty: snapshot.data()['specialty'] ?? "",
      appointmentPrice: snapshot.data()['appointmentPrice'] ?? 0,
      location: snapshot.data()['location'] ?? 0,
      experience: snapshot.data()['experience'] ?? 0,
      description: snapshot.data()['description'] ?? "",
      numRated: snapshot.data()['numRated'] ?? 0,
      pictureLink: snapshot.data()['pictureLink'] ?? "",
      totalRatings: snapshot.data()['totalRatings'] ?? 0,
      location1: snapshot.data()['location1'] ?? "",
      location2: snapshot.data()['location2'] ?? "",
      city: snapshot.data()['city'] ?? "",
      conditionsTreated: snapshot.data()['conditionsTreated'] ?? [],
      study: snapshot.data()['study'] ?? "",
    );
  }

  // get brews stream
  Stream<List<DoctorData>> get doctors {
    return doctorsCollection.snapshots().map(_doctorListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<DoctorData> doctorData(doctorId) {
    return doctorsCollection
        .doc(doctorId)
        .snapshots()
        .map(_doctorDataFromSnapshot);
  }
}
