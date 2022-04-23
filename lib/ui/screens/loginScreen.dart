import 'package:cricket_mania/app/routes.dart';
import 'package:cricket_mania/cubits/authCubit.dart';
import 'package:cricket_mania/cubits/signInCubit.dart';
import 'package:cricket_mania/data/repositories/authRepository.dart';
import 'package:cricket_mania/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static Route<LoginScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider<SignInCubit>(
            child: const LoginScreen(),
            create: (_) => SignInCubit(AuthRepository())));
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();

  final TextEditingController _passwordEditingController =
      TextEditingController();

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  void signInUser() {
    if (_emailEditingController.text.trim().isEmpty) {
      //TODO: can add snackbar here
      return;
    }
    if (_passwordEditingController.text.trim().isEmpty) {
      //TODO: can add snackbar here
      return;
    }
    context.read<SignInCubit>().signInUser(
        email: _emailEditingController.text.trim(),
        password: _passwordEditingController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _emailEditingController,
                decoration: const InputDecoration(
                  hintText: "Enter email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _passwordEditingController,
                decoration: const InputDecoration(
                  hintText: "Enter password",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<SignInCubit, SignInState>(
              listener: (context, state) {
                //It work as callback function
                if (state is SignInSuccess) {
                  //change the auth state to authenticate
                  context.read<AuthCubit>().authenticateUser(
                      firebaseUId: state.firebaseUId, jwtToken: "jwtToken");

                  //navigate to home screen
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                } else if (state is SignInFailure) {
                  UIUtils.showSnackbar(context, state.errorMessage);
                }
              },
              builder: (context, state) {
                return MaterialButton(
                  child: Text(
                      state is SignInInProgress ? "Sign in...." : "Sign in"),
                  onPressed: () {
                    if (state is SignInInProgress) {
                      return;
                    }
                    signInUser();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
