import 'dart:convert';

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  late String message;
  late String error;
  late bool success;
  dynamic data;

  ResponseApi({
    String message = '',
    String error = '',
    bool success = true,
    dynamic data,
  })   : message = message,
        error = error,
        success = success,
        data = data;

  ResponseApi.fromJson(Map<String, dynamic> json)
      : message = json["message"] ?? '',
        error = json["error"] ?? '',
        success = json["success"] ?? true,
        data =  json['data'] ;

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "success": success,
    'data': data,
  };
}
