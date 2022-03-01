import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/page/page_cubit.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-up', (route) => false);
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: kRedColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          }
          return CustomBottom(
            title: 'Sign Out',
            width: 220,
            onPressed: () {
              context.read<AuthCubit>().signOut();
              context.read<PageCubit>().setPage(0);
            },
          );
        },
      ),
    );
  }
}
