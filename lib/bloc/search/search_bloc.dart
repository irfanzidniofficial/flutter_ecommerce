// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce/data/datasource/product_remote_datasource.dart';
import 'package:flutter_ecommerce/data/models/response/list_product_response_model.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRemoteDataSource dataSource;
  SearchBloc(
    this.dataSource,
  ) : super(const _Initial()) {
    on<_Search>((event, emit) async {
      final result = await dataSource.searchProduct(event.name);
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Success(r)),
      );
    });
  }
}
