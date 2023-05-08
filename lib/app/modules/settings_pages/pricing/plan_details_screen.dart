import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/controller/plan_details_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../../../global_widgets/helper_text.dart';
import 'component/payment_card_card.dart';

class PlanDetailsScreen extends GetView<PlanDetailsController> {
  const PlanDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().simpleAppBar("Plan Details"),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(1, 1))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upgrade Plan",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            "Price",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text("${controller.planModel?.planName} - ${controller.getPlanType()}"),
                          ),
                          Text("\$${controller.getMainPrice()}.00"),
                        ],
                      ),
                      const Divider(
                        height: 30,
                      ),
                      Visibility(
                        visible: controller.planModel!.discountPercentage > 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Text("Discount"),
                            ),
                            Text("${controller.planModel?.discountPercentage}%"),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.planModel!.discountPercentage > 0,
                        child: const Divider(
                          height: 30,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Text("Total Payable"),
                          ),
                          Text("\$${controller.getDiscountPrice().toStringAsFixed(2)}"),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            sliver: SliverToBoxAdapter(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(1, 1))
                      ]),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Upgrade Plan",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Name"),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomEditText().boxEditText(
                            controller.nameController,
                            '',
                            "Name",
                            Helper.validationAverage,
                            TextInputType.text,
                            ashColor),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Email Address"),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomEditText().boxEditText(
                            controller.emailController,
                            '',
                            "Email",
                            Helper.validationEmail,
                            TextInputType.emailAddress,
                            ashColor),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Billing Address"),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomEditText().boxEditText(
                            controller.billingAddressController,
                            '',
                            "Billing Address",
                            Helper.validationAverage,
                            TextInputType.emailAddress,
                            ashColor),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Billing City"),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomEditText().boxEditText(
                            controller.billingCityController,
                            '',
                            "Billing City",
                            Helper.validationAverage,
                            TextInputType.emailAddress,
                            ashColor),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Billing State"),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomEditText().boxEditText(
                            controller.billingStateController,
                            '',
                            "Billing State",
                            Helper.validationAverage,
                            TextInputType.emailAddress,
                            ashColor),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Billing ZipCode"),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomEditText().boxEditText(
                            controller.billingZipCodeController,
                            '',
                            "Billing Zipcode",
                            Helper.validationAverage,
                            TextInputType.emailAddress,
                            ashColor),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Billing Country"),
                        const SizedBox(
                          height: 8,
                        ),
                        TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: controller.billingCountryController,
                            onTap: () {
                              controller.billingCountryController.text = '';
                              controller.changeFlag('');
                            },
                            decoration: InputDecoration(
                              hintText: 'Country',
                              hintStyle: const TextStyle(color: Colors.black45),
                              filled: true,
                              prefixIcon:
                                  Obx(() => controller.selectedFlag.value == ''
                                      ? const SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Image.asset(
                                            "assets/flags/${controller.selectedFlag.value.toLowerCase()}.png",
                                            height: 24,
                                            width: 35,
                                          ),
                                        )),
                              fillColor: ashColor,
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                            ),
                          ),
                          suggestionsCallback: (pattern) {
                            return controller.allCountry
                                .where((element) => element.name
                                    .toLowerCase()
                                    .contains(pattern.toString().toLowerCase()))
                                .take(10)
                                .toList();
                            // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.name),
                              leading: Image.asset(
                                'assets/flags/${suggestion.code.toLowerCase()}.png',
                                height: 30,
                                width: 40,
                              ),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (Country suggestion) {
                            controller.billingCountryController.text =
                                suggestion.name;
                            controller.changeFlag(suggestion.code);
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'Select Country';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {},
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Type"),
                        const SizedBox(
                          height: 8,
                        ),
                        DropdownButtonFormField<String>(
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            filled: true,
                            fillColor: ashColor,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                          ),
                          value: "Personal",
                          items: ["Personal", "Bussiness"]
                              .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ))
                              .toList(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        HelperText().redNormalText("Billing Phone"),
                        const SizedBox(
                          height: 8,
                        ),
                        IntlPhoneField(
                          controller: controller.billingPhoneController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            fillColor: ashColor,
                            filled: true,
                            labelText: '',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                          ),
                          initialCountryCode: 'BD',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.number.isEmpty) {
                              return 'Enter Phone Number';
                            }
                            return null;
                          },
                          onCountryChanged: (country) {
                            controller.changeCountryCode(country.dialCode);
                          },
                          onChanged: (phone) {

                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        PaymentMethodCard(
                          title: 'Pay with Card',
                          icon: KImages.stripeIcon,
                          onPress: () {
                            if (!controller.formKey.currentState!.validate()) {
                              return;
                            }
                            controller.makePaymentData();
                            // stripeService.makePayment(
                            //     context,
                            //     widget.pricingModel.price,
                            //     "USD",
                            //     state.gatewaysResponseModel.response,
                            //     widget.pricingModel
                            // );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          )
        ],
      ),
    );
  }
}
