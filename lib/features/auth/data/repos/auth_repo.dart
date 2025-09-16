import 'package:dartz/dartz.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:flutter/widgets.dart';

abstract class AuthRepo {
  Future<Either<String, void>> login({
    required String userName,
    required String password,
  });
  Future<Either<String, void>> signUp(
    BuildContext context, {
    required UserModel user,
  });

  Future<Either<String, UserModel>> getSingleUser({required int uId});
}
