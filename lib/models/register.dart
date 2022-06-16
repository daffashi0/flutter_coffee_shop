class Register {
  int? code;
  bool? status;
  String? data;

  Register({this.code, this.status, this.data});

  factory Register.fromJson(Map<String, dynamic> obj) {
    return Register(
      code: obj['code'],
      status: obj['status'],
      data: obj['data'],
    );
  }
}
