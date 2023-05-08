import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/data/enums/state_status.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/controller/subscription_controller.dart';

import '../../../../animation/custom_delayed_animation.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../global_widgets/custom_edittext.dart';

class BillingInfoCard extends GetView<SubscriptionController> {
  const BillingInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.billingStateStatus == StateStatus.LOADING
        ? const SizedBox()
        : CustomDelayedAnimation(
            delay: 150,
            dx: 0,
            dy: -0.1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(-5, -5)),
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(5, 5)),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Billing Information",
                        style: GoogleFonts.merriweatherSans(),
                      ),
                      const Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        onPressed: () {
                          showUpdateDialog(context);
                        },
                        child: const Text("Edit"),
                      ),
                      // GestureDetector(
                      //     onTap: (){
                      //
                      //     },
                      //     child: const Text("Edit",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),)
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Country : ${controller.billingCountry.value}"),
                  Text("Email : ${controller.billingEmail.value}"),
                  Text("Zip Code : ${controller.billingZipCode.value}"),
                ],
              ),
            ),
          ));
  }

  void showUpdateDialog(context){
    final formKey = GlobalKey<FormState>();
    var emailController = TextEditingController(text: controller.billingEmailController.text);
    var countryController = TextEditingController(text: controller.billingCountryController.text);
    var zipcodeController = TextEditingController(text: controller.billingZipCodeController.text);

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Billing Details"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomEditText().boxEditText(emailController,
                  '',
                  "Email",
                  Helper.validationEmail,
                  TextInputType.emailAddress, Colors.white,),
              const SizedBox(
                height: 16,
              ),
              // CustomEditText().boxEditText(countryController,
              //     '',
              //     "Country",
              //     Helper.validationEmail,
              //     TextInputType.emailAddress, ashColor),
              // const SizedBox(
              //   height: 16,
              // ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: countryController,
                    onTap: (){
                      countryController.text = '';
                    },
                    decoration: InputDecoration(
                      hintText: 'Country',
                      hintStyle: const TextStyle(color: Colors.black45),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
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
                    )
                ),

                suggestionsCallback: (pattern) {
                  return controller.allCountry.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                  // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.name),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (Country suggestion) {
                  countryController.text = suggestion.name;
                },
                validator: (value) {
                  if (value == '') {
                    return 'Select Country';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {

                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomEditText().boxEditText(zipcodeController,
                  '',
                  "Zipcode",
                  Helper.validationAverage,
                  TextInputType.number, Colors.white,),
              const SizedBox(
                height: 16,
                width: double.infinity,
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.mainColor),
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,foregroundColor: Colors.white),
            onPressed: (){
              if (!formKey.currentState!.validate()) {
                return;
              }
              Navigator.pop(context);
              controller.updateBillingInfo(emailController.text, countryController.text, zipcodeController.text);
            },
            child: const Text("Save Changes"),
          ),
        ],
      ),
    );
  }

}
