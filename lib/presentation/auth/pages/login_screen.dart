import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:twitter/cubits/auth/auth_cubit.dart';
import 'package:twitter/cubits/profile/profile_cubit.dart';
import 'package:twitter/presentation/auth/widgets/global_button.dart';
import 'package:twitter/presentation/auth/widgets/global_text_fields.dart';
import 'package:twitter/utils/colors/app_colors.dart';

import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.c_0C1A30,
        appBar: AppBar(
          backgroundColor: AppColors.c_0C1A30,
          elevation: 0,
          title: Text("Login Screen"),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  const SizedBox(height: 24),
                  GlobalTextField(
                    prefixIcon: Icons.email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    onChanged: (v){
                      email = v;
                    }
                  ),
                  SizedBox(height: 16,),
                  GlobalTextField(
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.start,
                  onChanged: (v){
                      password = v;
                  },
                  ),
                  SizedBox(height: 18,),
                  GlobalButton(
                      title: ("Login"),
                      onTap: () {
                        if(email.isNotEmpty && password.isNotEmpty) {
                          context.read<AuthCubit>().loginUser(
                            gmail: email,
                            password: password,
                          );
                        }
                      }),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.registerScreen);
                    },
                    child: const Text(
                      "Sign Up",
                      style:  TextStyle(
                          color: AppColors.passiveTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is AuthLoggedState) {
              context.read<ProfileCubit>().getUserData();
              Navigator.pushReplacementNamed(context, RouteNames.tabBox);
            }
            if (state is AuthErrorState) {
              showErrorMessage(message: state.errorText, context: context);
            }
          },
        ),
      ),
    );
  }
}
