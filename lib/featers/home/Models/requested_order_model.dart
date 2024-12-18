class RequestedOrderModel {
  final String? id;
  final double? totalPrice;
  final int? shippingPrice;
  final double? subtotal;
  final int? discount;
  final dynamic coupon;
  final Location? location;
  final dynamic deliveryReceipt;
  final dynamic orderReceipt;
  final String? rejectionNotes;
  final String? status;
  final int? serial;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? customerNotes;
  final bool? isScheduled;
  final DateTime? scheduledDate;
  final String? previousStatus;
  final String? paymentStatus;
  final bool? isViewed;
  final dynamic orderImage;
  final Branch? branch;
  final Customer? customer;
  final List<Item>? items;
  final dynamic deliveryPartner;
  final Provider? provider;

  RequestedOrderModel({
    this.id,
    this.totalPrice,
    this.shippingPrice,
    this.subtotal,
    this.discount,
    this.coupon,
    this.location,
    this.deliveryReceipt,
    this.orderReceipt,
    this.rejectionNotes,
    this.status,
    this.serial,
    this.createdAt,
    this.updatedAt,
    this.customerNotes,
    this.isScheduled,
    this.scheduledDate,
    this.previousStatus,
    this.paymentStatus,
    this.isViewed,
    this.orderImage,
    this.branch,
    this.customer,
    this.items,
    this.deliveryPartner,
    this.provider,
  });

  RequestedOrderModel copyWith({
    String? id,
    double? totalPrice,
    int? shippingPrice,
    double? subtotal,
    int? discount,
    dynamic coupon,
    Location? location,
    dynamic deliveryReceipt,
    dynamic orderReceipt,
    String? rejectionNotes,
    String? status,
    int? serial,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? customerNotes,
    bool? isScheduled,
    DateTime? scheduledDate,
    String? previousStatus,
    String? paymentStatus,
    bool? isViewed,
    dynamic orderImage,
    Branch? branch,
    Customer? customer,
    List<Item>? items,
    dynamic deliveryPartner,
    Provider? provider,
  }) =>
      RequestedOrderModel(
        id: id ?? this.id,
        totalPrice: totalPrice ?? this.totalPrice,
        shippingPrice: shippingPrice ?? this.shippingPrice,
        subtotal: subtotal ?? this.subtotal,
        discount: discount ?? this.discount,
        coupon: coupon ?? this.coupon,
        location: location ?? this.location,
        deliveryReceipt: deliveryReceipt ?? this.deliveryReceipt,
        orderReceipt: orderReceipt ?? this.orderReceipt,
        rejectionNotes: rejectionNotes ?? this.rejectionNotes,
        status: status ?? this.status,
        serial: serial ?? this.serial,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        customerNotes: customerNotes ?? this.customerNotes,
        isScheduled: isScheduled ?? this.isScheduled,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        previousStatus: previousStatus ?? this.previousStatus,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        isViewed: isViewed ?? this.isViewed,
        orderImage: orderImage ?? this.orderImage,
        branch: branch ?? this.branch,
        customer: customer ?? this.customer,
        items: items ?? this.items,
        deliveryPartner: deliveryPartner ?? this.deliveryPartner,
        provider: provider ?? this.provider,
      );

  factory RequestedOrderModel.fromJson(Map<String, dynamic> json) =>
      RequestedOrderModel(
        id: json["id"],
        totalPrice: json["totalPrice"]?.toDouble(),
        shippingPrice: json["shippingPrice"],
        subtotal: json["subtotal"]?.toDouble(),
        discount: json["discount"],
        coupon: json["coupon"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        deliveryReceipt: json["delivery_receipt"],
        orderReceipt: json["order_receipt"],
        rejectionNotes: json["rejectionNotes"],
        status: json["status"],
        serial: json["serial"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        customerNotes: json["customerNotes"],
        isScheduled: json["isScheduled"],
        scheduledDate: json["scheduledDate"] == null
            ? null
            : DateTime.parse(json["scheduledDate"]),
        previousStatus: json["previousStatus"],
        paymentStatus: json["paymentStatus"],
        isViewed: json["isViewed"],
        orderImage: json["orderImage"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        deliveryPartner: json["deliveryPartner"],
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalPrice": totalPrice,
        "shippingPrice": shippingPrice,
        "subtotal": subtotal,
        "discount": discount,
        "coupon": coupon,
        "location": location?.toJson(),
        "delivery_receipt": deliveryReceipt,
        "order_receipt": orderReceipt,
        "rejectionNotes": rejectionNotes,
        "status": status,
        "serial": serial,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "customerNotes": customerNotes,
        "isScheduled": isScheduled,
        "scheduledDate": scheduledDate?.toIso8601String(),
        "previousStatus": previousStatus,
        "paymentStatus": paymentStatus,
        "isViewed": isViewed,
        "orderImage": orderImage,
        "branch": branch?.toJson(),
        "customer": customer?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "deliveryPartner": deliveryPartner,
        "provider": provider?.toJson(),
      };
}

class Branch {
  final String? id;
  final BranchName? branchName;
  final Location? location;
  final String? addressDescription;
  final String? receiptNotes;
  final String? approvalStatus;
  final dynamic rejectionNotes;
  final BranchName? description;
  final String? openTime;
  final List<String>? workDays;
  final String? closeTime;
  final String? status;
  final String? busynessStatus;
  final int? totalReviews;
  final int? reviewCount;
  final String? image;
  final String? phoneNumber;

  Branch({
    this.id,
    this.branchName,
    this.location,
    this.addressDescription,
    this.receiptNotes,
    this.approvalStatus,
    this.rejectionNotes,
    this.description,
    this.openTime,
    this.workDays,
    this.closeTime,
    this.status,
    this.busynessStatus,
    this.totalReviews,
    this.reviewCount,
    this.image,
    this.phoneNumber,
  });

  Branch copyWith({
    String? id,
    BranchName? branchName,
    Location? location,
    String? addressDescription,
    String? receiptNotes,
    String? approvalStatus,
    dynamic rejectionNotes,
    BranchName? description,
    String? openTime,
    List<String>? workDays,
    String? closeTime,
    String? status,
    String? busynessStatus,
    int? totalReviews,
    int? reviewCount,
    String? image,
    String? phoneNumber,
  }) =>
      Branch(
        id: id ?? this.id,
        branchName: branchName ?? this.branchName,
        location: location ?? this.location,
        addressDescription: addressDescription ?? this.addressDescription,
        receiptNotes: receiptNotes ?? this.receiptNotes,
        approvalStatus: approvalStatus ?? this.approvalStatus,
        rejectionNotes: rejectionNotes ?? this.rejectionNotes,
        description: description ?? this.description,
        openTime: openTime ?? this.openTime,
        workDays: workDays ?? this.workDays,
        closeTime: closeTime ?? this.closeTime,
        status: status ?? this.status,
        busynessStatus: busynessStatus ?? this.busynessStatus,
        totalReviews: totalReviews ?? this.totalReviews,
        reviewCount: reviewCount ?? this.reviewCount,
        image: image ?? this.image,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        branchName: json["branch_name"] == null
            ? null
            : BranchName.fromJson(json["branch_name"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        addressDescription: json["address_description"],
        receiptNotes: json["receipt_notes"],
        approvalStatus: json["approval_status"],
        rejectionNotes: json["rejection_notes"],
        description: json["description"] == null
            ? null
            : BranchName.fromJson(json["description"]),
        openTime: json["openTime"],
        workDays: json["workDays"] == null
            ? []
            : List<String>.from(json["workDays"]!.map((x) => x)),
        closeTime: json["closeTime"],
        status: json["status"],
        busynessStatus: json["busynessStatus"],
        totalReviews: json["totalReviews"],
        reviewCount: json["reviewCount"],
        image: json["image"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_name": branchName?.toJson(),
        "location": location?.toJson(),
        "address_description": addressDescription,
        "receipt_notes": receiptNotes,
        "approval_status": approvalStatus,
        "rejection_notes": rejectionNotes,
        "description": description?.toJson(),
        "openTime": openTime,
        "workDays":
            workDays == null ? [] : List<dynamic>.from(workDays!.map((x) => x)),
        "closeTime": closeTime,
        "status": status,
        "busynessStatus": busynessStatus,
        "totalReviews": totalReviews,
        "reviewCount": reviewCount,
        "image": image,
        "phoneNumber": phoneNumber,
      };
}

class BranchName {
  final String? ar;
  final String? en;

  BranchName({
    this.ar,
    this.en,
  });

  BranchName copyWith({
    String? ar,
    String? en,
  }) =>
      BranchName(
        ar: ar ?? this.ar,
        en: en ?? this.en,
      );

  factory BranchName.fromJson(Map<String, dynamic> json) => BranchName(
        ar: json["ar"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "ar": ar,
        "en": en,
      };
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  Location copyWith({
    String? type,
    List<double>? coordinates,
  }) =>
      Location(
        type: type ?? this.type,
        coordinates: coordinates ?? this.coordinates,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Customer {
  final String? id;
  final String? name;
  final String? email;
  final dynamic birthdate;
  final String? gender;
  final String? phoneNumber;
  final String? address;
  final String? referCode;
  final int? totalReviews;
  final int? reviewCount;
  final dynamic location;
  final String? locale;
  final dynamic macAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Customer({
    this.id,
    this.name,
    this.email,
    this.birthdate,
    this.gender,
    this.phoneNumber,
    this.address,
    this.referCode,
    this.totalReviews,
    this.reviewCount,
    this.location,
    this.locale,
    this.macAddress,
    this.createdAt,
    this.updatedAt,
  });

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    dynamic birthdate,
    String? gender,
    String? phoneNumber,
    String? address,
    String? referCode,
    int? totalReviews,
    int? reviewCount,
    dynamic location,
    String? locale,
    dynamic macAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        birthdate: birthdate ?? this.birthdate,
        gender: gender ?? this.gender,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        referCode: referCode ?? this.referCode,
        totalReviews: totalReviews ?? this.totalReviews,
        reviewCount: reviewCount ?? this.reviewCount,
        location: location ?? this.location,
        locale: locale ?? this.locale,
        macAddress: macAddress ?? this.macAddress,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        birthdate: json["birthdate"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        referCode: json["referCode"],
        totalReviews: json["totalReviews"],
        reviewCount: json["reviewCount"],
        location: json["location"],
        locale: json["locale"],
        macAddress: json["macAddress"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "birthdate": birthdate,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "address": address,
        "referCode": referCode,
        "totalReviews": totalReviews,
        "reviewCount": reviewCount,
        "location": location,
        "locale": locale,
        "macAddress": macAddress,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Item {
  final String? id;
  final int? quantity;
  final String? image;
  final double? price;
  final double? salePrice;

  Item({
    this.id,
    this.quantity,
    this.image,
    this.price,
    this.salePrice,
  });

  Item copyWith({
    String? id,
    int? quantity,
    String? image,
    double? price,
    double? salePrice,
  }) =>
      Item(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        price: price ?? this.price,
        salePrice: salePrice ?? this.salePrice,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        quantity: json["quantity"],
        image: json["image"],
        price: json["price"]?.toDouble(),
        salePrice: json["salePrice"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "image": image,
        "price": price,
        "salePrice": salePrice,
      };
}

class Provider {
  final String? id;
  final BranchName? providerName;
  final String? providerImage;
  final String? providerCover;
  final BranchName? description;
  final DateTime? createdAt;
  final int? totalReviews;
  final int? reviewCount;
  final String? view;

  Provider({
    this.id,
    this.providerName,
    this.providerImage,
    this.providerCover,
    this.description,
    this.createdAt,
    this.totalReviews,
    this.reviewCount,
    this.view,
  });

  Provider copyWith({
    String? id,
    BranchName? providerName,
    String? providerImage,
    String? providerCover,
    BranchName? description,
    DateTime? createdAt,
    int? totalReviews,
    int? reviewCount,
    String? view,
  }) =>
      Provider(
        id: id ?? this.id,
        providerName: providerName ?? this.providerName,
        providerImage: providerImage ?? this.providerImage,
        providerCover: providerCover ?? this.providerCover,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        totalReviews: totalReviews ?? this.totalReviews,
        reviewCount: reviewCount ?? this.reviewCount,
        view: view ?? this.view,
      );

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        providerName: json["provider_name"] == null
            ? null
            : BranchName.fromJson(json["provider_name"]),
        providerImage: json["provider_image"],
        providerCover: json["provider_cover"],
        description: json["description"] == null
            ? null
            : BranchName.fromJson(json["description"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        totalReviews: json["totalReviews"],
        reviewCount: json["reviewCount"],
        view: json["view"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provider_name": providerName?.toJson(),
        "provider_image": providerImage,
        "provider_cover": providerCover,
        "description": description?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "totalReviews": totalReviews,
        "reviewCount": reviewCount,
        "view": view,
      };
}
