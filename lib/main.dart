import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_ecommerce/bloc/list_order/list_order_bloc.dart';
import 'package:flutter_ecommerce/bloc/login/login_bloc.dart';
import 'package:flutter_ecommerce/bloc/order/order_bloc.dart';
import 'package:flutter_ecommerce/bloc/register/register_bloc.dart';
import 'package:flutter_ecommerce/bloc/search/search_bloc.dart';
import 'package:flutter_ecommerce/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_ecommerce/data/datasource/order_remote_datasource.dart';
import 'package:flutter_ecommerce/data/datasource/product_remote_datasource.dart';
import 'package:flutter_ecommerce/presentation/home/home_page.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductsBloc(
            ProductRemoteDataSource(),
          ),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => OrderBloc(
            OrderRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(
            (AuthRemoteDatasource()),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            (ProductRemoteDataSource()),
          ),
        ),
        BlocProvider(
          create: (context) => ListOrderBloc(
            (OrderRemoteDatasource()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
