class LoginToke {
  final String? message;
  final String? token;

  LoginToke({
    this.message,
    this.token
  });
  factory LoginToke.fromJson(Map<String, dynamic> json) {
    return LoginToke(
      message: json['message'],
      token: json['token']
    );
  }
}