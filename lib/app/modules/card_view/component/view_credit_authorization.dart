import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtgpro/app/core/values/strings.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/colors.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../controller/card_view_controller.dart';
import '../model/card_preview_model.dart';

class ViewCreditAuthorizationDialog {
  static creditAuthorization(context,CardPreviewModel cardPreviewModel,){

    var formatter = DateFormat("MM/dd/yyyy");
    final CardViewController controller = Get.find();

    final formKey = GlobalKey<FormState>();
    var nameCtr = TextEditingController();
    var applicantsNameCtr = TextEditingController();
    var socialSecurityCtr = TextEditingController();
    var dobCtr = TextEditingController();
    var currentStreetAddressCtr = TextEditingController();
    var cityCtr = TextEditingController();
    var stateCtr = TextEditingController();
    var moveInDateCtr = TextEditingController();
    var priorStreetAddressCtr = TextEditingController();
    var priorCityCtr = TextEditingController();
    var priorStateCtr = TextEditingController();
    var priorMoveInDateCtr = TextEditingController();
    var priorMoveOutDateCtr = TextEditingController();
    var driverLicenseCtr = TextEditingController();
    var licenseStateCtr = TextEditingController();
    var signatureCtr = TextEditingController();
    var applicationDateCtr = TextEditingController(text: formatter.format(DateTime.now()));

    bool isLoading = false;

    return showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 3,
        // isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
        ),
        builder: (context){
          return DraggableScrollableSheet(
              initialChildSize: 0.9,
              maxChildSize: 0.9,
              minChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return StatefulBuilder(
                    builder: (context, setState) {
                      return CustomScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 16,
                            ),
                          ),
                          const SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            sliver: SliverToBoxAdapter(
                              child: Center(child: Text("CREDIT REPORT AUTHORIZATION FORM",style: TextStyle(fontSize: 18,),)),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 16,
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                            sliver: SliverToBoxAdapter(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("By my signature below I,",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.bold),),
                                    CustomEditText().normalEditText(nameCtr,
                                      '',
                                      "",
                                      Helper.validationAverage,
                                      TextInputType.text,),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Authorize Rony",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.bold),),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const SizedBox(
                                      child: Text(creditAuthorizationText,textAlign: TextAlign.start,style: TextStyle(color: Colors.black54,fontSize: 13,
                                          fontWeight: FontWeight.normal),),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    CustomEditText().boxEditText(applicantsNameCtr,
                                        '',
                                        "Applicant's Name",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Applicant's Name",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Social Security Number",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(socialSecurityCtr,
                                        '',
                                        "Social Security Number",
                                        Helper.validationPhone,
                                        TextInputType.number, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Date Of Birth",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    TextFormField(
                                      validator: Helper.validationAverage,
                                      controller: dobCtr,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.datetime,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                      maxLines: 1,
                                      readOnly: true,
                                      onTap: ()async {
                                        await Utils.chooseDate(context).then((value) {
                                          if (value != null) {
                                            dobCtr.text = formatter.format(value);
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 13),
                                        hintText: "Date Of Birth",
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
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text("Provide Address for the last 7 Years",textAlign: TextAlign.start,style: TextStyle(fontSize: 15,),),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Current Street Address",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(currentStreetAddressCtr,
                                        '',
                                        "Current Street Address",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("City",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(cityCtr,
                                        '',
                                        "City",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("State",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(stateCtr,
                                        '',
                                        "State",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white,maxLines: 1),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Move In Date",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    TextFormField(
                                      validator: Helper.validationAverage,
                                      controller: moveInDateCtr,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.datetime,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                      maxLines: 1,
                                      readOnly: true,
                                      onTap: ()async {
                                        await Utils.chooseDate(context).then((value) {
                                          if (value != null) {
                                            moveInDateCtr.text = formatter.format(value);
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 13),
                                        hintText: "Move In Date",
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
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Prior Street Address",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(priorStreetAddressCtr,
                                        '',
                                        "Prior Street Address",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("City",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(priorCityCtr,
                                        '',
                                        "City",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("State",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(priorStateCtr,
                                        '',
                                        "State",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Move In Date",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    TextFormField(
                                      validator: Helper.validationAverage,
                                      controller: priorMoveInDateCtr,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.datetime,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                      maxLines: 1,
                                      readOnly: true,
                                      onTap: ()async {
                                        await Utils.chooseDate(context).then((value) {
                                          if (value != null) {
                                            priorMoveInDateCtr.text = formatter.format(value);
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 13),
                                        hintText: "Move In Date",
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
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Move Out Date",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    TextFormField(
                                      validator: Helper.validationAverage,
                                      controller: priorMoveOutDateCtr,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.datetime,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                      maxLines: 1,
                                      readOnly: true,
                                      onTap: ()async {
                                        await Utils.chooseDate(context).then((value) {
                                          if (value != null) {
                                            priorMoveOutDateCtr.text = formatter.format(value);
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 13),
                                        hintText: "Move Out Date",
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
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Driver's License#",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(driverLicenseCtr,
                                        "",
                                        "Driver's License#",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("State",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(licenseStateCtr,
                                        '',
                                        "State",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Signature",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(signatureCtr,
                                        '',
                                        "Signature",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Date",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    TextFormField(
                                      validator: Helper.validationAverage,
                                      controller: applicationDateCtr,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.datetime,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                      maxLines: 1,
                                      readOnly: true,
                                      onTap: ()async {
                                        await Utils.chooseDate(context).then((value) {
                                          if (value != null) {
                                            applicationDateCtr.text = formatter.format(value);
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 13),
                                        hintText: "Date",
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
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),

                                    LayoutBuilder(
                                        builder: (context,constraints) {
                                          if (isLoading == true) {
                                            return Center(
                                              child: SizedBox(
                                                  height: 30,width: 30,
                                                  child: CircularProgressIndicator(color: AppColors.mainColor,strokeWidth: 3,)),
                                            );
                                          }
                                          return Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,
                                                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                                                  foregroundColor: Colors.white),
                                              onPressed: () async {
                                                if (!formKey.currentState!.validate()) {
                                                  return;
                                                }

                                                Utils.closeKeyBoard(context);
                                                final body = <String, dynamic>{};
                                                body.addAll({"name": nameCtr.text.trim()});
                                                body.addAll({"applicant_name": applicantsNameCtr.text.trim()});
                                                body.addAll({"social_security_number": socialSecurityCtr.text.trim()});
                                                body.addAll({"date_of_birth": dobCtr.text.trim()});
                                                body.addAll({"current_street": currentStreetAddressCtr.text.trim()});
                                                body.addAll({"current_city": cityCtr.text.trim()});
                                                body.addAll({"current_state": stateCtr.text.trim()});
                                                body.addAll({"current_date": moveInDateCtr.text.trim()});
                                                body.addAll({"prior_address": priorStreetAddressCtr.text.trim()});
                                                body.addAll({"prior_city": priorCityCtr.text.trim()});
                                                body.addAll({"prior_state": priorStateCtr.text.trim()});
                                                body.addAll({"prior_start_date": priorMoveInDateCtr.text.trim()});
                                                body.addAll({"prior_end_date": priorMoveOutDateCtr.text.trim()});
                                                body.addAll({"license": driverLicenseCtr.text.trim()});
                                                body.addAll({"license_state": licenseStateCtr.text.trim()});
                                                body.addAll({"signature": signatureCtr.text.trim()});
                                                body.addAll({"signature_date": applicationDateCtr.text.trim()});
                                                body.addAll({"card_id": '${cardPreviewModel.id}'});

                                                setState(() {
                                                  isLoading = true;
                                                });

                                                final result = await controller.postCreditAuthorization(body);

                                                result.fold((error) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  Helper.toastMsg(error.message);
                                                }, (data) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  Helper.toastMsg(data);

                                                  nameCtr.text = '';
                                                  applicantsNameCtr.text = '';
                                                  socialSecurityCtr.text = '';
                                                  dobCtr.text = '';
                                                  currentStreetAddressCtr.text = '';
                                                  cityCtr.text = '';
                                                  stateCtr.text = '';
                                                  moveInDateCtr.text = '';
                                                  priorStreetAddressCtr.text = '';
                                                  priorCityCtr.text = '';
                                                  priorStateCtr.text = '';
                                                  priorMoveInDateCtr.text = '';
                                                  priorMoveOutDateCtr.text = '';
                                                  driverLicenseCtr.text = '';
                                                  licenseStateCtr.text = '';
                                                  signatureCtr.text = '';
                                                  applicationDateCtr.text = '';
                                                });
                                              },
                                              child: const Text("Submit"),
                                            ),
                                          );
                                        }
                                    ),
                                    const SizedBox(
                                      height: 300,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                );
              }
          );
        }
    );
  }
}