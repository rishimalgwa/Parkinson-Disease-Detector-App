import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pkd_app/src/features/GetStarted/data/models/auth_req.dart';
import 'package:pkd_app/src/features/GetStarted/domain/repositories/signup_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/auth_res.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  final SignupRepo _signupRepo = SignupRepo();
  void signup(AuthReq req) async {
    emit(SignupLoading());
    var res = await _signupRepo.signup(req);
    res.fold((l) => emit(SignupError(l.message)), (r) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool("ISLOGGED_IN_KEY", true);
      prefs.setString("USER_ID", r.docs[0].id);

      emit(SignupSuccess(r));
    });
  }
}
