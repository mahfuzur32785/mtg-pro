import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/colors.dart';

class HelperText {
  headingText(String text){
    return Text(text,style: TextStyle(color: AppColors.textColor,fontSize: 22,fontWeight: FontWeight.w500),);
  }

  normalText(String text){
    return Text(text,style: TextStyle(color: AppColors.textColor,fontSize: 14,fontWeight: FontWeight.w400),);
  }

  boldText(String text){
    return Text(text,style: TextStyle(color: AppColors.textColor,fontSize: 14,fontWeight: FontWeight.w500),);
  }
  boldText18(String text){
    return Text(text,style: TextStyle(color: AppColors.textColor,fontSize: 18,fontWeight: FontWeight.w500),);
  }

  ashNormalText(String text){
    return Text(text,style: TextStyle(color: AppColors.ashTextColor,fontSize: 14,fontWeight: FontWeight.w400),);
  }
  ashSmallText(String text){
    return Text(text,style: TextStyle(color: AppColors.ashTextColor,fontSize: 12,fontWeight: FontWeight.w400),);
  }
  ashBoldText(String text){
    return Text(text,style: TextStyle(color: AppColors.ashTextColor,fontSize: 14,fontWeight: FontWeight.w500),);
  }

  ashNormalCenterText(String text){
    return Text(text,textAlign: TextAlign.center,style: TextStyle(color: AppColors.ashTextColor,fontSize: 14,fontWeight: FontWeight.w400),);
  }

  redNormalText(String text){
    return Text(text,style: TextStyle(color: AppColors.mainColor,fontSize: 14,fontWeight: FontWeight.w400),);
  }

  redHeadingText(String text){
    return Text(text,style: TextStyle(color: AppColors.mainColor,fontSize: 16,fontWeight: FontWeight.w500),);
  }

  headline(String text){
    return Text(text,style: Theme.of(Get.context!).textTheme.titleLarge,);
  }
}