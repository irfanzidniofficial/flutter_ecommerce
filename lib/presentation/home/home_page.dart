import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/common/theme.dart';


import 'package:flutter_ecommerce/presentation/home/widgets/banner_widget.dart';
import 'package:flutter_ecommerce/presentation/home/widgets/list_category_widget.dart';
import 'package:flutter_ecommerce/presentation/home/widgets/list_product_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_ecommerce/presentation/search/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: pinkColor,
            elevation: 1,
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
                                return SearchPage(
                                    search: searchController.text);
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
                            Navigator.pushNamed(context, '/cart');
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
            expandedHeight: 160,
            flexibleSpace: const FlexibleSpaceBar(
              background: BannerWidget(),
            ),
          ),

          // Widget Normal
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    makeupAndSkincareWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column makeupAndSkincareWidget() {
    return Column(
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
    );
  }
}
