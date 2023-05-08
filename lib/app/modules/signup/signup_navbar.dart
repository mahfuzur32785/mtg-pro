import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupNavBar extends StatelessWidget {
  const SignupNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.grey.withOpacity(0.2),
        //       blurRadius: 6,
        //       offset: const Offset(0, 1)
        //   ),
        //   BoxShadow(
        //       color: Colors.grey.withOpacity(0.2),
        //       blurRadius: 6,
        //       offset: const Offset(0, 1)
        //   ),
        // ]
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?",style: TextStyle(color: AppColors.ashTextColor),),
            SizedBox(
              height: 40,
              child: TextButton(
                onPressed:  (){
                  Get.back();
                },
                child: Text("Sign In",style: TextStyle(color: AppColors.mainColor),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
