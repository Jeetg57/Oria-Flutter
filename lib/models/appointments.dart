class Appointment {
  final String appointmentId;
  final String doctorId;
  final String userId;
  final String approval;
  final DateTime bookedAt;
  final DateTime time;

  Appointment(
      {this.appointmentId,
      this.doctorId,
      this.userId,
      this.approval,
      this.bookedAt,
      this.time});
}
