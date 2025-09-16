import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fake_store/core/api/end_points.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/auth/data/repos/auth_repo_impl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  @override
  void onChange(Change<GetSingleUserState> change) {
    log(change.toString());
    super.onChange(change);
  }

  GetSingleUserCubit() : super(GetSingleUserInitial());
  UserModel user = UserModel();
  getSingleUser() async {
    emit(GetSingleUserLoading());
    var token = SharedPreferencesSinglton.getString(ApiKeys.token);
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    var id = decodedToken['sub'];
    var res = await AuthRepoImpl().getSingleUser(uId: id);
    res.fold((l) => emit(GetSingleUserFailure(errorMessage: l)), (r) {
      user = r;
      print('naammmmmmmmmmmmmmmmme${user.name}');
      emit(GetSingleUserSuccess(userModel: r));
    });
  }
}
