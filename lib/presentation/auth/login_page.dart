import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/login/login_bloc.dart';
import 'package:flutter_ecommerce/common/custom_button.dart';
import 'package:flutter_ecommerce/common/custom_formfield.dart';
import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ecommerce/data/models/request/login_request_model.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 120,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/icons/ic_logo_pink.png',
                      width: 45,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sheluxe",
                      style: pinkTextStyle.copyWith(
                        fontSize: 28,
                        fontWeight: black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Explore the Latest Trends",
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        controller: _emailController,
                        title: 'Email',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        obscureText: true,
                        controller: _passwordController,
                        title: 'Password',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) async {
                          if (state is LoginSuccess) {
                            await AuthLocalDatasource()
                                .saveAuthData(state.model);
                            Navigator.pushNamed(context, '/');
                          }
                          if (state is LoginError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: redColor,
                                content: const Text("Login Gagal"),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CustomFilledButton(
                            title: 'Login',
                            onPressed: () {
                              if (_loginFormKey.currentState!.validate()) {
                                final model = LoginRequestModel(
                                  identifier: _emailController.text,
                                  password: _passwordController.text,
                                );
                                context.read<LoginBloc>().add(
                                      DoLoginEvent(
                                        model: model,
                                      ),
                                    );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet? ?",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        "Daftar",
                        style: pinkTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: CustomTextButton(
                  width: 180,
                  title: "Continue as Guest",
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
