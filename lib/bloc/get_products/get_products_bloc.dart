// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecommerce/data/datasource/product_remote_datasource.dart';
import 'package:flutter_ecommerce/data/models/response/list_product_response_model.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final ProductRemoteDataSource datasource;
  GetProductsBloc(
    this.datasource,
  ) : super(GetProductsInitial()) {
    on<DoGetProductsEvent>((event, emit) async {
      emit(GetProductsLoading());
      final result = await datasource.getAllProduct();
      result.fold(
        (l) => emit(GetProductsError()),
        (r) => emit(GetProductsSuccess(data: r)),
      );
    });
  }
}
