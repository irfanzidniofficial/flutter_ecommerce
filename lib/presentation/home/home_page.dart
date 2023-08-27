import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/presentation/account/account_page.dart';
import 'package:flutter_ecommerce/presentation/cart/cart_page.dart';
import 'package:flutter_ecommerce/presentation/home/widgets/banner_widget.dart';
import 'package:flutter_ecommerce/presentation/home/widgets/list_category_widget.dart';
import 'package:flutter_ecommerce/presentation/home/widgets/list_product_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_ecommerce/presentation/search/search_page.dart';

import '../../common/global_variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: pinkColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SearchPage(search: searchController.text);
                            },
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                        ),
                        border: const OutlineInputBorder(
                          gapPadding: 10,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<CheckoutBloc, CheckoutState>(
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
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    );
                  }
                  return const Text("Loading");
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: false,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const BannerWidget(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Top Categories",
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListCategoryWidget(),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  "Popular Product",
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const ListProductWidget(),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  "Makeup & Skincare",
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.asset(
                      'assets/images/img_banner_mackup01.png',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/images/img_banner_mackup02.png',
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/images/img_banner_mackup03.png',
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
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
                    color: _page == 1
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
                    color: _page == 2
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
