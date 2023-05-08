import 'package:mtgpro/app/animation/reflectly_screen.dart';
import 'package:mtgpro/app/modules/book/book_screen.dart';
import 'package:mtgpro/app/modules/book/invoke_call_screen.dart';
import 'package:mtgpro/app/modules/card_edit/binding.dart';
import 'package:mtgpro/app/modules/card_view/binding/card_preview_binding.dart';
import 'package:mtgpro/app/modules/card_view/card_view_screen.dart';
import 'package:mtgpro/app/modules/create_step_vcard/bindings/create_step_card_bindings.dart';
import 'package:mtgpro/app/modules/create_step_vcard/create_step_vcard_company.dart';
import 'package:mtgpro/app/modules/create_step_vcard/create_step_vcard_email.dart';
import 'package:mtgpro/app/modules/create_step_vcard/create_step_vcard_name.dart';
import 'package:mtgpro/app/modules/create_step_vcard/create_step_vcard_password.dart';
import 'package:mtgpro/app/modules/create_step_vcard/create_step_vcard_phone.dart';
import 'package:mtgpro/app/modules/create_step_vcard/create_step_vcard_photo.dart';
import 'package:mtgpro/app/modules/crm/binding/crm_binding.dart';
import 'package:mtgpro/app/modules/crm/crm_screen.dart';
import 'package:mtgpro/app/modules/crm/view_connection/binding/view_connection_binding.dart';
import 'package:mtgpro/app/modules/crm/view_connection/view_connection_screen.dart';
import 'package:mtgpro/app/modules/forgot_password/controller/forgot_pass_binding.dart';
import 'package:mtgpro/app/modules/forgot_password/forgot_password_screen.dart';
import 'package:mtgpro/app/modules/history/binding/card_view_history_binding.dart';
import 'package:mtgpro/app/modules/history/binding/contact_download_binding.dart';
import 'package:mtgpro/app/modules/history/binding/qr_download_history_binding.dart';
import 'package:mtgpro/app/modules/history/controller/card_qr_download_history.dart';
import 'package:mtgpro/app/modules/history/screen/card_qr_download_screen.dart';
import 'package:mtgpro/app/modules/history/screen/card_view_history_screen.dart';
import 'package:mtgpro/app/modules/history/screen/contact_download_history_screen.dart';
import 'package:mtgpro/app/modules/home/home_screen.dart';
import 'package:mtgpro/app/modules/home_cards/bindings/home_card_binding.dart';
import 'package:mtgpro/app/modules/insights/binding/insights_binding.dart';
import 'package:mtgpro/app/modules/login/binding/login_binding.dart';
import 'package:mtgpro/app/modules/login/login_screen.dart';
import 'package:mtgpro/app/modules/mortgage_calculator.dart';
import 'package:mtgpro/app/modules/nfc/write_nfc/write_nfc_screen.dart';
import 'package:mtgpro/app/modules/post_add/insufficient_balance.dart';
import 'package:mtgpro/app/modules/post_add/post_ad_screen.dart';
import 'package:mtgpro/app/modules/post_add/success_screen.dart';
import 'package:mtgpro/app/modules/review/review_screen.dart';
import 'package:mtgpro/app/modules/settings/settings_screen.dart';
import 'package:mtgpro/app/modules/settings_pages/payment_gateway/credit_card/binding/credit_card_binding.dart';
import 'package:mtgpro/app/modules/settings_pages/payment_gateway/credit_card/stripe_screen.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/binding/plan_details_binding.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/binding/pricing_binding.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/plan_details_screen.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/pricing_screen.dart';
import 'package:mtgpro/app/modules/settings_pages/suggest_feature/bindings/suggest_feature_binding.dart';
import 'package:mtgpro/app/modules/settings_pages/suggest_feature/suggest_feature_screen.dart';
import 'package:mtgpro/app/modules/signup/signup_screen.dart';
import 'package:mtgpro/app/modules/signup/sms_verification.dart';
import 'package:mtgpro/app/modules/splash/binding/splash_binding.dart';
import 'package:mtgpro/app/modules/splash/splash_screen.dart';
import 'package:mtgpro/app/modules/vcard_to_crm/bindings/vcard_to_crm_binding.dart';
import 'package:mtgpro/app/modules/vcard_to_crm/vcard_to_crm_screen.dart';
import 'package:mtgpro/app/modules/welcome/welcome_screen.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:get/get.dart';

import '../modules/card_create/create_card_screen.dart';
import '../modules/card_create/mtg_card_create/binding/card_create_binding.dart';
import '../modules/card_create/mtg_card_create/mtg_card_create_screen.dart';
import '../modules/card_edit/card_edit_screen.dart';
import '../modules/crm/edit_connection/binding/edit_connection_binding.dart';
import '../modules/crm/edit_connection/edit_connection_screen.dart';
import '../modules/nfc/write_nfc/binding/write_nfc_binding.dart';
import '../modules/no_internet/binding/no_internet_binding.dart';
import '../modules/no_internet/no_internet_screen.dart';
import '../modules/review/binding/review_binding.dart';
import '../modules/settings_pages/account_settings/account_setting_screen.dart';
import '../modules/settings_pages/account_settings/binding/account_setting_binding.dart';
import '../modules/settings_pages/m_calculator/binding/my_calculator_binding.dart';
import '../modules/settings_pages/m_calculator/my_calculator_screen.dart';
import '../modules/settings_pages/marketing_material/binding/marketing_binding.dart';
import '../modules/settings_pages/marketing_material/marketing_screen.dart';
import '../modules/settings_pages/my_order/binding/order_binding.dart';
import '../modules/settings_pages/my_order/order_screen.dart';
import '../modules/settings_pages/my_subscription/binding/subscription_binding.dart';
import '../modules/settings_pages/my_subscription/subscription_screen.dart';
import '../modules/settings_pages/support/binding/support_binding.dart';
import '../modules/settings_pages/support/support_screen.dart';
import '../modules/signup/binding/signup_binding.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
      binding: SplashBinding()
    ),
    GetPage(
      name: Routes.noInternet,
      page: () => const NoInternetScreen(),
      binding: NoInternetBinding()
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      // binding: HomeCardBinding(),
      bindings: [
        HomeCardBinding(),
        InsightsBinding(),
      ]
    ),
    GetPage(
      name: Routes.login,
      binding: LoginBinding(),
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignupScreen(),
      binding: SignupBinding()
    ),
    GetPage(
      name: Routes.forgotPass,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding()
    ),
    GetPage(
      name: Routes.signupOtp,
      page: () => const SmsVerificationScreen(),
    ),
    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.setting,
      page: () => const SettingsScreen(),
    ),

    GetPage(
      name: Routes.cardViewHistoryScreen,
      binding: CardViewHistoryBinding(),
      page: () => const CardViewHistoryScreen(),
    ),
    GetPage(
      name: Routes.contactDownloadHistoryScreen,
      binding: ContactDownloadHistoryBinding(),
      page: () => const ContactDownloadHistoryScreen(),
    ),
    GetPage(
      name: Routes.qrDownloadHistoryScreen,
      binding: QrDownloadHistoryBinding(),
      page: () => const QrDownloadHistoryScreen(),
    ),

    GetPage(
      name: Routes.postAd,
      page: () => const PostAdScreen(),
    ),
    GetPage(
      name: Routes.postAdSuccess,
      page: () => const PostAdSuccessScreen(),
    ),
    GetPage(
      name: Routes.insufficientBalance,
      page: () => const InsufficientBalanceScreen(),
    ),

    GetPage(
      name: Routes.reflectly,
      page: () => const ReflectlyScreen(),
    ),
    GetPage(
      name: Routes.cardView,
      binding: CardPreviewBinding(),
      page: () => CardViewScreen(),
    ),
    GetPage(
      name: Routes.createCard,
      page: () => CreateCardScreen(),
    ),
    GetPage(
      name: Routes.mtgCreateCard,
      page: () => const MtgCardCreateScreen(),
      binding: CardCreateBinding()
    ),
    GetPage(
      name: Routes.mtgCardEdit,
      page: () => const MtgCardEditScreen(),
      binding: CardEditBinding()
    ),


    GetPage(
      name: Routes.writeNfcCard,
      page: () => const WriteNfcCardScreen(),
      binding: WriteNfcCardBinding()
    ),

    GetPage(
      name: Routes.stripeScreen,
      page: () => const StripeScreen(),
      binding: CreditCardBinding()
    ),

    //........... Settings Pages ............
    GetPage(
      name: Routes.suggestFeature,
      binding: SuggestFeatureBinding(),
      page: () => const SuggestFeatureScreen(),
    ),
    GetPage(
      name: Routes.accountSetting,
      binding: AccountSettingBinding(),
      page: () => const AccountSettingScreen(),
    ),
    GetPage(
      name: Routes.calculator,
      binding: MyCalculatorBinding(),
      page: () => const MyCalculatorScreen(),
    ),
    GetPage(
      name: Routes.freeMarketing,
      binding: MarketingBinding(),
      page: () => const MarketingScreen(),
    ),
    GetPage(
      name: Routes.myOrder,
      binding: OrderBinding(),
      page: () => const OrderScreen(),
    ),

    //........... C R M ...........
    GetPage(
      name: Routes.vcardToCrmScreen,
      binding: VCardToCrmBinding(),
      page: () => const VCardToCrmScreen(),
    ),
    GetPage(
      name: Routes.crmScreen,
      binding: CrmBinding(),
      page: () => CrmScreen(),
    ),
    GetPage(
      name: Routes.viewConnectionScreen,
      binding: ViewConnectionBinding(),
      page: () => const ViewConnectionScreen(),
    ),
    GetPage(
      name: Routes.editConnectionScreen,
      binding: EditConnectionBinding(),
      page: () => const EditConnectionScreen(),
    ),

    GetPage(
      name: Routes.subscription,
      binding: SubscriptionBinding(),
      page: () => const SubscriptionScreen(),
    ),
    GetPage(
      name: Routes.pricingPlan,
      binding: PricingBinding(),
      page: () => const PricingScreen(),
    ),
    GetPage(
      name: Routes.planDetails,
      binding: PlanDetailsBinding(),
      page: () => const PlanDetailsScreen(),
    ),
    GetPage(
      name: Routes.support,
      binding: SupportBinding(),
      page: () => const SupportScreen(),
    ),
    GetPage(
      name: Routes.writeReview,
      binding: ReviewBinding(),
      page: () => MyReviewScreen(),
    ),
    GetPage(
      name: Routes.mortgageCalculator,
      // binding: SupportBinding(),
      page: () => const MortgageCalculator(),
    ),

    //.............. Create Step VCards .................
    GetPage(
      name: Routes.stepVCardsName,
      page: () => const CreateStepVcardName(),
      binding: CreateStepCardBindings()
    ),
    GetPage(
      name: Routes.stepVCardsCompany,
      page: () => const CreateStepVcardCompany(),
        binding: CreateStepCardBindings()
    ),
    GetPage(
      name: Routes.stepVCardsPhoto,
      page: () => const CreateStepVcardPhoto(),
        binding: CreateStepCardBindings()
    ),
    GetPage(
      name: Routes.stepVCardsPhone,
      page: () => const CreateStepVcardPhone(),
    ),
    GetPage(
      name: Routes.stepVCardsEmail,
      page: () => const CreateStepVcardEmail(),
    ),
    GetPage(
      name: Routes.stepVCardsPassword,
      page: () => const CreateStepVcardPassword(),
    ),
    GetPage(
      name: Routes.bookStore,
      page: () => const BookStore(),
    ),
    GetPage(
      name: Routes.nativeCodeRun,
      page: () => const InvokeCallScreen(),
    ),
  ];
}