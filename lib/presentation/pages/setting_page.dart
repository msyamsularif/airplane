import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/page/page_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/option_item.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget photoProfile() {
      return Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.only(top: 30, bottom: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kPrimaryColor, width: 2),
                        image: const DecorationImage(
                          image: AssetImage('assets/image_profile.png'),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 105,
                            top: 110,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      state.user.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      state.user.email,
                      style: greyTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );
    }

    Widget menuSettings() {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.65,
        margin: const EdgeInsets.only(top: 30),
        padding: EdgeInsets.all(defaultMargin),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const OptionItem(
              icon: Icons.person,
              iconColor: Colors.greenAccent,
              title: 'Account',
            ),
            const OptionItem(
              icon: Icons.security_rounded,
              iconColor: Colors.redAccent,
              title: 'Privacy',
            ),
            const OptionItem(
              icon: Icons.help_center,
              iconColor: Colors.amberAccent,
              title: 'Help',
            ),
            const OptionItem(
              icon: Icons.info,
              iconColor: Colors.blueAccent,
              title: 'About',
            ),
            CustomBottom(
              margin: const EdgeInsets.only(top: 40, bottom: 30),
              title: 'Sign Out',
              onPressed: () => context.read<AuthCubit>().signOut(),
            ),
          ],
        ),
      );
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          context.read<PageCubit>().setPage(0);
          Navigator.pushNamedAndRemoveUntil(
              context, '/sign-in', (route) => false);
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
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                photoProfile(),
                menuSettings(),
              ],
            ),
          ),
        );
      },
    );
  }
}
