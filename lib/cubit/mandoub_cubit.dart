import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/modules/home.dart';
import 'package:untitled2/modules/last%20orders.dart';
import 'package:untitled2/modules/main%20page.dart';
import 'package:untitled2/modules/order%20handle.dart';
import 'package:untitled2/modules/setting.dart';

part 'mandoub_state.dart';

class MandoubCubit extends Cubit<MandoubState> {
  MandoubCubit() : super(MandoubInitial()){_getCurrentLocation();}
  static MandoubCubit get(context) => BlocProvider.of(context);
  final getMapController = Completer<GoogleMapController>();
  String currentLocationName='';
  double ?position1;
  double ?position2;
  Position? currentPosition;

  int current = 3;
  List<BottomNavigationBarItem> bottomen = [
    const BottomNavigationBarItem(icon: Icon(Icons.settings),
      label: 'الاعدادات',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.restart_alt_outlined),
      label: 'السجل',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.delivery_dining),
      label: 'عمليات التوصيل',
    ),
    const BottomNavigationBarItem(icon:  Icon(Icons.home),
      label: 'الرئيسيه',
    ),
  ];
  List bottomNavigationClasses = [Setting(),LastOrder(),OrderHandle(),MainHome(),];
  void changenavigator(int index) {
    current = index;
    emit(OtherState());
  }

  void _moveMapToCurrentPosition(mapController) {
    if (currentPosition != null ) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentPosition!.latitude,
              currentPosition!.longitude,
            ),
            zoom: 14.0,
          ),
        ),
      );
    }
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
      position1=position.latitude;
      position2=position.longitude;
      currentLocationName = '${placemark.street??''},${placemark.locality}, ${placemark.country}';
    } catch (e) {
      SystemNavigator.pop();
      print(e);
    }
    emit(GetMap());
  }

}
