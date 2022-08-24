import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/shared_user.dart';
import '../../../data/shared/shared_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      HttpServices services = HttpServices();
      final AppUser appUser =
          await services.login(email: email, password: password);
      SharedServices.addUser(
          user: SharedUser(id: appUser.id, email: email, password: password));
      emit(LoginSucceed(appUser: appUser));
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
    }
  }
}
