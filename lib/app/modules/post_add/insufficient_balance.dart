import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsufficientBalanceScreen extends StatelessWidget {
  const InsufficientBalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().colorAppBar("Insufficient Balance",AppColors.mainColor,false),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.money_off_rounded,size: 60,color: AppColors.mainColor,),
            const SizedBox(
              height: 10,
            ),
            Text("Insufficient Fund",style: TextStyle(color: AppColors.mainColor,fontSize: 22,fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 10,
            ),
            Text("You don't have enough fund to cover your \npayment you have initiated. Your ad will not \npublish until your payment.",
              textAlign: TextAlign.center,style: TextStyle(color: AppColors.textColor,fontSize: 14,fontWeight: FontWeight.w400),),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 30),
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                onPressed: (){
                  // Get.toNamed(Routes.postAdSuccess);
                },
                child: const Text("Add Money",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
