import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:twitter/cubits/auth/auth_cubit.dart';
import 'package:twitter/cubits/user_data/user_data_cubit.dart';
import 'package:twitter/data/models/user/user_field_keys.dart';
import 'package:twitter/presentation/auth/widgets/gender_selector.dart';
import 'package:twitter/presentation/auth/widgets/global_button.dart';
import 'package:twitter/presentation/auth/widgets/global_text_fields.dart';
import 'package:twitter/presentation/auth/widgets/phone_number_text_field_.dart';
import 'package:twitter/utils/colors/app_colors.dart';

import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();


  String phone = '';

  var maskFormatter = MaskTextInputFormatter(
      mask: '## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.c_0C1A30,
        appBar: AppBar(
          title: const Text("Sign Up Page"),
          backgroundColor: AppColors.c_0C1A30,
          elevation: 0,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 12),
                GlobalTextField(
                  prefixIcon: Icons.person,
                  hintText: "Username",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  onChanged: (v){
                    context.read<UserDataCubit>().updateCurrentUserField(fieldKey: UserFieldKeys.username, value: v);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                PhoneTextField(
                  maskFormaters: maskFormatter,
                  focusNode: focusNode,
                  prefixIcon: Icons.call,
                  hintText: "Phone",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  onChanged: (v){
                  phone = v;
                    if(v.length == 12){
                      focusNode.unfocus();
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GlobalTextField(
                  prefixIcon: Icons.email,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  onChanged: (v){
                    context.read<UserDataCubit>().updateCurrentUserField(fieldKey: UserFieldKeys.email, value: v);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GlobalTextField(
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  onChanged: (v){
                    context.read<UserDataCubit>().updateCurrentUserField(fieldKey: UserFieldKeys.password, value: v);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GlobalTextField(
                  prefixIcon: Icons.work,
                  hintText: "Profession",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v){
                    context.read<UserDataCubit>().updateCurrentUserField(fieldKey: UserFieldKeys.profession, value: v);
                  },
                ),
                const SizedBox(height: 20),
                const GenderSelector(),
                if (context.read<UserDataCubit>().state.userModel.avatar.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Image.file(
                        File(
                          context.read<UserDataCubit>().state.userModel.avatar,
                        ),fit: BoxFit.cover,
                      ),
                    ),
                  ),
                TextButton(
                    onPressed: () {
                      showBottomSheetDialog();
                    },
                    child: const Text("Select avatar image")),
                const SizedBox(height: 20),
                GlobalButton(
                    title: "Register",
                    onTap: () {
                      context.read<UserDataCubit>().updateCurrentUserField(fieldKey: UserFieldKeys.contact, value: phone.replaceAll(" ", ''));
                      debugPrint(context.read<UserDataCubit>().state.userModel.contact);
                      if (context.read<UserDataCubit>().canRegister()) {
                        context.read<AuthCubit>().sendCodeToGmail(
                          context.read<UserDataCubit>().state.userModel.email,
                          context.read<UserDataCubit>().state.userModel.password,
                        );
                      }else{
                        showErrorMessage(message: "Maydonlar to'liq emas", context: context);
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.loginScreen);
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                            color: AppColors.passiveTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }, listener: (context, state) {
          if (state is AuthSendCodeSuccessState) {
            Navigator.pushNamed(
              context,
              RouteNames.confirmGmail,
              arguments: context.read<UserDataCubit>().state.userModel,
            );
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        }),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt,color: AppColors.passiveTextColor,),
                title: const Text("Select from Camera",style: TextStyle(color: AppColors.passiveTextColor),),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo,color: AppColors.passiveTextColor,),
                title: const Text("Select from Gallery",style: TextStyle(color: AppColors.passiveTextColor),),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
        fieldKey: UserFieldKeys.avatar,
        value: xFile.path,
      );
      setState(() {

      });
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
        fieldKey: UserFieldKeys.avatar,
        value: xFile.path,
      );
      setState(() {

      });
    }
  }
}
