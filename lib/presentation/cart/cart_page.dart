import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/common/app_format.dart';
import 'package:flutter_ecommerce/common/global_variables.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ecommerce/presentation/account/account_page.dart';

import 'package:flutter_ecommerce/presentation/auth/login_page.dart';
import 'package:flutter_ecommerce/presentation/checkout/checkout_page.dart';
import 'package:flutter_ecommerce/presentation/home/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int page = 2;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  'Subtotal ',
                  style: TextStyle(
                    fontSize: 20,
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final isLogin = await AuthLocalDatasource().isLogin();
                if (isLogin) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CheckoutPage();
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
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xffEE4D2D),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 5),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: (index) {},
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: const Icon(
                  Icons.home_outlined,
                ),
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AccountPage();
                      },
                    ),
                  );
                },
                child: const Icon(
                  Icons.person_outline_outlined,
                ),
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutError) {
                    return const Center(
                      child: Text("Data Error"),
                    );
                  }
                  if (state is CheckoutSuccess) {
                    return badges.Badge(
                      badgeStyle: const badges.BadgeStyle(
                          elevation: 0, badgeColor: Colors.white),
                      // elevation: 0,
                      badgeContent: Text(
                        '${state.items.length}',
                        style: pinkTextStyle,
                      ),
                      // badgeColor: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const CartPage();
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                        ),
                      ),
                    );
                  }
                  return const Text("Loading");
                },
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
