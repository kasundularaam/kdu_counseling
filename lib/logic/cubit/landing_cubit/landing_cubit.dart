import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/shared_user.dart';
import '../../../data/shared/shared_services.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(LandingInitial());

  Future loadApp() async {
    try {
      emit(LandingLoading());
      await Future.delayed(const Duration(seconds: 2));
      final bool isUserIn = await SharedServices.isUserIn();
      if (isUserIn) {
        final SharedUser sharedUser = await SharedServices.getUser();
        HttpServices services = HttpServices();
        final AppUser appUser = await services.login(
            email: sharedUser.email, password: sharedUser.password);
        emit(LandingToHome(appUser: appUser));
      } else {
        emit(LandingToAuth());
      }
    } catch (e) {
      emit(LandingFailed(errorMsg: e.toString()));
    }
  }
}
