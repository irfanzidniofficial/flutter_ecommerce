// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_products_bloc.dart';

abstract class GetProductsState {}

class GetProductsInitial extends GetProductsState {}

class GetProductsLoading extends GetProductsState {}

class GetProductsSuccess extends GetProductsState {
  
  ListProductResponseModel data;
  GetProductsSuccess({
    required this.data,
  });


}

final class GetProductsError extends GetProductsState {}
