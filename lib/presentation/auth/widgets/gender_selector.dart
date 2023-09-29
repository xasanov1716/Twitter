import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/cubits/user_data/user_data_cubit.dart';
import 'package:twitter/data/models/user/user_field_keys.dart';
import 'package:twitter/utils/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    String gender = context
        .watch<UserDataCubit>()
        .state
        .userModel
        .gender;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ZoomTapAnimation(
          onTap: (){
            context.read<UserDataCubit>().updateCurrentUserField(
              fieldKey: UserFieldKeys.gender,
              value: "male",
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 60,width: 70,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: gender == "male" ? AppColors.c_3669C9 : AppColors.white),
              child: Center(
                child: Text(
                  "MALE",
                  style: TextStyle(
                      color: gender == "male" ? AppColors.white : AppColors.black),
                ),
              ),
          ),
        ),
        ZoomTapAnimation(
          onTap: (){
            context.read<UserDataCubit>().updateCurrentUserField(
              fieldKey: UserFieldKeys.gender,
              value: "female",
            );
          },
          child: Container(
            height: 60,width: 70,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: gender == "female" ? AppColors.c_3669C9 : AppColors.white),
            child: Center(
              child: Text(
                "Female",
                style: TextStyle(
                    color: gender == "female" ? AppColors.white : AppColors.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}
