// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/common/theme.dart';

import 'package:flutter_ecommerce/data/models/response/list_product_response_model.dart';
import 'package:flutter_ecommerce/presentation/cart/cart_page.dart';
import 'package:flutter_ecommerce/presentation/checkout/checkout_page.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.attributes?.name ?? '',
        ),
      ),
      body: ListView(
        children: [
          Image.network(
            widget.product.attributes?.image ?? '',
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.product.attributes?.name ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Rp. ${widget.product.attributes?.price}',
            style: pinkTextStyle.copyWith(
              fontSize: 20,
              fontWeight: bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Deskripsi Produk",
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.product.attributes?.description ?? '',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEE4D2D),
            ),
            onPressed: () {
              context.read<CheckoutBloc>().add(
                    AddtoCartEvent(
                      product: widget.product,
                    ),
                  );
            },
            child: BlocListener<CheckoutBloc, CheckoutState>(
              listener: (context, state) {
                if (state is CheckoutSuccess) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const CartPage();
                    },
                  ));
                }
              },
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Text(
                    "Beli",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
