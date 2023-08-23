import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderResponseModel {
  String token;
  String redirectUrl;
  OrderResponseModel({
    required this.token,
    required this.redirectUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'redirectUrl': redirectUrl,
    };
  }

  factory OrderResponseModel.fromMap(Map<String, dynamic> map) {
    return OrderResponseModel(
      token: map['token'] ?? '',
      redirectUrl: map['redirect_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResponseModel.fromJson(String source) =>
      OrderResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
