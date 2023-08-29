

import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ecommerce/data/models/request/order_request_model.dart';
import 'package:flutter_ecommerce/data/models/response/list_order_response.model.dart';

import '../../common/global_variables.dart';
import 'package:http/http.dart' as http;

import '../models/response/order_response_model.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel model) async {
    final tokenJwt = await AuthLocalDatasource().getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/api/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenJwt'
      },
      body: model.toRawJson(),
    );

    if (response.statusCode == 200) {
      return Right(
        OrderResponseModel.fromJson(response.body),
      );
    } else {
      return const Left("Server Error");
    }
  }

  Future<Either<String, ListOrderResponseModel>> listOrder() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
          '$baseUrl/api/orders?filters[userId][\$eq]=${authData.user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData.jwt}'
      },
    );

    if (response.statusCode == 200) {
      return Right(
        ListOrderResponseModel.fromJson(response.body),
      );
    } else {
      return const Left("Server Error");
    }
  }
}
