class BaseModel<T> {
  T? data;
  String? code;
  String? msg;

  BaseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    code = json['code'];
    msg = json['msg'];
  }
}
