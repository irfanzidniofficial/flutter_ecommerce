import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecommerce/bloc/list_order/list_order_bloc.dart';

import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ecommerce/data/models/response/auth_response_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? user;

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Logout Confirmation",
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            "Are you sure you want to logout?",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () async {
                await AuthLocalDatasource().removeAuthData();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getUser();
    context.read<ListOrderBloc>().add(const ListOrderEvent.get());
    super.initState();
  }

  Future<void> getUser() async {
    user = await AuthLocalDatasource().getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Account",
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                "https://media.licdn.com/dms/image/D5603AQGhovCQ9z2vlQ/profile-displayphoto-shrink_200_200/0/1677848744321?e=1698883200&v=beta&t=tUQlRTUY2jDYIq5XagpiYODEGXAQYwV__XvFCim12so",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            " ${user != null ? user!.username : '-'}",
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          Text(
            " ${user != null ? user!.email : '-'}",
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 6,
              ),
              leading: const Icon(
                Icons.storefront,
              ),
              title: Text(
                "Daftar Alamat",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              subtitle: Text(
                "Atur alamat pengiriman belanjaan",
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 6,
              ),
              leading: const Icon(
                Icons.payment,
              ),
              title: Text(
                "Rekening Bank",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              subtitle: Text(
                "Tarik Saldo Sheluxe ke rekning tujuan",
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 6,
              ),
              leading: const Icon(
                Icons.lock_outline,
              ),
              title: Text(
                "Keamanan Akun",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              subtitle: Text(
                "Kata sandi, PIN & verifikasi data diri",
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 6,
              ),
              leading: const Icon(
                Icons.notifications_outlined,
              ),
              title: Text(
                "Notifikasi",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              subtitle: Text(
                "Atur segala jenis pesan notifikasi",
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 6,
              ),
              leading: const Icon(
                Icons.language,
              ),
              title: Text(
                "Privasi Akun",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              subtitle: Text(
                "Atur penggunaan data",
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
          ),
          Divider(
            thickness: 8,
            color: greyColor.withOpacity(0.4),
          ),
          InkWell(
            onTap: () {
              _showLogoutConfirmationDialog();
            },
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              leading: const Icon(
                Icons.logout,
              ),
              title: Text(
                "Keluar Akun",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              trailing: Text(
                "Versi 0.0.1",
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 8,
            color: greyColor.withOpacity(0.4),
          )
        ],
      ),
    );
  }
}
