import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Utilities/shared_preferences.dart';
import '../common/constants/constanat.dart';
import '../featers/Profile/profile_view.dart';
import '../featers/home/screen/main_page.dart';
import '../featers/last_orders/screen/last_orders.dart';
import '../featers/order_handle/order_handle.dart';
import '../shared_prefrence/shared prefrence.dart';

part 'rider_state.dart';

class RiderCubit extends Cubit<MandoubState> {
  RiderCubit() : super(MandoubInitial()) {
    _getCurrentLocation();
  }
  static RiderCubit get(context) => BlocProvider.of(context);
  final getMapController = Completer<GoogleMapController>();
  String currentLocationName = '';
  double? position1;
  double? position2;
  Position? currentPosition;

  int current = 0;

  List bottomNavigationClasses = [
    const MainHome(),
    const OrderHandle(),
    LastOrder(),
    const ProfileView(),
  ];
  void changeNavigator(int index) {
    current = index;
    emit(OtherState());
  }

  void reload() {
    emit(OtherState());
  }

  String lang = 'ar';
  void changeLanguage({fromCache, lange}) {
    if (fromCache != null) {
      lang = fromCache;
      emit(ChangeLanguageSuccess());
    } else {
      lang = lange;
      language = lang;
      Save.savedata(key: 'lang', value: lange).then((value) {});
      emit(ChangeLanguageSuccess());
    }
  }

  //======================
  IconData iconPassword = Icons.visibility_off_outlined;
  bool showPassword = true;
  void changePassType(icon, password) {
    iconPassword = icon == Icons.visibility_outlined
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    showPassword = !showPassword;
    emit(SetPassword());
  }



  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SystemNavigator.pop();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks.first;
      position1 = position.latitude;
      position2 = position.longitude;
      SharedPref.setLatLng(
          latLng: [position1.toString(), position2.toString()]);
      currentLocationName =
          '${placemark.street ?? ''},${placemark.locality}, ${placemark.country}';
    } catch (e) {
      SystemNavigator.pop();
      print(e);
    }
    emit(GetMap());
  }

  // LoginToke? loginToken;
  // void riderLogin(
  //     {required String residencyNumber,
  //     required String password,
  //     required context}) {
  //   emit(LoginLoading());
  //   DioHelper.postData(
  //           url: 'delivery-partners/login',
  //           data: {'residencyNumber': residencyNumber, 'password': password})
  //       .then((value) {
  //     loginToken = LoginToke.fromJson(value.data);
  //     token = loginToken!.token;
  //     Save.savedata(key: 'token', value: token).then((value) {
  //       navigateAndFinish(context, const HomePage());
  //       // getRiderData();
  //     });
  //     emit(LoginSuccess());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(LoginError());
  //   });
  // }
}
