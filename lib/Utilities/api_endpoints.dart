class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl = "https://canary-api.teslm.shop/";
  static Uri uri(
      {required String path, Map<String, dynamic>? queryParameters}) =>
      Uri(
        scheme: "http",
        host: "147.79.114.89",
        port: 5050,
        path: path.replaceAll("https://canary-api.teslm.shop", ""),
        queryParameters: queryParameters,
      );
  static const String login = "${baseUrl}delivery-partners/login";
  static const String getUserData = "${baseUrl}delivery-partners/auth/me";
  static const String sendCodeOtp =
      "${baseUrl}delivery-partners/auth/forget-password/generate-otp";
  static const String checkCodeOtp =
      "${baseUrl}delivery-partners/auth/forget-password/verify-otp";
  static const String changePassword = "${baseUrl}delivery-partners/me";
  static const String chat = "${baseUrl}chats/deliveryPartners/me";
  static const String orders = "${baseUrl}orders/delivery-partners";
  static const String deliveryManStatistics = "delivery-partners/me/statistics";
  static String notifications = '${baseUrl}notifications/deliveryPartner';
}
