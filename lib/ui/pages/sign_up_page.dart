import 'package:airplane/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../widgets/custom_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          'Join us and get\nyour next journey',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return const CustomTextFormField(
          title: 'Full Name',
          hintText: 'Your full name',
        );
      }

      Widget emailInput() {
        return const CustomTextFormField(
          title: 'Email Address',
          hintText: 'Your email address',
        );
      }

      Widget passwordInput() {
        return const CustomTextFormField(
          title: 'Password',
          hintText: 'Your password',
          obscureText: true,
        );
      }

      Widget hobbyInput() {
        return const CustomTextFormField(
          title: 'Hobby',
          hintText: 'Your hobby',
        );
      }

      Widget submitButton() {
        return CustomBottom(
          title: 'Get Started',
          onPressed: () => Navigator.pushNamed(context, '/bonus'),
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          children: [
            nameInput(),
            emailInput(),
            passwordInput(),
            hobbyInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget tacButton() {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 50, bottom: 73),
        child: Text(
          'Terms and Conditions',
          style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            title(),
            inputSection(),
            tacButton(),
          ],
        ),
      ),
    );
  }
}
