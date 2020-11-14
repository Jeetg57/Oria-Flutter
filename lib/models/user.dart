class UserFB {
  final String uid;
  UserFB({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final birthdate;
  final String email;
  final String pictureLink;
  final joined;

  UserData(
      {this.uid,
      this.name,
      this.birthdate,
      this.email,
      this.pictureLink,
      this.joined});
}
