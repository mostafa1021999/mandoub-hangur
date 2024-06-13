import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled2/componants/colors.dart';
import 'package:untitled2/componants/componants.dart';
import 'package:untitled2/cubit/mandoub_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandoubCubit, MandoubState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration:  BoxDecoration(
                        color: mainColor.shade200,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('hhhhhhhhhhhhhi')
                        ],),
                    )])),
          body:MandoubCubit.get(context).currentLocationName!=''? MandoubCubit.get(context).bottomNavigationClasses[MandoubCubit.get(context).current]:Center(child: CircularProgressIndicator()),
          bottomNavigationBar: Theme(
            data :ThemeData(
              canvasColor: mainColor,
            ),
            child: BottomNavigationBar(
                unselectedItemColor:Colors.white,
                currentIndex: MandoubCubit.get(context).current,
                onTap: (index) {
                  MandoubCubit.get(context).changenavigator(index);
                },
                items: MandoubCubit.get(context).bottomen ),
          ),
        );
      },
    );
  }
}


