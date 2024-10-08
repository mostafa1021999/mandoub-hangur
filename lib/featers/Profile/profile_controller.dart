import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileController extends ControllerMVC {
  // singleton
  factory ProfileController() {
    _this ??= ProfileController._();
    return _this!;
  }

  static ProfileController? _this;

  ProfileController._();

  void testMvc() {
    print('test mvc');
  }
}
