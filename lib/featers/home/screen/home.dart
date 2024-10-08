import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/translate/strings.dart';

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
    return BlocConsumer<RiderCubit, MandoubState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        List<BottomNavigationBarItem> bottomNavigationBar = [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Strings.main.tr(context),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: Strings.deliveryOperations.tr(context),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restart_alt_outlined),
            label: Strings.deliverySummery.tr(context),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: Strings.more.tr(context),
          ),
        ];
        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
              child: ListView(padding: EdgeInsets.zero, children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: ThemeModel.mainColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text('hhhhhhhhhhhhhi')],
              ),
            )
          ])),
          body: RiderCubit.get(context).currentLocationName != ''
              ? RiderCubit.get(context)
                  .bottomNavigationClasses[RiderCubit.get(context).current]
              : Center(child: CircularProgressIndicator()),
          bottomNavigationBar: Theme(
            data: ThemeData(
              canvasColor: ThemeModel.mainColor,
            ),
            child: BottomNavigationBar(
                unselectedItemColor: Colors.white,
                currentIndex: RiderCubit.get(context).current,
                onTap: (index) {
                  RiderCubit.get(context).changeNavigator(index);
                },
                items: bottomNavigationBar),
          ),
        );
      },
    );
  }
}
