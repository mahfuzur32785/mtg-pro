import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_edittext.dart';

import 'create_card_controller.dart';

class CreateCardScreen extends StatelessWidget {
  CreateCardScreen({Key? key}) : super(key: key);
  CreateCardController gController = Get.put(CreateCardController());
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    }
    return GetBuilder<CreateCardController>(
      init: CreateCardController(),
      builder: (controller){
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("Create Card",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400),),
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),
              elevation: 0,
              titleSpacing: 0,
              iconTheme: const IconThemeData(color: Colors.black87),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              actions: [
                TextButton(
                  onPressed: (){},
                  child: Text("Save",style: TextStyle(color: AppColors.mainColor),),
                )
              ],
            ),
            body: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    key: controller.key,
                    child: Column(
                      children: [
                        // normalEditText(TextEditingController controller,String? text,String hintText,validator,TextInputType inputType)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          // child: ,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomEditText().normalEditText2(controller.cardNameController, controller.cardNameController.text,
                              "Card Name", Helper.validationAverage, TextInputType.text,1),
                        ),
                        // .............. Profile ....................
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 1.1,
                          child: Stack(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/woman.png"),
                                ),
                              ),
                              const Positioned(
                                top: 16,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  width: double.infinity,
                                    child: Text("Tap To choose picute or video",textAlign: TextAlign.center,)
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ...List.generate(18, (index){
                                        return Obx((){
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: controller.selectedColor.value == index ? Colors.grey.withOpacity(1) : Colors.transparent,
                                              child: CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.white,
                                                child: Material(
                                                  shape: const CircleBorder(),
                                                  color: Colors.primaries[index],
                                                  child: InkWell(
                                                    borderRadius: BorderRadius.circular(50),
                                                    onTap: (){
                                                      controller.changeColor(index);
                                                    },
                                                    child: SizedBox(
                                                      height: 24,
                                                      width: controller.selectedColor.value == index ? 26 : 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 65,
                                left: 0,
                                right: 0,
                                // child: SvgPicture.string(
                                //     "${controller.getSvg("da0000")}",
                                //     height: 100,
                                //     // width: double.infinity,
                                //     fit: BoxFit.fill,
                                // ),
                                child: SvgPicture.asset(
                                  height: 100,
                                  // width: double.infinity,
                                  fit: BoxFit.fill,
                                  color: Colors.primaries[controller.selectedColor.value],
                                  // "assets/images/waves_top.svg",),
                                  "assets/images/hihello_color.svg",),
                              ),
                              Positioned(
                                bottom: 65,
                                left: 0,
                                right: 0,
                                child: SvgPicture.asset(
                                  height: 100,
                                  // width: double.infinity,
                                  fit: BoxFit.fill,
                                  color: Colors.white,
                                  // "assets/images/waves_top.svg",),
                                  "assets/images/hihello_white.svg",),
                              ),
                            ],
                          ),
                        ),
                        // .............. Basic Info ....................
                        ExpandablePanel(
                          controller: controller.expandableController,
                          theme: const ExpandableThemeData(
                            collapseIcon: Icons.arrow_drop_up,
                            expandIcon: Icons.arrow_drop_down,
                            tapHeaderToExpand: true,
                            tapBodyToExpand: true,
                          ),
                          header: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextFormField(
                                  validator: Helper.validationAverage,
                                  controller: controller.fullNameController.value,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  readOnly: true,
                                  onTap: (){
                                    controller.expandableController.toggle();
                                  },
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  maxLines: 1,
                                  // onSaved: (String? val) {
                                  //   text = val;
                                  // },
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    hintText: "Full Name",
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
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                              //   child: Text(controller.fullNameController.value.text),
                              // ),
                              // const Divider(),
                            ],
                          ),
                          collapsed: const SizedBox(),
                          expanded: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  validator: Helper.validationAverage,
                                  controller: controller.prefixNameController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value){
                                    controller.makeFullName(value, controller.firstNameController.text,
                                        controller.middleNameController.text, controller.lastNameController.text, controller.suffixNameController.text);
                                  },
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  maxLines: 1,
                                  // onSaved: (String? val) {
                                  //   text = val;
                                  // },
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    hintText: "Prefix",
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
                                ),
                                // CustomEditText().normalEditText2(controller.prefixNameController, controller.prefixNameController.text,
                                //     "Prefix", Helper.validationAverage, TextInputType.text,1),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: Helper.validationAverage,
                                  controller: controller.firstNameController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value){
                                    controller.makeFullName(controller.prefixNameController.text, value,
                                        controller.middleNameController.text, controller.lastNameController.text, controller.suffixNameController.text);
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    hintText: "First Name",
                                    hintStyle: TextStyle(color: AppColors.ashTextColor,fontWeight: FontWeight.w400,fontSize: 14),
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
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: Helper.validationAverage,
                                  controller: controller.middleNameController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value){
                                    controller.makeFullName(controller.prefixNameController.text, controller.firstNameController.text,
                                        value, controller.lastNameController.text, controller.suffixNameController.text);
                                  },
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  maxLines: 1,
                                  // onSaved: (String? val) {
                                  //   text = val;
                                  // },
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    hintText: "Middle Name",
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
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: Helper.validationAverage,
                                  controller: controller.lastNameController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value){
                                    controller.makeFullName(controller.prefixNameController.text, controller.firstNameController.text,
                                        controller.middleNameController.text, value, controller.suffixNameController.text);
                                  },
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  maxLines: 1,
                                  // onSaved: (String? val) {
                                  //   text = val;
                                  // },
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    hintText: "Last Name",
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
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: Helper.validationAverage,
                                  controller: controller.suffixNameController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value){
                                    controller.makeFullName(controller.prefixNameController.text, controller.firstNameController.text,
                                        controller.middleNameController.text, controller.lastNameController.text, value);
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    hintText: "Suffix",
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        // .............. Company Info ....................
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomEditText().normalEditText2(controller.titleController, controller.cardNameController.text,
                                  "Title", Helper.validationAverage, TextInputType.text,1),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomEditText().normalEditText2(controller.departmentController, controller.cardNameController.text,
                                  "Department", Helper.validationAverage, TextInputType.text,1),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomEditText().normalEditText2(controller.companyController, controller.cardNameController.text,
                                  "Company", Helper.validationAverage, TextInputType.text,1),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomEditText().normalEditText2(controller.headlineController, controller.cardNameController.text,
                                  "Headline", Helper.validationAverage, TextInputType.multiline,3),
                            ],
                          ),
                        ),
                        // .............. Badge ....................
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                          ],
                        )
                        // .............. Social ...................
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
