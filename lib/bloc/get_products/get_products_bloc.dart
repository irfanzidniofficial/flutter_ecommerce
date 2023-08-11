
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/data/models/response/list_product_response_model.dart';


part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  GetProductsBloc() : super(GetProductsInitial()) {
    on<DoGetProductsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
