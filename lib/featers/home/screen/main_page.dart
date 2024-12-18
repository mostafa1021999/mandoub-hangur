import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled2/Utilities/extensions.dart';
import 'package:untitled2/Utilities/shared_preferences.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import 'package:untitled2/featers/home/Models/requested_order_model.dart';
import 'package:untitled2/featers/home/cubit/home_cubit.dart';
import 'package:untitled2/main.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constants/constanat.dart';
import '../../../model/get_rider_data_model.dart';
import '../../Notifications/notifications_view.dart';
import '../../Profile/navigators/UserData/user_data_controller.dart';
import '../../order_handle/orders_data_handler.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  createState() => MainHomeState();
}

class MainHomeState extends State<MainHome> {
  // static void getRequestedOrders()
  late UserDataController con;
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

  static Future<void> getCurrentOrders() async {
    navigatorKey.currentState!.context
        .read<HomeCubit>()
        .getRequestedOrders()
        .then((value) {
      // Future.delayed(Duration(milliseconds: 500), () async {
      //   emit(HomeLoaded());
      //   MainHomeState().setState(() {});
      // });
      print("getRequestedOrders....................");
    });
  }

  @override
  void initState() {
    ///    --------   Get Requested Orders   --------
    context.read<HomeCubit>().getRequestedOrders();
    con = UserDataController();
    _initMapController();
    Future.delayed(Duration.zero, () async {
      await con.getUserData(); // Assuming this is an async call
      if (con.userData?.area != null) {
        _createPolyline(); // Only create polyline if area data is available
      }
    });
    super.initState();
  }

  Set<Polygon> _polygons = {};
  bool isSwitched = false;
  List<LatLng> getPolylinePoints(Area area) {
    List<LatLng> points = area.coordinates
            ?.map((coord) {
              final point = coord.point;
              if (point != null && point.coordinates != null) {
                return LatLng(point.coordinates![1], point.coordinates![0]);
              }
              return null;
            })
            .whereType<LatLng>()
            .toList() ??
        [];

    // Add the first point to the end to close the polygon
    if (points.isNotEmpty) {
      points.add(points[0]);
    }

    return points;
  }

  void _createPolyline() {
    // Get coordinates for the polygon from the userData area
    List<LatLng> polygonCoordinates = getPolylinePoints(con.userData!.area!);

    // Create a polygon using the coordinates with opacity for colors
    final polygon = Polygon(
      polygonId: PolygonId("polygon_${con.userData!.id}"),
      points: polygonCoordinates,
      strokeColor: Colors.blue
          .withOpacity(0.6), // Blue color with 70% opacity for border
      strokeWidth: 2,
      fillColor:
          Colors.blue.withOpacity(0.2), // Blue color with 30% opacity for fill
    );

    setState(() {
      _polygons.add(polygon);
    });

    // Adjust the camera to fit the polygon coordinates
    _setCameraToPolygonBounds(polygonCoordinates);
  }

  // Set the camera bounds based on the polygon points
  void _setCameraToPolygonBounds(List<LatLng> polygonCoordinates) {
    if (polygonCoordinates.isEmpty) return;

    LatLngBounds bounds = _calculateBounds(polygonCoordinates);
    _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  void _setCameraToPolylineBounds(List<LatLng> polylineCoordinates) {
    if (polylineCoordinates.isEmpty) return;

    LatLngBounds bounds = _calculateBounds(polylineCoordinates);
    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  LatLngBounds _calculateBounds(List<LatLng> coordinates) {
    double southWestLat = coordinates[0].latitude;
    double southWestLng = coordinates[0].longitude;
    double northEastLat = coordinates[0].latitude;
    double northEastLng = coordinates[0].longitude;

    for (LatLng latLng in coordinates) {
      if (latLng.latitude < southWestLat) southWestLat = latLng.latitude;
      if (latLng.longitude < southWestLng) southWestLng = latLng.longitude;
      if (latLng.latitude > northEastLat) northEastLat = latLng.latitude;
      if (latLng.longitude > northEastLng) northEastLng = latLng.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(southWestLat, southWestLng),
      northeast: LatLng(northEastLat, northEastLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build--------");
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.7,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      bearing: 192.8334901395799,
                      target: LatLng(
                          double.tryParse(SharedPref.getLatLng()?[0] ?? "") ??
                              37.42796133580664,
                          double.tryParse(SharedPref.getLatLng()?[1] ?? "") ??
                              -122.085749655962),
                      tilt: 59.440717697143555,
                      zoom: 13.4746),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  polygons: _polygons,
                  onMapCreated: (GoogleMapController controller) async {
                    _mapController = controller;
                    _setCameraToPolylineBounds(
                        getPolylinePoints(con.userData!.area!));
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
                Positioned(
                    top: 110,
                    left: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 7,
                            right: 7,
                          ),
                          decoration: BoxDecoration(
                            color: ThemeModel.of(context).cardsColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                isSwitched
                                    ? Strings.active.tr(context)
                                    : Strings.notActive.tr(context),
                                style: TextStyle(
                                    color: isSwitched
                                        ? isDark ?? false
                                            ? Colors.white
                                            : Colors.black
                                        : Colors.grey.shade600),
                              ),
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                                activeColor: ThemeModel.mainColor,
                                activeTrackColor:
                                    ThemeModel.mainColor.withOpacity(0.4),
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.grey.shade300,
                              ),
                            ],
                          ),
                        ),
                        16.h.heightBox,
                        GestureDetector(
                          onTap: () {
                            navigate(context, const NotificationsView());
                          },
                          child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.notifications_active,
                                color: ThemeModel.mainColor,
                              )),
                        ),
                      ],
                    )),
                Positioned(
                    bottom: 35,
                    right: 70,
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
              ],
            ),
          ),
          bottomSheet: MyDraggableSheet(
              orderId: cubit.requestedOrders.lastOrNull?.id,
              child: BottomSheetDummyUI(
                requestedOrderModel:
                    cubit.requestedOrders.lastOrNull ?? RequestedOrderModel(),
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
  final RequestedOrderModel requestedOrderModel;
  const BottomSheetDummyUI({super.key, required this.requestedOrderModel});
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
                  '${requestedOrderModel.subtotal ?? "0.0"} ${Strings.sar.tr(context)}',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: ThemeModel.of(context).moneyColor),
                )),
            const SizedBox(height: 10),
            seperate(),
            const SizedBox(height: 15),
            orderDesign(
                true,
                '2.6km',
                '12min',
                '${requestedOrderModel.provider?.providerName?.ar}',
                '${requestedOrderModel.branch?.branchName?.ar} - ${requestedOrderModel.branch?.addressDescription ?? ""}',
                context),
            orderDesign(
                false,
                '1.5km',
                '8min',
                '${requestedOrderModel.customer?.name}',
                '${requestedOrderModel.customer?.address}',
                context),
          ],
        ));
  }
}

class MyDraggableSheet extends StatefulWidget {
  final Widget child;
  final String? orderId;
  const MyDraggableSheet({super.key, required this.child, this.orderId});

  @override
  State<MyDraggableSheet> createState() => _MyDraggableSheetState();
}

class _MyDraggableSheetState extends State<MyDraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();
  int _timer = 60;
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
          value = value - 0.017;
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
                  child: _timer != 0 && widget.orderId != null
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
                          child: Text(
                          Strings.thereNoOrdersNow.tr(context),
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        )),
                ),
                if (_timer != 0 && widget.orderId != null)
                  const SizedBox(height: 5),
                if (_timer != 0 &&
                    widget.orderId !=
                        null) // Add some spacing between the icon and the timer
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
                if (_timer != 0 && widget.orderId != null)
                  const SizedBox(
                    height: 3,
                  ),
                if (_timer != 0 && widget.orderId != null)
                  Container(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 4, top: 4),
                    color: Colors.red.shade400,
                    child: Text(
                      '${_timer.toString().padLeft(2, '0')} ${Strings.secondsAutoDecline.tr(context)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
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
                    _timer != 0 && widget.orderId != null
                        ? () {
                            if (widget.orderId == null) return;
                            OrdersDataHandler.acceptOrder(
                                orderID: widget.orderId!);
                            print('Confirm Action button pressed!');
                          }
                        : null,
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
