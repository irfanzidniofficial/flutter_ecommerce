import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/bloc/get_products/get_products_bloc.dart';

import '../../../data/models/response/list_product_response_model.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({super.key});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  @override
  void initState() {
    context.read<GetProductsBloc>().add(DoGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsBloc, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsError) {
          return const Text("Get Product Error");
        }

        if (state is GetProductsSuccess) {
          if (state.data.data!.isEmpty) {
            return const Center(
              child: Text(
                "Data Empty",
              ),
            );
          }
          return GridView.builder(
            itemCount: state.data.data!.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final Product product = state.data.data![index];
              return Card(
                elevation: 2,
                shadowColor: const Color(0xFFEE4D2D),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: product.attributes!.image!,
                      child: SizedBox(
                        height: 150,
                        child: Image.network(
                          product.attributes!.image!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      product.attributes!.price!.toString(),
                      style: const TextStyle(
                        color: Color(0xFFEE4D2D),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${product.attributes!.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  size: 18,
                                  color: Color(0xffEE4D2D),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Beli",
                                  style: TextStyle(
                                    color: Color(0xffEE4D2D),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.read<CheckoutBloc>().add(
                                          RemoveFromCartEvent(
                                            product: product,
                                          ),
                                        );
                                  },
                                  child: const Icon(
                                    Icons.remove_circle_outline,
                                    size: 18,
                                    color: Color(0xffEE4D2D),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child:
                                      BlocBuilder<CheckoutBloc, CheckoutState>(
                                    builder: (context, state) {
                                      if (state is CheckoutSuccess) {
                                        final countItem = state.items
                                            .where((element) =>
                                                element.id == product.id)
                                            .length;
                                        return Text('$countItem');
                                      }
                                      return const Text('0');
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.read<CheckoutBloc>().add(
                                          AddtoCartEvent(product: product),
                                        );
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline,
                                    size: 18,
                                    color: Color(0xffEE4D2D),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
