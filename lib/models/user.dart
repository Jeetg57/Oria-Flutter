class UserFB {
  final String uid;
  UserFB({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String birthdate;
  final String email;
  final String profilePicture;

  UserData(
      {this.uid, this.name, this.birthdate, this.email, this.profilePicture});
}
