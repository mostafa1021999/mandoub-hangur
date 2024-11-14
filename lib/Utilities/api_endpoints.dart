class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl = "https://canary-api.teslm.shop/";

  static const String login = "${baseUrl}delivery-partners/login";
  static const String getUserData = "${baseUrl}delivery-partners/auth/me";
  static const String sendCodeOtp =
      "${baseUrl}delivery-partners/auth/forget-password/generate-otp";
  static const String checkCodeOtp =
      "${baseUrl}delivery-partners/auth/forget-password/verify-otp";
  static const String changePassword = "${baseUrl}delivery-partners/me";
  static const String chat = "${baseUrl}chats/deliveryPartners/me";
  static const String orders = "${baseUrl}orders/delivery-partners";
  static String notifications = '${baseUrl}notifications/deliveryPartner';
}
