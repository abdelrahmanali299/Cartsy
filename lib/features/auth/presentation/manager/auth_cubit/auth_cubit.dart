import 'dart:convert';
import 'dart:developer';
import 'package:fake_store/constant.dart';
import 'package:fake_store/core/api/end_points.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class AuthCubit extends Cubit<AuthState> {
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    log(change.toString());
  }

  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String userName,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoading());

    var res = await AuthRepoImpl().login(
      userName: userName,
      password: password,
    );

    res.fold((l) => emit(LoginFailure(l)), (r) {
      emit(LoginSuccess());
    });
  }

  Future<void> signUp(BuildContext context) async {
    emit(SignUpLoading());
    UserModel user = context.read<UserModel>();
    var res = await AuthRepoImpl().signUp(context, user: user);
    res.fold((l) => emit(SignUpFailure(l)), (r) {
      String userJson = jsonEncode(user.toJson());
      SharedPreferencesSinglton.setString(setUser, userJson);

      emit(SignUpSuccess());
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  validate({required BuildContext context, required Function() onTap}) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      onTap();
      emit(ValidateSuccess());
    } else {
      autovalidateMode = AutovalidateMode.always;
      emit(ValidateFailure());
    }
  }
}
