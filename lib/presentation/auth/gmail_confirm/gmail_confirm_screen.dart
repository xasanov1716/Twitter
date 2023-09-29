// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:pinput/pinput.dart';
// import 'package:twitter/cubits/auth/auth_cubit.dart';
// import 'package:twitter/data/models/user/user_model.dart';
// import 'package:twitter/main.dart';
// import 'package:twitter/presentation/app_routes.dart';
// import 'package:twitter/presentation/auth/widgets/global_button.dart';
// import 'package:twitter/utils/colors/app_colors.dart';
// import 'package:twitter/utils/ui_utils/error_message_dialog.dart';
//
// class GmailConfirmScreen extends StatefulWidget {
//    const GmailConfirmScreen({super.key, required this.userModel});
//
//  final UserModel userModel;
//
//   @override
//   State<GmailConfirmScreen> createState() => _GmailConfirmScreenState();
// }
//
// class _GmailConfirmScreenState extends State<GmailConfirmScreen> {
//
//   final focusNode = FocusNode();
//   final formKey = GlobalKey<FormState>();
//
//   TextEditingController codeController = TextEditingController();
//
//   @override
//   void dispose() {
//     codeController.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
//     const fillColor = Color.fromRGBO(243, 246, 249, 0);
//     const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
//
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(19),
//         border: Border.all(color: borderColor),
//       ),
//     );
//
//     return KeyboardDismisser(
//       child: Scaffold(
//         backgroundColor: AppColors.c_0C1A30,
//         appBar: AppBar(
//           backgroundColor: AppColors.c_0C1A30,
//           elevation: 0,
//           title: Text('Confirm Code'),
//         ),
//         body: BlocConsumer<AuthCubit, AuthState>(
//           builder: (context, state) {
//             if (state is AuthLoadingState) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: Pinput(
//                       controller: codeController,
//                       length: 6,
//                       focusNode: focusNode,
//                       androidSmsAutofillMethod:
//                       AndroidSmsAutofillMethod.smsUserConsentApi,
//                       listenForMultipleSmsOnAndroid: true,
//                       defaultPinTheme: defaultPinTheme,
//                       separatorBuilder: (index) => const SizedBox(width: 8),
//                       hapticFeedbackType: HapticFeedbackType.lightImpact,
//                       onCompleted: (pin) {
//                         debugPrint('onCompleted: $pin');
//                       },
//                       onChanged: (value) {
//                         debugPrint('onChanged: $value');
//                       },
//                       cursor: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 9),
//                             width: 22,
//                             height: 1,
//                             color: focusedBorderColor,
//                           ),
//                         ],
//                       ),
//                       focusedPinTheme: defaultPinTheme.copyWith(
//                         decoration: defaultPinTheme.decoration!.copyWith(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: focusedBorderColor),
//                         ),
//                       ),
//                       submittedPinTheme: defaultPinTheme.copyWith(
//                         decoration: defaultPinTheme.decoration!.copyWith(
//                           color: fillColor,
//                           borderRadius: BorderRadius.circular(19),
//                           border: Border.all(color: focusedBorderColor),
//                         ),
//                       ),
//                       errorPinTheme: defaultPinTheme.copyBorderWith(
//                         border: Border.all(color: Colors.redAccent),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 32,),
//                   GlobalButton(title: 'Confirm', onTap: (){
//                     context.read<AuthCubit>().confirmGmail(codeController.text);
//                   })
//                 ],
//               ),
//             );
//           },
//           listener: (context, state) {
//             if (state is AuthConfirmCodeSuccessState) {
//               context.read<AuthCubit>().registerUser(widget.userModel);
//             }
//
//             if (state is AuthLoggedState) {
//               Navigator.pushReplacementNamed(context, RouteNames.tabBox);
//             }
//
//             if (state is AuthErrorState) {
//               showErrorMessage(message: state.errorText, context: context);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:twitter/cubits/auth/auth_cubit.dart';
import 'package:twitter/cubits/profile/profile_cubit.dart';
import 'package:twitter/cubits/user_data/user_data_cubit.dart';
import 'package:twitter/presentation/app_routes.dart';
import 'package:twitter/presentation/auth/widgets/global_button.dart';
import 'package:twitter/utils/colors/app_colors.dart';
import 'package:twitter/utils/ui_utils/error_message_dialog.dart';

import '../../../data/models/user/user_model.dart';

class GmailConfirmScreen extends StatefulWidget {
  GmailConfirmScreen({super.key, required this.userModel});

  UserModel userModel;

  @override
  State<GmailConfirmScreen> createState() => _GmailConfirmScreenState();
}

class _GmailConfirmScreenState extends State<GmailConfirmScreen> {
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.blue;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        backgroundColor: AppColors.c_0C1A30,
        centerTitle: true,
        title: const Text("Gmail Confirm Screen"),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Directionality(
                  // Specify direction if desired
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 6,
                    controller: pinController,
                    focusNode: focusNode,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              GlobalButton(
                title: "Confirm",
                onTap: () {
                  BlocProvider.of<ProfileCubit>(context).getUserData();
                  context.read<AuthCubit>().confirmGmail(pinController.text);
                },
              ),
              const SizedBox(height: 50)
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthConfirmCodeSuccessState) {
            context.read<AuthCubit>().registerUser(widget.userModel);
          }
          if (state is AuthLoggedState) {
            UserModel profile = context.read<UserDataCubit>().state.userModel;
            Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabBox,(c)=>false, arguments: profile);
            context.read<UserDataCubit>().clearData();
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}
