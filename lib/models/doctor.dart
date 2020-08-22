import 'package:location/location.dart';

class DoctorData {
  final String id;
  final String name;
  final int appointmentPrice;
  final location;
  final String description;
  final int numRated;
  final int totalRatings;
  final String pictureLink;
  final int experience;
  final String speciality;

  DoctorData(
      {this.id,
      this.name,
      this.appointmentPrice,
      this.location,
      this.description,
      this.numRated,
      this.totalRatings,
      this.pictureLink,
      this.experience,
      this.speciality});
}
