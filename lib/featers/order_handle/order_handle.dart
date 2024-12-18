import 'package:flutter/material.dart';
import 'package:untitled2/common/translate/app_local.dart';

import '../../common/translate/strings.dart';

class OrderHandle extends StatelessWidget {
  const OrderHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.orderTracking.tr(context)),
      ),
      body: Center(),
    );
  }
}
