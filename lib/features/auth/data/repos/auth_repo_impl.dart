import 'package:dartz/dartz.dart';
import 'package:fake_store/constant.dart';
import 'package:fake_store/core/api/api_services.dart';
import 'package:fake_store/core/api/end_points.dart';
import 'package:fake_store/core/errors/exception.dart';
import 'package:fake_store/core/services/fire_store_service.dart';
import 'package:fake_store/core/services/firebase_auth_service.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/auth/data/repos/auth_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final FireStoreService fireStoreService = FireStoreService();
  @override
  Future<Either<String, void>> login({
    required String userName,
    required String password,
  }) async {
    try {
      // var res = await ApiServices.post(
      //   path: EndPoints.login,
      //   body: {ApiKeys.userName: userName, ApiKeys.password: password},
      // );
      var user = await fireStoreService.getData(
        path: users,
        userName: userName,
      );
      print(user);
      if (user.isEmpty) throw Exception('not found user');
      var res = await firebaseAuthService.signInWithEmailAndPassword(
        emailAddress: user['email'],
        password: password,
      );

      return right(null);
    } on ServerException catch (e) {
      return left(e.message);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signUp(
    BuildContext context, {
    required UserModel user,
  }) async {
    try {
      // await ApiServices.post(path: EndPoints.signUp, body: user.toJson());
      var res = await firebaseAuthService.createUserWithEmailAndPassword(
        email: user.email ?? '',
        password: user.password ?? '',
      );
      context.read<UserModel>().uId = res.uid;
      await fireStoreService.addData(
        path: users,
        id: res.uid,
        data: {
          'email': res.email,
          'password': user.password,
          'uid': res.uid,
          'username': user.name,
        },
      );
      return right(null);
    } on ServerException catch (e) {
      return left(e.message);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> getSingleUser({required int uId}) async {
    try {
      var res = await ApiServices.get(path: '${EndPoints.users}/$uId');
      return right(UserModel.fromJson(res));
    } on ServerException catch (e) {
      return left(e.message);
    }
  }
}
