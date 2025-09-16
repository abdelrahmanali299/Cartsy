part of 'get_single_user_cubit.dart';

@immutable
abstract class GetSingleUserState {}

class GetSingleUserInitial extends GetSingleUserState {}

class GetSingleUserLoading extends GetSingleUserState {}

class GetSingleUserSuccess extends GetSingleUserState {
  final UserModel userModel;
  GetSingleUserSuccess({required this.userModel});
}

class GetSingleUserFailure extends GetSingleUserState {
  final String errorMessage;
  GetSingleUserFailure({required this.errorMessage});
}
