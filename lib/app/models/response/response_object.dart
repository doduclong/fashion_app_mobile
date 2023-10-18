class ResponseObject<T>{
  int? code;
  String? message;
  T? data;

  ResponseObject({
    this.code,
    this.message,
    this.data,
  });

  factory ResponseObject.fromJson(Map<String, dynamic> json) {
    return ResponseObject(
        code : json["code"],
        message : json["message"],
        data : json["data"]);
  }

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data': data,
  };
}