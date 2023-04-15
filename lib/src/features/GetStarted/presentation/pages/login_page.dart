import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkd_app/src/common/theme/app_colors.dart';
import 'package:pkd_app/src/features/Dashboard/presentation/pages/dashboard_screen.dart';
import 'package:pkd_app/src/features/GetStarted/data/models/auth_req.dart';
import 'package:pkd_app/src/features/GetStarted/presentation/cubit/login_cubit/login_cubit.dart';

import '../../../../core/widgets/snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit loginCubit = LoginCubit();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: loginCubit,
        listener: (context, state) {
          if (state is LoginuserError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackbar(state.error));
          }
          if (state is LoginuserSuccess) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DashboardPage(),
            ));
          }
        },
        builder: (context, state) {
          if (state is LoginuserLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryButtonColor,
              ),
            );
          } else if (state is LoginInitial) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 50),
                  const Placeholder(
                    fallbackHeight: 50,
                    fallbackWidth: 50,
                  ),
                  const SizedBox(height: 50),
                  Column(
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                  hintText: "Email",
                                  fillColor: Colors.white70),
                            ),
                            const SizedBox(height: 50),
                            TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                  hintText: "Password",
                                  fillColor: Colors.white70),
                            )
                          ])),
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AuthReq data = AuthReq(
                              email: emailController.text,
                              password: passwordController.text);
                          loginCubit.login(data);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.primaryButtonColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
