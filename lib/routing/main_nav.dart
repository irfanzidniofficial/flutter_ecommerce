import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/bottom_nav/bottom_nav_cubit.dart';
import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/presentation/account/account_page.dart';
import 'package:flutter_ecommerce/presentation/notification/notification_page.dart';
import 'package:flutter_ecommerce/presentation/home/home_page.dart';
import 'package:flutter_ecommerce/presentation/transaction/transaction_page.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  final List<IconData> bottomNavIcons = [
    Icons.home,
    Icons.reorder_rounded,
    Icons.notifications,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavCubit, int>(builder: (context, state) {
        if (state == 0) {
          return const HomePage();
        } else if (state == 1) {
          return const TransactionPage();
        } else if (state == 2) {
          return const NotificationPage();
        } else if (state == 3) {
          return const AccountPage();
        } else {
          return const HomePage();
        }
      }),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return AnimatedBottomNavigationBar(
            shadow: BoxShadow(
              color: pinkColor,
            ),
            elevation: 20,
            borderColor: greyColor,
            borderWidth: 1,
            leftCornerRadius: 25,
            rightCornerRadius: 25,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.softEdge,
            icons: bottomNavIcons,
            activeIndex: state,
            onTap: (int index) {
              context.read<BottomNavCubit>().changePage(index);
            },
            activeColor: pinkColor,
            inactiveColor: greyColor,
          );
        },
      ),
    );
  }
}
