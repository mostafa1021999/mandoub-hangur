import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import 'package:untitled2/cubit/rider_cubit.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
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
    return BlocConsumer<RiderCubit, MandoubState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: MediaQuery.sizeOf(context).height / 1.6,
            child: Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: const CameraPosition(
                      bearing: 192.8334901395799,
                      target: LatLng(37.42796133580664, -122.085749655962),
                      tilt: 59.440717697143555,
                      zoom: 12.4746),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (GoogleMapController controller) async {
                    _mapController = controller;
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                    top: 50,
                    left: 25,
                    child: Builder(
                      builder: (context) => InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.dehaze_rounded,
                              color: ThemeModel.mainColor,
                            )),
                      ),
                    )),
                const Positioned(
                    top: 110,
                    left: 25,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.restart_alt_outlined,
                          color: ThemeModel.mainColor,
                          size: 25,
                        ))),
                Positioned(
                    bottom: 70,
                    right: 25,
                    child: Builder(
                      builder: (context) => InkWell(
                        onTap: _getCurrentPosition,
                        child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.my_location,
                              color: ThemeModel.mainColor,
                            )),
                      ),
                    )),
                Center(
                    child: Container(
                  height: 100,
                  width: 220,
                  color: Colors.black26,
                ))
              ],
            ),
          ),
          bottomSheet: const MyDraggableSheet(child: BottomSheetDummyUI()),
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
    if (_currentPosition != null) {
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
    return Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  Strings.orderMoney.tr(context),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                )),
            Align(
                alignment: Alignment.center,
                child: Text(
                  '450 ${Strings.sar.tr(context)}',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: ThemeModel.of(context).moneyColor),
                )),
            const SizedBox(height: 10),
            seperate(),
            const SizedBox(height: 15),
            orderDesign(
                true, '2.6km', '12min', 'الطازج', 'مكة - حى الشوقيه', context),
            orderDesign(
                false, '1.5km', '8min', 'العميل', 'مكة - حى الشوقيه', context),
          ],
        ));
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
  int _timer = 20;
  late Timer _countdownTimer;
  double value = 1;

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
    determinateIndicator();
    _startTimer();
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

  void determinateIndicator() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (value == 0) {
          timer.cancel();
        } else {
          value = value - 0.05;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _countdownTimer.cancel();
    controller.dispose();
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          _timer = 0;
        }
      });
    });
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    // double _size = MediaQuery.sizeOf(context).width;
    // if (_timer > 0) {
    //   _size=MediaQuery.sizeOf(context).width-_timer*2;
    // } else if (_timer < 10) {
    //   _size=0;
    // }
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
                  child: _timer != 0
                      ? CustomScrollView(
                          controller: scrollController,
                          slivers: [
                            topButtonIndicator(),
                            SliverToBoxAdapter(
                              child: widget.child,
                            ),
                          ],
                        )
                      : Center(
                          child: Container(
                          child: Text(
                            Strings.thereNoOrdersNow.tr(context),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        )),
                ),
                if (_timer != 0) const SizedBox(height: 5),
                if (_timer !=
                    0) // Add some spacing between the icon and the timer
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 5, top: 5),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1300),
                      curve: Curves.easeInOut,
                      tween: Tween<double>(
                        begin: 1,
                        end: value,
                      ),
                      builder: (context, value, _) => LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.grey.shade300,
                        color: ThemeModel.mainColor,
                        minHeight: 5,
                      ),
                    ),
                  ),
                if (_timer != 0)
                  const SizedBox(
                    height: 3,
                  ),
                if (_timer != 0)
                  Text(
                    '${_timer.toString().padLeft(2, '0')} ${Strings.secondsAutoDecline.tr(context)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ThemeModel.mainColor,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, bottom: 10),
                  child: bottom(
                    Strings.acceptOrder.tr(context),
                    _timer != 0 ? () {} : null,
                  ),
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

Widget nextSession(context) => Container(
    padding: const EdgeInsets.only(left: 30, right: 30),
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
        const SizedBox(height: 15),
        seperate(),
        const SizedBox(height: 15),
        const Text(
          'المناوبه القادمه',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.sizeOf(context).width / 1.2,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.9, color: ThemeModel.mainColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    '09:00am - 07:00pm',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Makka ,shawqia',
                    style: TextStyle(
                      color: ThemeModel.of(context).greyFontColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  smallBottom('محجوز')
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              date(context),
            ],
          ),
        ),
      ],
    ));
