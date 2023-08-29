import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/common/app_format.dart';
import 'package:flutter_ecommerce/common/custom_button.dart';

import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/data/datasource/auth_local_datasource.dart';

import 'package:flutter_ecommerce/presentation/auth/login_page.dart';
import 'package:flutter_ecommerce/presentation/checkout/checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: Column(
        children: [
          // Widget List Order
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutSuccess) {
                final uniqItem = state.items.toSet().length;
                final dataSet = state.items.toSet();
                return Expanded(
                  child: ListView.builder(
                    itemCount: uniqItem,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    dataSet.elementAt(index).attributes!.image!,
                                    fit: BoxFit.fitWidth,
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Text(
                                        '${dataSet.elementAt(index).attributes!.name}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 2),
                                      child: Text(
                                        AppFormat.longPrice(dataSet
                                            .elementAt(index)
                                            .attributes!
                                            .price!
                                            .toInt()),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        bottom: 8,
                                      ),
                                      child: const Text(
                                        'In Stock',
                                        style: TextStyle(
                                          color: Colors.teal,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black12,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.black12,
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<CheckoutBloc>()
                                                        .add(
                                                          RemoveFromCartEvent(
                                                            product: dataSet
                                                                .elementAt(
                                                                    index),
                                                          ),
                                                        );
                                                  },
                                                  child: Container(
                                                    width: 35,
                                                    height: 32,
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black12,
                                                        width: 1.5),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  child: Container(
                                                    width: 35,
                                                    height: 32,
                                                    alignment: Alignment.center,
                                                    child: BlocBuilder<
                                                        CheckoutBloc,
                                                        CheckoutState>(
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is CheckoutSuccess) {
                                                          final countItem = state
                                                              .items
                                                              .where((element) =>
                                                                  element.id ==
                                                                  dataSet
                                                                      .elementAt(
                                                                          index)
                                                                      .id)
                                                              .length;
                                                          return Text(
                                                              '$countItem');
                                                        }
                                                        return const Text('0');
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<CheckoutBloc>()
                                                        .add(
                                                          AddtoCartEvent(
                                                              product: dataSet
                                                                  .elementAt(
                                                                      index)),
                                                        );
                                                  },
                                                  child: Container(
                                                    width: 35,
                                                    height: 32,
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return const Text("Loading");
            },
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
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    'Total: ',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    if (state is CheckoutSuccess) {
                      final total = state.items.fold(
                        0,
                        (sum, item) => sum + item.attributes!.price!,
                      );
                      return Text(
                        AppFormat.longPrice(total),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return const Text(
                      'Calculate..',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const Spacer(),
                // Bottom Chekout

                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomFilledButton(
                    width: 150,
                    height: 50,
                    radius: 8,
                    title: 'Checkout',
                    onPressed: () async {
                      final isLogin = await AuthLocalDatasource().isLogin();
                      if (isLogin) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CheckoutPage();
                            },
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginPage();
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}
