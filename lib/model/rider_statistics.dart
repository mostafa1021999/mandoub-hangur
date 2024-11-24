class RiderStatistics {
  final WorkingHours? workingHours;
  final int? totalEarnings;
  final int? totalOrders;
  final int? totalDeliveredOrders;
  final int? totalRejectedOrders;

  RiderStatistics(
      {this.workingHours,
        this.totalEarnings,
        this.totalOrders,
        this.totalDeliveredOrders,
        this.totalRejectedOrders});
  factory RiderStatistics.fromJson(Map<String, dynamic> map) {
    return RiderStatistics(
      workingHours: map['workingHours'] != null
          ? WorkingHours.fromJson(map['workingHours'])
          : null,
      totalEarnings: map['totalEarnings'],
      totalOrders: map['totalOrders'],
      totalDeliveredOrders: map['totalDeliveredOrders'],
      totalRejectedOrders: map['totalRejectedOrders'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (workingHours != null) {
      data['workingHours'] = workingHours!.toJson();
    }
    data['totalEarnings'] = totalEarnings;
    data['totalOrders'] = totalOrders;
    data['totalDeliveredOrders'] = totalDeliveredOrders;
    data['totalRejectedOrders'] = totalRejectedOrders;
    return data;
  }
}

class WorkingHours {
  final int? hours;
  final int? minutes;
  final int? totalMinutes;

  WorkingHours({this.hours, this.minutes, this.totalMinutes});
  factory WorkingHours.fromJson(Map<String, dynamic> map) {
    return WorkingHours(
      hours: map['hours'],
      minutes: map['minutes'],
      totalMinutes: map['totalMinutes'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hours'] = hours;
    data['minutes'] = minutes;
    data['totalMinutes'] = totalMinutes;
    return data;
  }
}