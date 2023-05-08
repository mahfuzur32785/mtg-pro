import 'package:flutter/material.dart';
import 'package:mtgpro/app/core/utils/constants.dart';

import '../core/values/colors.dart';

class CustomEditText {
  normalEditText(TextEditingController controller,String? text,String hintText,validator,TextInputType inputType){
    return TextFormField(
      validator: validator,
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: inputType,
      // inputFormatters: [
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      maxLines: 1,
      onSaved: (String? val) {
        text = val;
      },
      decoration: InputDecoration(
        // filled: true,
        // fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.ashTextColor,fontWeight: FontWeight.w400,fontSize: 14),
        // labelText: 'Email',
        // isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ashTextColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ashTextColor),
        ),
      ),
    );
  }

  normalEditText2(TextEditingController controller,String? text,String hintText,validator,TextInputType inputType,line){
    return TextFormField(
      validator: validator,
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: inputType,
      // inputFormatters: [
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      maxLines: line,
      onSaved: (String? val) {
        text = val;
      },
      decoration: InputDecoration(
        // filled: true,
        // fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.ashTextColor,fontWeight: FontWeight.w400,fontSize: 14),
        // labelText: 'Email',
        // isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ashTextColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ashTextColor),
        ),
      ),
    );
  }

  boxEditText(TextEditingController controller,String? text,String hintText,validator,
      TextInputType inputType,Color fillColor,
      {int maxLines = 1,
        TextInputAction inputAction = TextInputAction.next,
        bool readOnly = false,}){
    return TextFormField(
      validator: validator,
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      // inputFormatters: [
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      maxLines: maxLines,
      readOnly: readOnly,
      onSaved: (String? val) {
        text = val;
      },
      onTap: (){

      },
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 13),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.ashTextColor,fontWeight: FontWeight.w400,fontSize: 14),
        // labelText: 'Email',
        // isDense: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.transparent)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.red)
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.transparent)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: Colors.transparent)
        ),
      ),
    );
  }

  borderEditText(TextEditingController controller,String? text,String hintText,validator,
      TextInputType inputType,Color fillColor,
      {int maxLines = 1,
        TextInputAction inputAction = TextInputAction.next,
        bool readOnly = false}){
    return TextFormField(
      validator: validator,
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      // inputFormatters: [
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      maxLines: maxLines,
      readOnly: readOnly,
      onSaved: (String? val) {
        text = val;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 13),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.ashTextColor,fontWeight: FontWeight.w400,fontSize: 14),
        // labelText: 'Email',
        // isDense: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: ashColor)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.red)
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: ashColor)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: ashColor)
        ),
      ),
    );
  }

  passwordEditText(TextEditingController controller,String? text,String hintText,validator,TextInputType inputType){
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      // obscureText: controller.obscureText.value,
      textInputAction: TextInputAction.done,
      maxLines: 1,
      onSaved: (String? val) {
        text = val;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 0,vertical: 16),
        hintText: 'Password*',
        hintStyle: TextStyle(color: AppColors.ashTextColor),
        // labelText: 'Password*',
        isDense: true,
        suffixIcon: IconButton(
          onPressed: () {
            // controller.toggle();
          },
          // icon: controller.obscureText.value
          icon: false
              ? const Icon(
            Icons.visibility_off,
            color: Colors.black54,
          )
              : const Icon(
            Icons.visibility,
            color: Colors.black54,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ashTextColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ashTextColor),
        ),
      ),
    );
  }

}