import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce/common/global_variables.dart';

import '../models/response/list_product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDataSource {
  Future<Either<String, ListProductResponseModel>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/products'),
    );

    if (response.statusCode == 200) {
      return Right(
        ListProductResponseModel.fromJson(response.body),
      );
    } else {
      return const Left("Proses Gagal");
    }
  }

   Future<Either<String, ListProductResponseModel>> searchProduct(String name) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/products?filters[name][\$contains]=$name'),
    );

    if (response.statusCode == 200) {
      return Right(
        ListProductResponseModel.fromJson(response.body),
      );
    } else {
      return const Left("Proses Gagal");
    }
  }
}
