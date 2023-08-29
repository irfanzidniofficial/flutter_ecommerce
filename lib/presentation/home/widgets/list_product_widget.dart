import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_ecommerce/common/app_format.dart';
import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/presentation/detail_product/detail_product_page.dart';

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
            physics: const PageScrollPhysics(),
            shrinkWrap: true,
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
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailProductPage(product: product);
                      },
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  shadowColor: const Color(0xFFEE4D2D),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Hero(
                          tag: product.attributes!.image!,
                          child: SizedBox(
                            child: Image.network(
                              product.attributes!.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        AppFormat.longPrice(
                          product.attributes!.price!.toInt(),
                        ),
                        style: TextStyle(
                          color: pinkColor,
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
                        maxLines: 1,
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
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    size: 18,
                                    color: pinkColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Buy",
                                    style: TextStyle(
                                      color: pinkColor,
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
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      size: 18,
                                      color: pinkColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: BlocBuilder<CheckoutBloc,
                                        CheckoutState>(
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
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      size: 18,
                                      color: pinkColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    ],
                  ),
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
