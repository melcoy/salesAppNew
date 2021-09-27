import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/auth/auth_repo.dart';
import 'package:sales_app/models/auth/user_login.dart';
import 'package:sales_app/util/util.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  final ApiLoginRepo _apiLoginRepo = ApiLoginRepo();
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield AuthLoading();
      List<dynamic> result =
          await _apiLoginRepo.fetchUserLogin(event.email, event.password);
      if (result[0] == true) {
        print("MasukLogin");
        UserLogin login = result[1] as UserLogin;
        saveDataUser(login.session, login.id, login.pusat, login.cabang,
            login.subCabang);
        yield AuthSuccess(login, "Login Success");
      } else {
        yield AuthFailure(result[1].toString());
      }
    }
  }
}
