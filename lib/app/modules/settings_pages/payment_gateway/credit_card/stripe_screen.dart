import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/data/enums/state_status.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import 'package:mtgpro/app/modules/settings_pages/payment_gateway/credit_card/controller/credit_card_controller.dart';

import '../../../../core/values/colors.dart';
import '../../../../global_widgets/primary_button.dart';

class StripeScreen extends GetView<CreditCardController> {
  const StripeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.mainColor,
              ),
            ),
          ),
          Positioned(
            top: 0,
            // left: 40,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: AppColors.mainColor,
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: 0,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.mainColor,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: -60,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: AppColors.mainColor,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.6,
            // left: -60,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: AppColors.mainColor,
              ),
            ),
          ),
          DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainColor.withOpacity(0.93),
                    // AppColors.mainColor.withOpacity(0.93),
                    Colors.white,
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                )
            ),
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  CreditCardWidget(
                    glassmorphismConfig: controller.useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                    cardNumber: controller.cardNumber,
                    expiryDate: controller.expiryDate,
                    cardHolderName: controller.cardHolderName,
                    cvvCode: controller.cvvCode,
                    showBackView: controller.isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.purple,
                    backgroundImage:
                    controller.useBackgroundImage ? KImages.paymentCardIcon : null,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[
                      CustomCardTypeIcon(
                        cardType: CardType.mastercard,
                        cardImage: Image.asset(
                          KImages.paymentMastercardIcon,
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                  CreditCardForm(
                    formKey: controller.formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: controller.cardNumber,
                    cvvCode: controller.cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: controller.cardHolderName,
                    expiryDate: controller.expiryDate,
                    themeColor: Colors.blue,
                    textColor: Colors.white,
                    cardNumberDecoration: InputDecoration(
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: controller.border,
                      enabledBorder: controller.border,
                    ),
                    expiryDateDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: controller.border,
                      enabledBorder: controller.border,
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: controller.border,
                      enabledBorder: controller.border,
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: controller.border,
                      enabledBorder: controller.border,
                      labelText: 'Card Holder',
                    ),
                    onCreditCardModelChange: controller.onCreditCardModelChange,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Obx(() => controller.stateStatus == StateStatus.LOADING ? const PageLoader() : PrimaryButton(
                      text: "Pay",
                      onPressed: () {
                        if (!controller.formKey.currentState!.validate()) {
                          return;
                        }
                        controller.callStripePayment();
                      },
                    )
                    ),
                  ),
                  const SizedBox(
                    height: 300,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
