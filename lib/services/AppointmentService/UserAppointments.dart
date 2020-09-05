import 'package:cloud_firestore/cloud_firestore.dart';

class UserAppointments {
  userAppointmentData(userId, DateTime date) {
    final CollectionReference appointmentCollection =
        FirebaseFirestore.instance.collection('appointments');

    return appointmentCollection
        .where("userId", isEqualTo: userId)
        .where("time", isEqualTo: Timestamp.fromDate(date))
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    }).catchError((error) => print(error));
  }
}
