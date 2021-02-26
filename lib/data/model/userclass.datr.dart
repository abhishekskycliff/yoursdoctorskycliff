class UserAuth {
  String user;
  String password;

  UserAuth({this.user, this.password});

  UserAuth.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['password'] = this.password;
    return data;
  }
}