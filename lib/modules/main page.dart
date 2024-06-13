import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled2/componants/colors.dart';
import 'package:untitled2/cubit/mandoub_cubit.dart';

import '../componants/componants.dart';
class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Position? _currentPosition;
  void _initMapController() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _mapController = controller;
    });
  }
  @override
  void initState() {
    _initMapController();
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
      body: Container(
        height: MediaQuery.sizeOf(context).height/1.6,
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled:false,
              initialCameraPosition: CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(37.42796133580664, -122.085749655962),
                  tilt: 59.440717697143555,
                  zoom: 12.4746),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller)async {
                _mapController = controller;
                _controller.complete(controller);
              },),
            Positioned(
                top: 50,left: 25,
                child: Builder(
                  builder:(context)=> InkWell(
                    onTap: (){Scaffold.of(context).openDrawer();},
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.dehaze_rounded,color: mainColor,)),
                  ),
                )),
            Positioned(
                top: 110,left: 25,
                child: CircleAvatar(backgroundColor:Colors.white, child: Icon(Icons.restart_alt_outlined,color: mainColor,size: 25,))),
            Positioned(
                bottom: 70,right: 25,
                child: Builder(
                  builder:(context)=> InkWell(
                    onTap: _getCurrentPosition,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.my_location,color: mainColor,)),
                  ),
                )),
            Center(child: Container(height: 100,width: 220,color: Colors.black26,))
          ],
        ),
      ),
      bottomSheet:
      MyDraggableSheet(
          child: Column(
            children: [
              BottomSheetDummyUI(),
            ],
          )),
    );
  },
);
  }
  Future<void> _getCurrentPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _moveMapToCurrentPosition();
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }
  void _moveMapToCurrentPosition() {
    if (_currentPosition != null ) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            zoom: 14.0,
          ),
        ),
      );
    }
  }
}
class BottomSheetDummyUI extends StatelessWidget {
  const BottomSheetDummyUI({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.center,child: Text('قيمة الطلب',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
              Align(alignment: Alignment.center,child: Text('450 Sar',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: moneyColor.shade600),)),
              SizedBox(height: 15),
              seperate(),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Column(
                  children: [
                    Text('المطعم',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
                    Text('عنوان المطعم',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(width: 5,),
                Icon(Icons.shop),
              ],)
            ],
          )),
    );
  }
}
class MyDraggableSheet extends StatefulWidget {
  final Widget child;
  const MyDraggableSheet({super.key, required this.child});

  @override
  State<MyDraggableSheet> createState() => _MyDraggableSheetState();
}

class _MyDraggableSheetState extends State<MyDraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.4) collapse();

  }

  void collapse() => animateSheet(0.85);

  void anchor() => animateSheet(getSheet.snapSizes!.last);

  void expand() => animateSheet(getSheet.maxChildSize);


  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }
  void animateToMax() {
    controller.animateTo(
      0.85,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void animateToMin() {
    controller.animateTo(
      0.4,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
        key: sheet,
        initialChildSize: 0.4,
        maxChildSize: 0.85,
        minChildSize: 0.4,
        expand: false,
        snap: false,

        controller: controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      topButtonIndicator(),
                      SliverToBoxAdapter(
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: bottom('ابدا مناوبه العمل',(){}),
                ),
              ],
            ),
          );
        },
      );
    });
  }
  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    child: Center(
                        child: Wrap(children: <Widget>[
                          Container(
                              width: 100,
                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              )),
                        ]))),
              ])),
    );
  }
}

Widget nextSession(context)=>Directionality(
  textDirection: TextDirection.rtl,
  child: Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: smallBottom('لا يعمل'),
            ),
          ),
          SizedBox(height: 15),
          seperate(),
          SizedBox(height: 15),
          Text('المناوبه القادمه',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
          SizedBox(height: 15),
          Container(width: MediaQuery.sizeOf(context).width/1.2,height: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 0.9,color: mainColor.shade400)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  SizedBox(height: 15,),
                  Text('09:00am - 07:00pm',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Makka ,shawqia',
                    style: TextStyle(
                      color: greyFontColor,fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  smallBottom('محجوز')
                ],),SizedBox(width: 10,),
                date(),
              ],),
          ),

        ],
      )),
);