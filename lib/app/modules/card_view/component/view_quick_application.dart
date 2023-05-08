import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/colors.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../controller/card_view_controller.dart';
import '../model/card_preview_model.dart';

class ViewQuickApplicationDialog {
  static quickApplication(context,CardPreviewModel cardPreviewModel,){

    var formatter = DateFormat("MM/dd/yyyy");
    final CardViewController controller = Get.find();

    final formKey = GlobalKey<FormState>();
    var purchasePriceCtr = TextEditingController();
    var downPaymentCtr = TextEditingController();
    var propertyLocationCtr = TextEditingController();
    var companyNameCtr = TextEditingController();
    var occupationCtr = TextEditingController();
    var currentEmployeeCtr = TextEditingController();
    var annualIncomeCtr = TextEditingController();
    var creditScore = TextEditingController();
    var nameCtr = TextEditingController();
    var emailCtr = TextEditingController();
    var phoneCtr = TextEditingController();

    String purposeOfLoan = "Purchase";
    String typeOfProperty = "Single Family House";
    String agentGroup = 'Yes';

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
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Purpose of Mortgage or Loan",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Radio(
                                            value: "Purchase",
                                            groupValue: purposeOfLoan,
                                            onChanged: (value){
                                              setState((){
                                                purposeOfLoan = value!;
                                              });
                                        }),
                                        GestureDetector(
                                          onTap: (){
                                            setState((){
                                              purposeOfLoan = "Purchase";
                                            });
                                          },
                                            child: const Text("Purchase")),
                                        Radio(
                                            value: "Refinance",
                                            groupValue: purposeOfLoan,
                                            onChanged: (value){
                                              setState((){
                                                purposeOfLoan = value!;
                                              });
                                            }),
                                        GestureDetector(
                                            onTap: (){
                                              setState((){
                                                purposeOfLoan = "Refinance";
                                              });
                                            },child: const Text("Refinance"))
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Purchase Price",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(purchasePriceCtr,
                                        '',
                                        "Purchase Price",
                                        Helper.validationAverage,
                                        TextInputType.number, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Down Payment",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(downPaymentCtr,
                                        '',
                                        "Down Payment",
                                        Helper.validationAverage,
                                        TextInputType.number, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Type of Property",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        Radio(
                                            value: "Single Family House",
                                            groupValue: typeOfProperty,
                                            onChanged: (value){
                                              setState((){
                                                typeOfProperty = value!;
                                              });
                                            }),
                                        GestureDetector(
                                            onTap: (){
                                              setState((){
                                                typeOfProperty = "Single Family House";
                                              });
                                            },
                                            child: const Text("Single Family House",)),
                                        Radio(
                                            value: "2+ Unit House",
                                            groupValue: typeOfProperty,
                                            onChanged: (value){
                                              setState((){
                                                typeOfProperty = value!;
                                              });
                                            }),
                                        GestureDetector(
                                            onTap: (){
                                              setState((){
                                                typeOfProperty = "2+ Unit House";
                                              });
                                            },child: const Text("2+ Unit House",)),
                                        Radio(
                                            value: "Conodo / Co-Op",
                                            groupValue: typeOfProperty,
                                            onChanged: (value){
                                              setState((){
                                                typeOfProperty = value!;
                                              });
                                            }),
                                        GestureDetector(
                                            onTap: (){
                                              setState((){
                                                typeOfProperty = "Conodo / Co-Op";
                                              });
                                            },child: const Text("Conodo / Co-Op",)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Property Location",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(propertyLocationCtr,
                                        '',
                                        "Location",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),

                                    LayoutBuilder(
                                      builder: (p0, p1) {
                                        if (purposeOfLoan == "Purchase") {
                                          return const SizedBox();
                                        }
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(bottom: 6.0),
                                              child: Text("Current Mortgage Company",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                            ),
                                            CustomEditText().boxEditText(companyNameCtr,
                                                '',
                                                "Company Name",
                                                Helper.validationAverage,
                                                TextInputType.text, Colors.white),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Would you like a Referral to a Real Estate Agent?",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Radio(
                                            value: "Yes",
                                            groupValue: agentGroup,
                                            onChanged: (value){
                                              setState((){
                                                agentGroup = value!;
                                              });
                                            }),
                                        GestureDetector(
                                            onTap: (){
                                              setState((){
                                                agentGroup = "Yes";
                                              });
                                            },
                                            child: const Text("Yes")),
                                        Radio(
                                            value: "No",
                                            groupValue: agentGroup,
                                            onChanged: (value){
                                              setState((){
                                                agentGroup = value!;
                                              });
                                            }),
                                        GestureDetector(
                                            onTap: (){
                                              setState((){
                                                agentGroup = "No";
                                              });
                                            },child: const Text("No"))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Occupation",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(occupationCtr,
                                        '',
                                        "Occupation",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("How long have your been employed by your current emmployer?",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(currentEmployeeCtr,
                                        '',
                                        "ex: 90 days",
                                        Helper.validationAverage,
                                        TextInputType.number, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Annual Income",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(annualIncomeCtr,
                                        '',
                                        "Annual Income",
                                        Helper.validationAverage,
                                        TextInputType.number, Colors.white,maxLines: 1),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Credit Score",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(creditScore,
                                        '',
                                        "Credit Score",
                                        Helper.validationAverage,
                                        TextInputType.number, Colors.white,maxLines: 1),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Name",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(nameCtr,
                                        '',
                                        "Name",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Email",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(emailCtr,
                                        '',
                                        "Email",
                                        Helper.validationAverage,
                                        TextInputType.text, Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Phone",textAlign: TextAlign.start,style: TextStyle(fontSize: 14,),),
                                    ),
                                    CustomEditText().boxEditText(phoneCtr,
                                        '',
                                        "Phone",
                                        Helper.validationAverage,
                                        TextInputType.number, Colors.white,
                                      inputAction: TextInputAction.done
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
                                                  Helper.toastMsg("Fill All Field!");
                                                  return;
                                                }

                                                Utils.closeKeyBoard(context);
                                                final body = <String, dynamic>{};
                                                body.addAll({"name": ''});
                                                body.addAll({"contact_name": nameCtr.text.trim()});
                                                body.addAll({"contact_email": emailCtr.text.trim()});
                                                body.addAll({"contact_phone": phoneCtr.text.trim()});
                                                body.addAll({"price": purchasePriceCtr.text.trim()});
                                                body.addAll({"down_amount": downPaymentCtr.text.trim()});
                                                body.addAll({"location": propertyLocationCtr.text.trim()});
                                                body.addAll({"company": companyNameCtr.text.trim()});
                                                body.addAll({"occupation": occupationCtr.text.trim()});
                                                body.addAll({"current_employer": currentEmployeeCtr.text.trim()});
                                                body.addAll({"annual_income": annualIncomeCtr.text.trim()});
                                                body.addAll({"credit_score": creditScore.text.trim()});
                                                body.addAll({"purpose": purposeOfLoan});
                                                body.addAll({"property_type": typeOfProperty});
                                                body.addAll({"agent": agentGroup == "Yes" ? '1' : '0'});
                                                body.addAll({"card_id": '${cardPreviewModel.id}'});

                                                print(body);

                                                setState(() {
                                                  isLoading = true;
                                                });

                                                final result = await controller.postQuickApplication(body);

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

                                                  purchasePriceCtr.text = '';
                                                  downPaymentCtr.text = '';
                                                  propertyLocationCtr.text = '';
                                                  companyNameCtr.text = '';
                                                  occupationCtr.text = '';
                                                  currentEmployeeCtr.text = '';
                                                  annualIncomeCtr.text = '';
                                                  creditScore.text = '';
                                                  nameCtr.text = '';
                                                  emailCtr.text = '';
                                                  phoneCtr.text = '';
                                                });
                                              },
                                              child: const Text("Connect"),
                                            ),
                                          );
                                        }
                                    ),
                                    SizedBox(
                                      height: 300,
                                    )
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