class Login {
  int? code;
  bool? status;
  String? token;
  int? userId;
  String? username;

  Login({this.code, this.status, this.token, this.userId, this.username});

  factory Login.fromJson(Map<String, dynamic> obj) {
    return Login(
      code: obj['code'],
      status: obj['status'],
      token: obj['data']['token'],
      userId: int.parse(obj['data']['user']['id']),
      username: obj['data']['user']['username'],
    );
  }
}
