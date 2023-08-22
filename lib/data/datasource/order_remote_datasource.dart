import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce/data/models/response/auth_response_model.dart';

import '../../common/global_variables.dart';
import '../models/request/login_request_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/local'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: model.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(
        AuthResponseModel.fromJson(response.body),
      );
    } else {
      return const Left("Server Error");
    }
  }
}
