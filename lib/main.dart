import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled2/cubit/mandoub_cubit.dart';
import 'package:untitled2/modules/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => MandoubCubit(),
  child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Sheet Example',
      home: HomePage(),
    ),
);
  }
}

