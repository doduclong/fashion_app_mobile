class UserModel{
  int? id;
  String? username;
  String? role;
  String? fullName;
  String? birthday;
  String? email;
  String? phoneNumber;
  String? gender;

  UserModel({this.id, this.username, this.role, this.fullName, this.birthday, this.email,
      this.phoneNumber, this.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    role: json["role"],
    fullName: json["fullName"],
    birthday: json["birthday"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    gender: json["gender"],
  );
}