import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';

import '../core/utils/utils.dart';
import '../routes/routes.dart';

class CustomAppBar{
  simpleAppBar(String title){
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w400),),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),
      elevation: 0,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: Colors.black87),
      backgroundColor: Colors.white,
    );
  }

  createStepVcardAppBar(position){
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: index <= position ? Colors.red : Colors.black45),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${index+1}",style: TextStyle(color: index <= position ? Colors.red : Colors.black45),),
                  ),
                ),
              );
            })

          ],
        ),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),
      elevation: 0,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: Colors.black87),
      backgroundColor: Colors.white,
      actions: [
        GestureDetector(
          onTap: (){
            Utils.loadingDialog(Get.context!);
            Future.delayed(const Duration(seconds: 2)).then((value) async {
              Utils.closeDialog(Get.context!);
              await MySharedPreference.clearAll();
              Get.offAllNamed(Routes.login);
            });
          },
            child: const FaIcon(FontAwesomeIcons.arrowRightFromBracket)
        ),
        const SizedBox(width: 16,)
      ],
    );
  }

  colorAppBar(String title,Color color,bool isCenter){
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color,statusBarIconBrightness: Brightness.light),
      elevation: 0,
      titleSpacing: 0,
      centerTitle: isCenter,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: color,
    );
  }

  leadingIconAppBar(String title,Function onPressed,IconData icon){
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w400),),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(icon),
        onPressed: ()=> onPressed(),
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
      backgroundColor: Colors.white,
    );
  }

  // AppBar(
  // title: const Text("Bakery, Cakes & Dairy",style: TextStyle(color: Colors.white),),
  // centerTitle: true,
  // // backgroundColor: Colors.lightGreen,
  // iconTheme: const IconThemeData(color: Colors.white),
  // systemOverlayStyle: Platform.isIOS
  // ? SystemUiOverlayStyle.light
  //     : SystemUiOverlayStyle(
  // statusBarIconBrightness: Brightness.light,
  // statusBarColor: AppColors.mainColor),
  // ),
}