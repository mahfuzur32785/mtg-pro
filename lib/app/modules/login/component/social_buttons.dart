import 'dart:io';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:mtgpro/app/core/values/colors.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        const Text("Or Signin with Social"),
        const SizedBox(
          height: 24,
        ),
        const SizedBox(width: double.infinity,),
        GoogleAuthButton(
          onPressed: () {},
          themeMode: ThemeMode.light,
          style: AuthButtonStyle(
            buttonColor: AppColors.mainColor,
              buttonType: AuthButtonType.secondary,
              elevation: 0,
              iconSize: 18,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: 40
              // iconType: AuthIconType.secondary,
              ),
        ),
        const SizedBox(width: 15),
        FacebookAuthButton(
          onPressed: () {},
          themeMode: ThemeMode.system,
          style: AuthButtonStyle(
              buttonColor: AppColors.mainColor,
              buttonType: AuthButtonType.secondary,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              iconColor: Colors.blue,
              elevation: 0,
              iconSize: 18,
              height: 40,
              width: 40
              // iconType: AuthIconType.secondary,
              ),
        ),
        const SizedBox(width: 15),
        Visibility(
          visible: Platform.isIOS,
          child: AppleAuthButton(
            onPressed: () {},
            themeMode: ThemeMode.system,
            style: const AuthButtonStyle(
                buttonType: AuthButtonType.secondary,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 10),
                iconSize: 18,
                height: 40,
                width: 40
              // iconType: AuthIconType.secondary,
            ),
          ),
        ),

      ],
    );
  }
}
