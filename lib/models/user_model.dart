//User Model
class UserModel {
  final String name;
  final String accessToken;

  UserModel(
      {required this.accessToken,
        required this.name});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      accessToken: data['access_token'],
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {"token": accessToken, "name": name};
}