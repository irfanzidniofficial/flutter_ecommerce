import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/data/models/response/list_product_response_model.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutSuccess(items: [])) {
    on<AddtoCartEvent>((event, emit) {
      final currentState = state as CheckoutSuccess;
      emit(CheckoutLoading());
      emit(CheckoutSuccess(items: [...currentState.items, event.product]));
    });

    on<RemoveFromCartEvent>((event, emit) {
      final currentState = state as CheckoutSuccess;
      currentState.items.remove(event.product);
      emit(CheckoutLoading());
      emit(CheckoutSuccess(items: currentState.items));
    });
  }
}
