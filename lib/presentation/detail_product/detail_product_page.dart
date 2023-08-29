// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/common/app_format.dart';
import 'package:flutter_ecommerce/common/custom_button.dart';
import 'package:flutter_ecommerce/common/theme.dart';
import 'package:badges/badges.dart' as badges;

import 'package:flutter_ecommerce/data/models/response/list_product_response_model.dart';

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
      backgroundColor: whiteColor,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: whiteColor,
            elevation: 1,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: greyColor.withOpacity(0.5),
                      child: Icon(
                        Icons.arrow_back,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      if (state is CheckoutError) {
                        return const Center(
                          child: Text("Data Error"),
                        );
                      }
                      if (state is CheckoutSuccess) {
                        return CircleAvatar(
                          radius: 20,
                          backgroundColor: greyColor.withOpacity(0.5),
                          child: badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                                elevation: 0, badgeColor: pinkColor),
                            // elevation: 0,
                            badgeContent: Text(
                              '${state.items.length}',
                              style: whiteTextStyle,
                            ),
                            // badgeColor: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/cart');
                              },
                              child: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      }
                      return const Text("Loading");
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: greyColor.withOpacity(0.5),
                      child: Icon(
                        Icons.more_vert,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SliverList
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Image.network(
                  widget.product.attributes?.image ?? '',
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    widget.product.attributes?.name ?? '',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    AppFormat.longPrice(
                      widget.product.attributes?.price?.toInt() ?? 0,
                    ),
                    style: pinkTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.6),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    "Produk Description",
                    style: blackTextStyle.copyWith(
                        fontSize: 18, fontWeight: semiBold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    widget.product.attributes?.description ?? '',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border(
            top: BorderSide(
              color: greyColor.withOpacity(0.5),
            ),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: greyColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black45,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BlocConsumer<CheckoutBloc, CheckoutState>(
                    listener: (context, state) {
                      if (state is CheckoutSuccess) {
                        Navigator.pushNamed(context, '/cart');
                      }
                    },
                    builder: (context, state) {
                      if (state is CheckoutLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomFilledButton(
                        height: 45,
                        radius: 8,
                        title: 'Buy',
                        onPressed: () {
                          context.read<CheckoutBloc>().add(
                                AddtoCartEvent(
                                  product: widget.product,
                                ),
                              );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    //
  }
}
