import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:twitter/data/models/universal_data.dart';
import 'package:twitter/data/models/user/user_model.dart';
import 'package:twitter/data/repositories/profile_repository.dart';
import 'package:twitter/service/service_locator.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  final ProfileRepository profileRepository;

  getUserData() async {
    emit(ProfileLoadingState());
    UniversalData response = await profileRepository.getUserData();
    if (response.error.isEmpty) {
      emit(ProfileSuccessState(userModel: response.data as UserModel));
    } else {
      emit(ProfileErrorState(errorText: response.error));
    }
  }
}
