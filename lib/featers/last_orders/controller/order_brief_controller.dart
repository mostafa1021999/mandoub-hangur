import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/Utilities/shared_preferences.dart';
import '../../../Utilities/NotificationHandler/notification_handler.dart';
import '../../../common/constants/constanat.dart';
import '../../../model/get_rider_data_model.dart';
import '../../../model/rider_statistics.dart';
import '../../Profile/navigators/UserData/user_data_data_handler.dart';
import '../screen/statistics_bottomsheet.dart';
import 'ordder_brief_data_handler.dart';

class OrderBriefController extends ControllerMVC {
  // singleton
  factory OrderBriefController() {
    _this ??= OrderBriefController._();
    return _this!;
  }

  static OrderBriefController? _this;

  OrderBriefController._();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  DateTime currentDate = DateTime.now();
  void goBackOneDay(context) {
    setState((){
      currentDate = currentDate.subtract(Duration(days: 1));
    });
    getRiderStatistics(context,'${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}', '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}');
  }
  void goBackOneMonth(BuildContext context) {
    setState(() {
      // Calculate the new month and year
      int newMonth = currentDate.month - 1;
      int newYear = currentDate.year;

      // Handle year rollover
      if (newMonth < 1) {
        newMonth = 12;
        newYear -= 1;
      }

      // Get the last day of the new month to handle overflow
      final lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;

      // Ensure the day doesn't exceed the last day of the new month
      final newDay = currentDate.day > lastDayOfNewMonth
          ? lastDayOfNewMonth
          : currentDate.day;

      // Update the date
      currentDate = DateTime(newYear, newMonth, newDay);

      // Calculate the first and last days of the month
      final firstDayOfMonth = DateTime(newYear, newMonth, 1);
      final lastDayOfMonth = DateTime(newYear, newMonth + 1, 0);

      // Call getRiderStatistics with the first and last days of the month
      getRiderStatistics(
        context,
        '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}',
        '${lastDayOfMonth.year}-${lastDayOfMonth.month.toString().padLeft(2, '0')}-${lastDayOfMonth.day.toString().padLeft(2, '0')}',
      );
    });
  }
  Future<void> goSpacificDay(context) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return  const CustomBottomSheet();});
  }


  void goForwardOneDay(context) {
    setState((){
    if (currentDate.isBefore(DateTime.now())) {
      if ((currentDate.isAfter(DateTime.now()))) {
        currentDate = DateTime.now();
      } else {
        currentDate = currentDate.add(Duration(days: 1));
      }
    }
    });
    getRiderStatistics(context,'${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}', '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}');
  }
  void goForwardOneMonth(BuildContext context) {
    setState(() {
      // Calculate the new month and year
      int newMonth = currentDate.month + 1;
      int newYear = currentDate.year;

      // Handle year rollover
      if (newMonth > 12) {
        newMonth = 1;
        newYear += 1;
      }

      // Ensure the new date does not exceed today
      final now = DateTime.now();
      final lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
      final newDay = currentDate.day > lastDayOfNewMonth
          ? lastDayOfNewMonth
          : currentDate.day;
      currentDate = DateTime(newYear, newMonth, newDay);

      if (currentDate.isAfter(now)) {
        currentDate = now; // Cap to today if the date goes beyond today
      }

      // Calculate the first and last days of the month
      final firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
      final lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

      // Call getRiderStatistics with the first and last days of the month
      getRiderStatistics(
        context,
        '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}',
        '${lastDayOfMonth.year}-${lastDayOfMonth.month.toString().padLeft(2, '0')}-${lastDayOfMonth.day.toString().padLeft(2, '0')}',
      );
    });
  }
  String ?viewStatistics;
  void navigateStatistics(BuildContext context, bool choose) {
    setState(() {
      if (choose) {
        // "Months" logic
        int newMonth = currentDate.month ;
        int newYear = currentDate.year;

        // Handle year rollover
        if (newMonth > 12) {
          newMonth = 1;
          newYear += 1;
        }

        // Ensure the new date does not exceed today
        final now = DateTime.now();
        final lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
        final newDay = currentDate.day > lastDayOfNewMonth
            ? lastDayOfNewMonth
            : currentDate.day;
        currentDate = DateTime(newYear, newMonth, newDay);

        if (currentDate.isAfter(now)) {
          currentDate = now; // Cap to today if the date goes beyond today
        }

        // Calculate the first and last days of the month
        final firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
        final lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

        // Update viewStatistics and call getRiderStatistics
        viewStatistics = 'months';
        getRiderStatistics(
          context,
          '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}',
          '${lastDayOfMonth.year}-${lastDayOfMonth.month.toString().padLeft(2, '0')}-${lastDayOfMonth.day.toString().padLeft(2, '0')}',
        );
      } else {
        // "Days" logic
        final now = DateTime.now();
        currentDate = currentDate.add(Duration(days: 1));

        if (currentDate.isAfter(now)) {
          currentDate = now; // Cap to today if the date goes beyond today
        }

        // Update viewStatistics and call getRiderStatistics
        viewStatistics = 'days';
        getRiderStatistics(
          context,
          '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
          '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
        );
      }
    });
  }
  RiderStatistics? riderStatistics;
  Future getRiderStatistics(BuildContext context,String startDate,String endDate) async {
    loading = true;
    setState(() {});
    final result = await OrderBriefDataHandler.getStatistics(
        startDate: startDate, endDate: endDate);
    result.fold((l) {

    }, (r) {
     print(r);
     riderStatistics=RiderStatistics.fromJson(r);
    });
    loading = false;
    setState(() {});
  }
}
