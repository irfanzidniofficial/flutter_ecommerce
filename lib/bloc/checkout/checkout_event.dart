// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class AddtoCartEvent extends CheckoutEvent {
  final Product product;
  AddtoCartEvent({
    required this.product,
  });
}

class RemoveFromCartEvent extends CheckoutEvent {
  final Product product;
  RemoveFromCartEvent({
    required this.product,
  });
}
