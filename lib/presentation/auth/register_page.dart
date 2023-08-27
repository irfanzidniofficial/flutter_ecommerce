import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/register/register_bloc.dart';
import 'package:flutter_ecommerce/common/custom_button.dart';
import 'package:flutter_ecommerce/common/custom_formfield.dart';
import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ecommerce/data/models/request/register_request_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
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
                  "Ready to Shine? Sign Up!",
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
                  key: _registerFormKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        title: 'Nama',
                        controller: _nameController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        title: 'Username',
                        controller: _usernameController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        title: 'Email',
                        controller: _emailController,
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
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) async {
                          state.maybeWhen(
                            orElse: () {},
                            error: () {
                              const Text("Register Gagal");
                            },
                            success: (model) async {
                              await AuthLocalDatasource().saveAuthData(model);

                              Navigator.pushNamed(
                                context,
                                '/home',
                              );
                            },
                          );
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            orElse: () {
                              return CustomFilledButton(
                                title: 'Register',
                                onPressed: () {
                                  if (_registerFormKey.currentState!
                                      .validate()) {
                                    final requestModel = RegisterRequestModel(
                                      email: _emailController.text,
                                      name: _nameController.text,
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                    );
                                    context.read<RegisterBloc>().add(
                                        RegisterEvent.register(requestModel));
                                  }
                                },
                              );
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
                      "Already have an account ?",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Login",
                        style: pinkTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
