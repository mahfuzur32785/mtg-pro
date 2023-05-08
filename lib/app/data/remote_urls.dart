class RemoteUrls {
  static const String rootUrl = "https://www.mtgpro.me/";
  // static const String rootUrl = "http://192.168.203.60:8000/";
  static const String baseUrl = "${rootUrl}api/";
  static const String homeUrl = "${baseUrl}home";
  static const String userRegister = '${baseUrl}register';
  static const String getOnlyUserData = '${baseUrl}me';
  static const String socialLogin = '${baseUrl}auth/social-login';
  static const String userLogin = '${baseUrl}login';

  static const String createStepCard = '${baseUrl}crete-first-card';

  static const String getInsights = '${baseUrl}insights';
  static const String getCardViewHistory = '${baseUrl}card/view/history';
  static const String getContactDownloadHistory = '${baseUrl}card/download/history';
  static const String getQrDownloadHistory = '${baseUrl}qr/download/history';

  static const String getMyCards = '${baseUrl}my-card';
  static const String postConnectWithMe = '${baseUrl}get-connection';
  static const String postCreditAuthorization = '${baseUrl}credit-report';
  static const String postQuickApplication = '${baseUrl}quick-report';
  static const String makeCardLive = '${baseUrl}make-card-live';
  static const String getSocialLink = '${baseUrl}get-social-icons';

  static const String createCard = '${baseUrl}crete-card';
  static const String cardAddIcon = '${baseUrl}add-icons';
  static String editCard(cardId) => '${baseUrl}update-card/$cardId';
  static String editSocialIcon(cardId) => '${baseUrl}update-icons/$cardId';
  static String deleteIconFromCard(cardId) => '${baseUrl}remove-icons/$cardId';
  static const String equalHousingView = '${baseUrl}equal-housing-view';
  static const String userDisclaimerView = '${baseUrl}user-disclaimer-view';
  static const String userNmlsView = '${baseUrl}user-nmls-view';
  static const String userNmlsAdd = '${baseUrl}user-nmls-add';
  static const String userCreditAuthView = '${baseUrl}user-credit-auth-view';
  static const String quickApplicationView = '${baseUrl}user-quick-application-view';

  static const String pricingPlan = '${baseUrl}pricing-plans';
  static const String paymentGateways = '${baseUrl}pamentgetways';
  static const String paymentConfirmation = '${baseUrl}payment-success';
  static const String editProfile = '${baseUrl}auth/profile';
  static const String changePassword = '${baseUrl}auth/password';
  static const String socialUpdate = '${baseUrl}social';
  static const String deleteAccount = '${baseUrl}account-delete';
  static String userLogOut() =>
      '${baseUrl}auth/logout';
  static const String sendForgetPassword = '${baseUrl}send-forget-password';
  static const String resendRegisterCode = '${baseUrl}resend-register-code';
  static String storeResetPassword(String code) =>
      '${baseUrl}store-reset-password/$code';

  static String userVerification(String code) =>
      '${baseUrl}user-verification/$code';
  static String userProfile(String token) =>
      '${baseUrl}user/my-profile?token=$token';
  static String passwordChange(String token) =>
      '${baseUrl}user/update-password?token=$token';
  static const String aboutUs = '${baseUrl}about-content';
  static const String accDeletion = '${baseUrl}account-deletion-request';
  static const String accDeletion2 = '${baseUrl}customer/account-delete';
  static const String faq = '${baseUrl}faqscategories';
  static const String termsAndConditions = '${baseUrl}terms-conditions';
  static const String privacyPolicy = '${baseUrl}privacy-policy';
  static const String contactUs = '${baseUrl}contact-us';
  static const String sendContactMessage = '${baseUrl}contacts/send';
  static const String websiteSetup = '${baseUrl}general-settings';
  static const String getLanguages = '${baseUrl}lenguage/sync';
  static String getSingleLanguage(String code) => '${baseUrl}lenguage/$code';
  static String billingAddress(String token) =>
      '${baseUrl}user/update-billing-address?token=$token';
  static String wishList() =>
      '${baseUrl}customer/favourite-list';
  static String removeWish(int id, String token) =>
      '${baseUrl}user/remove-wishlist/$id?token=$token';
  static String addWish(int id,) =>
      '${baseUrl}ads/favourite/$id';

  ///............ Setting Pages ................
  static const String getProfile = '${baseUrl}user-profile';
  static const String postSupport = '${baseUrl}support-mail-send';
  static const String postSuggestFeature = '${baseUrl}suggest-feature';
  static const String postUpdateProfile = '${baseUrl}user-profile-update';
  static const String postIsNotify = '${baseUrl}push-notifications';
  static const String resetPasswordLink = '${baseUrl}password-reset';
  // this is for forgot Password link ............
  static const String forgotPasswordLink = '${baseUrl}reset-password';
  static const String getPricingPlan = '${baseUrl}get-plan';
  static const String getUserCurrentPlan = '${baseUrl}user-plan';
  static const String getBillingInfo = '${baseUrl}billing-info';
  static const String getInvoices = '${baseUrl}user-invoice';
  static const String postBillingUpdate = '${baseUrl}update-billing-info';
  static const String cancelPlan = '${baseUrl}cancel-plan/stripe';
  // static const String getPricingPlan = 'http://192.168.203.60:8000/get-plan';

  static String submitReviewUrl(String token) =>
      '${baseUrl}user/store-product-review?token=$token';
  static String applyCoupon(String coupon, String token) =>
      "${baseUrl}apply-coupon?coupon=$coupon&token=$token";
  static const String cashOnDelivery =
      '${baseUrl}user/checkout/cash-on-delivery?';
  static String payWithStripe = '${baseUrl}stripe-checkout';
  static String payWithPaypal(String token, String shippingId) =>
      '${baseUrl}user/checkout/pay-with-paypal?token=$token&shipping_method=$shippingId&agree_terms_condition=1';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;


  //I AM WORKING FROM HERE
  static const String getMyOrder = '${baseUrl}my-order';
  static const String getMarketMaterial = '${baseUrl}user/free-marketing-material';
  static String getCrm = '${baseUrl}crm';
  static String saveVCardToCrm = '${baseUrl}crm/import-card';
  static const String getReview = '${baseUrl}user/review';
  static const String postReview = '${baseUrl}user/review';
  static String updateReview(String id) => '${baseUrl}user/review/update/$id';
  static String getCrmDetails(id) => '${baseUrl}crm/$id/view';
  static String postUpdateCrmDetails(id) => '${baseUrl}crm/$id/update';
  static String postSendEmail = '${baseUrl}crm-send-mail';



}
