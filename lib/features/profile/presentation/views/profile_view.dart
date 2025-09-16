import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/profile/presentation/manager/cubits/get_single_user/get_single_user_cubit.dart';
import 'package:fake_store/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<GetSingleUserCubit>(context),
      child: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if (state is GetSingleUserFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is GetSingleUserSuccess) {
            return ProfileViewBody(userModel: state.userModel);
          } else {
            {
              return Skeletonizer(
                child: ProfileViewBody(
                  userModel: UserModel(
                    name: 'asdfasdfad',
                    email: 'safddsf',
                    password: 'sdafsd',
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
