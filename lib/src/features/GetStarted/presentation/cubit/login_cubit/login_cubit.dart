import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pkd_app/src/features/GetStarted/data/models/auth_req.dart';
import 'package:pkd_app/src/features/GetStarted/data/models/auth_res.dart';
import 'package:pkd_app/src/features/GetStarted/domain/repositories/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final LoginRepo _loginRepo = LoginRepo();
  void login(AuthReq req) async {
    emit(LoginuserLoading());
    var res = await _loginRepo.login(req);
    res.fold((l) => emit(LoginuserError(l.message)), (r) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool("ISLOGGED_IN_KEY", true);
      prefs.setString("USER_ID", r.docs[0].id);

      emit(LoginuserSuccess(r));
    });
  }
}
