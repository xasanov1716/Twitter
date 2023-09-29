
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter/cubits/auth/auth_cubit.dart';
import 'package:twitter/cubits/profile/profile_cubit.dart';
import 'package:twitter/utils/colors/app_colors.dart';
import 'package:twitter/utils/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.c_0C1A30,
        appBar: AppBar(
          backgroundColor: AppColors.c_0C1A30,
          title: const Text("Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  showLimitDialog(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return CupertinoActivityIndicator(
                radius: 15,
                color: AppColors.white,
              );
            }
            if (state is ProfileSuccessState) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: CachedNetworkImage(
                                imageUrl: baseUrlImage + state.userModel.avatar,
                                width: 90,
                                height: 90,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    CupertinoActivityIndicator(
                                  radius: 15,
                                  color: AppColors.white,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'UserName: ',
                                      style: TextStyle(
                                          fontSize: 18, color: AppColors.white),
                                      children: [
                                        TextSpan(
                                            text: state.userModel.username,
                                            style:  TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    AppColors.passiveTextColor))
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Email: ',
                                      style: TextStyle(
                                          fontSize: 16, color: AppColors.white),
                                      children: [
                                        TextSpan(
                                            text: state.userModel.email,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    AppColors.passiveTextColor))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: 60,
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Row(
                            children: [
                              Text(
                                'Phone Number: ',
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.white),
                              ),
                          Text('+998 ${state.userModel.contact}',style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.passiveTextColor),),
                            ],
                          )),
                        ),
                        const SizedBox(height: 8),
                        Divider(
                          thickness: 1,
                          color: AppColors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: 60,
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Profession: ',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.white),
                                  children: [
                                    TextSpan(
                                        text: state.userModel.profession,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.passiveTextColor))
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: 60,
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Role: ',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.white),
                                  children: [
                                    TextSpan(
                                        text: state.userModel.role,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.passiveTextColor))
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: 60,
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Gender: ',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.white),
                                  children: [
                                    TextSpan(
                                        text: state.userModel.gender,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.passiveTextColor))
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: Text('ERROR'),
            );
          },
          listener: (state, context) {},
        ));
  }

  void showLimitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Really delete it',
            style: TextStyle(color: Colors.deepPurple),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
            ),
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logOut();
                showMessage(context, 'User deleted');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    setState(() {});
  }
}
