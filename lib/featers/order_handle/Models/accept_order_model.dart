class AcceptOrderModel {
  final String? id;
  final int? totalPrice;
  final int? shippingPrice;
  final int? subtotal;
  final int? discount;
  final dynamic coupon;
  final dynamic location;
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
  final Customer? customer;
  final Branch? branch;
  final Provider? provider;
  final List<ItemElement>? items;
  final DeliveryPartner? deliveryPartner;

  AcceptOrderModel({
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
    this.customer,
    this.branch,
    this.provider,
    this.items,
    this.deliveryPartner,
  });

  AcceptOrderModel copyWith({
    String? id,
    int? totalPrice,
    int? shippingPrice,
    int? subtotal,
    int? discount,
    dynamic coupon,
    dynamic location,
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
    Customer? customer,
    Branch? branch,
    Provider? provider,
    List<ItemElement>? items,
    DeliveryPartner? deliveryPartner,
  }) =>
      AcceptOrderModel(
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
        customer: customer ?? this.customer,
        branch: branch ?? this.branch,
        provider: provider ?? this.provider,
        items: items ?? this.items,
        deliveryPartner: deliveryPartner ?? this.deliveryPartner,
      );

  factory AcceptOrderModel.fromJson(Map<String, dynamic> json) =>
      AcceptOrderModel(
        id: json["id"],
        totalPrice: json["totalPrice"],
        shippingPrice: json["shippingPrice"],
        subtotal: json["subtotal"],
        discount: json["discount"],
        coupon: json["coupon"],
        location: json["location"],
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
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
        items: json["items"] == null
            ? []
            : List<ItemElement>.from(
                json["items"]!.map((x) => ItemElement.fromJson(x))),
        deliveryPartner: json["deliveryPartner"] == null
            ? null
            : DeliveryPartner.fromJson(json["deliveryPartner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalPrice": totalPrice,
        "shippingPrice": shippingPrice,
        "subtotal": subtotal,
        "discount": discount,
        "coupon": coupon,
        "location": location,
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
        "customer": customer?.toJson(),
        "branch": branch?.toJson(),
        "provider": provider?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "deliveryPartner": deliveryPartner?.toJson(),
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
  final dynamic gender;
  final String? phoneNumber;
  final String? address;
  final String? referCode;
  final int? totalReviews;
  final int? reviewCount;
  final Location? location;
  final String? locale;
  final dynamic macAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Address>? addresses;

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
    this.addresses,
  });

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    dynamic birthdate,
    dynamic gender,
    String? phoneNumber,
    String? address,
    String? referCode,
    int? totalReviews,
    int? reviewCount,
    Location? location,
    String? locale,
    dynamic macAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Address>? addresses,
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
        addresses: addresses ?? this.addresses,
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
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        locale: json["locale"],
        macAddress: json["macAddress"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
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
        "location": location?.toJson(),
        "locale": locale,
        "macAddress": macAddress,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
      };
}

class Address {
  final String? id;
  final String? name;
  final String? description;
  final Location? location;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Address({
    this.id,
    this.name,
    this.description,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  Address copyWith({
    String? id,
    String? name,
    String? description,
    Location? location,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Address(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        location: location ?? this.location,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
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
        "description": description,
        "location": location?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class DeliveryPartner {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? profilePhoto;
  final String? district;
  final String? residencyNumber;
  final String? residencyPhoto;
  final String? licenseNumber;
  final String? licensePhoto;
  final String? status;
  final String? vehicleNumber;
  final String? vehicleLicensePhoto;
  final Location? location;
  final bool? isAvailable;
  final DateTime? createdAt;
  final int? totalReviews;
  final int? reviewCount;
  final String? password;
  final dynamic forgetPasswordToken;
  final int? totalEarned;
  final int? ordersCount;
  final bool? isOnline;
  final DateTime? lastOnline;
  final String? areaId;

  DeliveryPartner({
    this.id,
    this.name,
    this.phoneNumber,
    this.profilePhoto,
    this.district,
    this.residencyNumber,
    this.residencyPhoto,
    this.licenseNumber,
    this.licensePhoto,
    this.status,
    this.vehicleNumber,
    this.vehicleLicensePhoto,
    this.location,
    this.isAvailable,
    this.createdAt,
    this.totalReviews,
    this.reviewCount,
    this.password,
    this.forgetPasswordToken,
    this.totalEarned,
    this.ordersCount,
    this.isOnline,
    this.lastOnline,
    this.areaId,
  });

  DeliveryPartner copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? profilePhoto,
    String? district,
    String? residencyNumber,
    String? residencyPhoto,
    String? licenseNumber,
    String? licensePhoto,
    String? status,
    String? vehicleNumber,
    String? vehicleLicensePhoto,
    Location? location,
    bool? isAvailable,
    DateTime? createdAt,
    int? totalReviews,
    int? reviewCount,
    String? password,
    dynamic forgetPasswordToken,
    int? totalEarned,
    int? ordersCount,
    bool? isOnline,
    DateTime? lastOnline,
    String? areaId,
  }) =>
      DeliveryPartner(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        district: district ?? this.district,
        residencyNumber: residencyNumber ?? this.residencyNumber,
        residencyPhoto: residencyPhoto ?? this.residencyPhoto,
        licenseNumber: licenseNumber ?? this.licenseNumber,
        licensePhoto: licensePhoto ?? this.licensePhoto,
        status: status ?? this.status,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        vehicleLicensePhoto: vehicleLicensePhoto ?? this.vehicleLicensePhoto,
        location: location ?? this.location,
        isAvailable: isAvailable ?? this.isAvailable,
        createdAt: createdAt ?? this.createdAt,
        totalReviews: totalReviews ?? this.totalReviews,
        reviewCount: reviewCount ?? this.reviewCount,
        password: password ?? this.password,
        forgetPasswordToken: forgetPasswordToken ?? this.forgetPasswordToken,
        totalEarned: totalEarned ?? this.totalEarned,
        ordersCount: ordersCount ?? this.ordersCount,
        isOnline: isOnline ?? this.isOnline,
        lastOnline: lastOnline ?? this.lastOnline,
        areaId: areaId ?? this.areaId,
      );

  factory DeliveryPartner.fromJson(Map<String, dynamic> json) =>
      DeliveryPartner(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        profilePhoto: json["profilePhoto"],
        district: json["district"],
        residencyNumber: json["residencyNumber"],
        residencyPhoto: json["residencyPhoto"],
        licenseNumber: json["licenseNumber"],
        licensePhoto: json["licensePhoto"],
        status: json["status"],
        vehicleNumber: json["vehicleNumber"],
        vehicleLicensePhoto: json["vehicleLicensePhoto"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        isAvailable: json["isAvailable"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        totalReviews: json["totalReviews"],
        reviewCount: json["reviewCount"],
        password: json["password"],
        forgetPasswordToken: json["forgetPasswordToken"],
        totalEarned: json["totalEarned"],
        ordersCount: json["ordersCount"],
        isOnline: json["isOnline"],
        lastOnline: json["lastOnline"] == null
            ? null
            : DateTime.parse(json["lastOnline"]),
        areaId: json["areaId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "profilePhoto": profilePhoto,
        "district": district,
        "residencyNumber": residencyNumber,
        "residencyPhoto": residencyPhoto,
        "licenseNumber": licenseNumber,
        "licensePhoto": licensePhoto,
        "status": status,
        "vehicleNumber": vehicleNumber,
        "vehicleLicensePhoto": vehicleLicensePhoto,
        "location": location?.toJson(),
        "isAvailable": isAvailable,
        "createdAt": createdAt?.toIso8601String(),
        "totalReviews": totalReviews,
        "reviewCount": reviewCount,
        "password": password,
        "forgetPasswordToken": forgetPasswordToken,
        "totalEarned": totalEarned,
        "ordersCount": ordersCount,
        "isOnline": isOnline,
        "lastOnline": lastOnline?.toIso8601String(),
        "areaId": areaId,
      };
}

class ItemElement {
  final String? id;
  final int? quantity;
  final String? image;
  final double? price;
  final int? salePrice;
  final ItemItem? item;
  final List<dynamic>? selectedOptionGroups;

  ItemElement({
    this.id,
    this.quantity,
    this.image,
    this.price,
    this.salePrice,
    this.item,
    this.selectedOptionGroups,
  });

  ItemElement copyWith({
    String? id,
    int? quantity,
    String? image,
    double? price,
    int? salePrice,
    ItemItem? item,
    List<dynamic>? selectedOptionGroups,
  }) =>
      ItemElement(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        price: price ?? this.price,
        salePrice: salePrice ?? this.salePrice,
        item: item ?? this.item,
        selectedOptionGroups: selectedOptionGroups ?? this.selectedOptionGroups,
      );

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
        id: json["id"],
        quantity: json["quantity"],
        image: json["image"],
        price: json["price"]?.toDouble(),
        salePrice: json["salePrice"],
        item: json["item"] == null ? null : ItemItem.fromJson(json["item"]),
        selectedOptionGroups: json["selectedOptionGroups"] == null
            ? []
            : List<dynamic>.from(json["selectedOptionGroups"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "image": image,
        "price": price,
        "salePrice": salePrice,
        "item": item?.toJson(),
        "selectedOptionGroups": selectedOptionGroups == null
            ? []
            : List<dynamic>.from(selectedOptionGroups!.map((x) => x)),
      };
}

class ItemItem {
  final String? id;
  final String? itemType;
  final BranchName? name;
  final int? calories;
  final double? price;
  final int? salePrice;
  final bool? topItem;
  final String? approvalStatus;
  final dynamic rejectionNotes;
  final String? image;
  final int? totalReviews;
  final int? reviewCount;
  final BranchName? description;
  final Provider? provider;
  final List<dynamic>? optionGroups;

  ItemItem({
    this.id,
    this.itemType,
    this.name,
    this.calories,
    this.price,
    this.salePrice,
    this.topItem,
    this.approvalStatus,
    this.rejectionNotes,
    this.image,
    this.totalReviews,
    this.reviewCount,
    this.description,
    this.provider,
    this.optionGroups,
  });

  ItemItem copyWith({
    String? id,
    String? itemType,
    BranchName? name,
    int? calories,
    double? price,
    int? salePrice,
    bool? topItem,
    String? approvalStatus,
    dynamic rejectionNotes,
    String? image,
    int? totalReviews,
    int? reviewCount,
    BranchName? description,
    Provider? provider,
    List<dynamic>? optionGroups,
  }) =>
      ItemItem(
        id: id ?? this.id,
        itemType: itemType ?? this.itemType,
        name: name ?? this.name,
        calories: calories ?? this.calories,
        price: price ?? this.price,
        salePrice: salePrice ?? this.salePrice,
        topItem: topItem ?? this.topItem,
        approvalStatus: approvalStatus ?? this.approvalStatus,
        rejectionNotes: rejectionNotes ?? this.rejectionNotes,
        image: image ?? this.image,
        totalReviews: totalReviews ?? this.totalReviews,
        reviewCount: reviewCount ?? this.reviewCount,
        description: description ?? this.description,
        provider: provider ?? this.provider,
        optionGroups: optionGroups ?? this.optionGroups,
      );

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
        id: json["id"],
        itemType: json["itemType"],
        name: json["name"] == null ? null : BranchName.fromJson(json["name"]),
        calories: json["calories"],
        price: json["price"]?.toDouble(),
        salePrice: json["salePrice"],
        topItem: json["top_item"],
        approvalStatus: json["approval_status"],
        rejectionNotes: json["rejection_notes"],
        image: json["image"],
        totalReviews: json["totalReviews"],
        reviewCount: json["reviewCount"],
        description: json["description"] == null
            ? null
            : BranchName.fromJson(json["description"]),
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
        optionGroups: json["optionGroups"] == null
            ? []
            : List<dynamic>.from(json["optionGroups"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemType": itemType,
        "name": name?.toJson(),
        "calories": calories,
        "price": price,
        "salePrice": salePrice,
        "top_item": topItem,
        "approval_status": approvalStatus,
        "rejection_notes": rejectionNotes,
        "image": image,
        "totalReviews": totalReviews,
        "reviewCount": reviewCount,
        "description": description?.toJson(),
        "provider": provider?.toJson(),
        "optionGroups": optionGroups == null
            ? []
            : List<dynamic>.from(optionGroups!.map((x) => x)),
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
