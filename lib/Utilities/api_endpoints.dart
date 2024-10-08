class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl = "http://147.79.114.89:5050/";

  static const String login = "${baseUrl}delivery-partners/login";
  static const String getUserData = "${baseUrl}delivery-partners/auth/me";
}
