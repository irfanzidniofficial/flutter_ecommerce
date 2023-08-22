// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce/data/models/response/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce/data/datasource/order_remote_datasource.dart';

import '../../data/models/request/order_request_model.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource datasource;
  OrderBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_DoOrder>((event, emit) async {
      emit(const _$_Loading());
      final result = await datasource.order(event.model);
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Success(r)),
      );
    });
  }
}
