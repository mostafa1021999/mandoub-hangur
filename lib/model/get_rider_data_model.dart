class RiderData {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? profilePhoto;
  final String? city;
  final String? district;
  final String? residencyNumber;
  final String? residencyPhoto;
  final String? licenseNumber;
  final String? licensePhoto;
  final String? status;
  final String? vehicleNumber;
  final String? vehicleLicensePhoto;
  final Null currentLocation;
  final bool? isAvailable;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;
  final String? password;
  final List<Orders>? orders;
  final Company? company;
  final Area? area;

  RiderData({
    this.id,
    this.name,
    this.phoneNumber,
    this.profilePhoto,
    this.city,
    this.district,
    this.residencyNumber,
    this.residencyPhoto,
    this.licenseNumber,
    this.licensePhoto,
    this.status,
    this.vehicleNumber,
    this.vehicleLicensePhoto,
    this.currentLocation,
    this.isAvailable,
    this.createdAt,
    this.totalReviews,
    this.reviewCount,
    this.password,
    this.orders,
    this.company,
    this.area
  });

  factory RiderData.fromJson(Map<String, dynamic> json) {
    return RiderData(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      profilePhoto: json['profilePhoto'],
      city: json['city'],
      district: json['district'],
      residencyNumber: json['residencyNumber'],
      residencyPhoto: json['residencyPhoto'],
      licenseNumber: json['licenseNumber'],
      licensePhoto: json['licensePhoto'],
      status: json['status'],
      vehicleNumber: json['vehicleNumber'],
      vehicleLicensePhoto: json['vehicleLicensePhoto'],
      currentLocation: json['currentLocation'],
      isAvailable: json['isAvailable'],
      createdAt: json['createdAt'],
      totalReviews: json['totalReviews'],
      reviewCount: json['reviewCount'],
      password: json['password'],
      area: json['area'] != null ? Area.fromJson(json['area']) : null,
      orders: json['orders'] != null ? (json['orders'] as List).map((i) => Orders.fromJson(i)).toList() : null,
      company: json['company'] != null ? Company.fromJson(json['company']) : null,);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['profilePhoto'] = profilePhoto;
    data['city'] = city;
    data['district'] = district;
    data['residencyNumber'] = residencyNumber;
    data['residencyPhoto'] = residencyPhoto;
    data['licenseNumber'] = licenseNumber;
    data['licensePhoto'] = licensePhoto;
    data['status'] = status;
    data['vehicleNumber'] = vehicleNumber;
    data['vehicleLicensePhoto'] = vehicleLicensePhoto;
    data['currentLocation'] = currentLocation;
    data['isAvailable'] = isAvailable;
    data['createdAt'] = createdAt;
    data['totalReviews'] = totalReviews;
    data['reviewCount'] = reviewCount;
    data['password'] = password;
    data['area'] = area;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Orders {
  final String? id;
  final int? totalPrice;
  final int? shippingPrice;
  final int? subtotal;
  final int? discount;
  final Coupon? coupon;
  final Location? location;
  final String? status;
  final int? serial;
  final String? createdAt;
  final String? updatedAt;
  final String? customerNotes;
  final Customer? customer;
  final List<Items>? items;
  final DeliveryPartner? deliveryPartner;
  final Provider? provider;

  Orders(
      {this.id,
      this.totalPrice,
      this.shippingPrice,
      this.subtotal,
      this.discount,
      this.coupon,
      this.location,
      this.status,
      this.serial,
      this.createdAt,
      this.updatedAt,
      this.customerNotes,
      this.customer,
      this.items,
      this.deliveryPartner,
      this.provider});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json['id'],
      totalPrice: json['totalPrice'],
      shippingPrice: json['shippingPrice'],
      subtotal: json['subtotal'],
      discount: json['discount'],
      coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null,
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      status: json['status'],
      serial: json['serial'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      customerNotes: json['customerNotes'],
      customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      items: json['items'] != null
          ? List<Items>.from(json['items'].map((x) => Items.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalPrice'] = totalPrice;
    data['shippingPrice'] = shippingPrice;
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    if (coupon != null) {
      data['coupon'] = coupon!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['status'] = status;
    data['serial'] = serial;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['customerNotes'] = customerNotes;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (deliveryPartner != null) {
      data['deliveryPartner'] = deliveryPartner!.toJson();
    }
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    return data;
  }
}

class Coupon {
  final String? id;
  final String? code;
  final String? type;
  final String? status;
  final Null customer;
  final String? appliedOn;
  final Null maxAmount;
  final Null minAmount;
  final int? usageCount;
  final int? fixedAmount;
  final Null percentageAmount;
  final bool? applyToAllProviders;

  Coupon(
      {this.id,
        this.code,
        this.type,
        this.status,
        this.customer,
        this.appliedOn,
        this.maxAmount,
        this.minAmount,
        this.usageCount,
        this.fixedAmount,
        this.percentageAmount,
        this.applyToAllProviders});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
      type: json['type'],
      status: json['status'],
      customer: json['customer'],
      appliedOn: json['appliedOn'],
      maxAmount: json['maxAmount'],
      minAmount: json['minAmount'],
      usageCount: json['usageCount'],
      fixedAmount: json['fixedAmount'],
      percentageAmount: json['percentageAmount'],
      applyToAllProviders: json['applyToAllProviders'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['type'] = type;
    data['status'] = status;
    data['customer'] = customer;
    data['appliedOn'] = appliedOn;
    data['maxAmount'] = maxAmount;
    data['minAmount'] = minAmount;
    data['usageCount'] = usageCount;
    data['fixedAmount'] = fixedAmount;
    data['percentageAmount'] = percentageAmount;
    data['applyToAllProviders'] = applyToAllProviders;
    return data;
  }
}

class Location {
  final String? type;
  final List<int>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: json['coordinates'].cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class Customer {
  final String? id;
  final String? name;
  final String? email;
  final Null birthdate;
  final String? phoneNumber;
  final String? address;
  final bool? isDeleted;

  Customer({this.id, this.name, this.email, this.birthdate, this.phoneNumber, this.address, this.isDeleted});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthdate: json['birthdate'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      isDeleted: json['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['birthdate'] = birthdate;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['isDeleted'] = isDeleted;
    return data;
  }
}

class Items {
  final String? id;
  final int? quantity;
  final String? image;
  final int? price;

  Items({this.id, this.quantity, this.image, this.price});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      quantity: json['quantity'],
      image: json['image'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['image'] = image;
    data['price'] = price;
    return data;
  }
}

class DeliveryPartner {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? profilePhoto;
  final String? city;
  final String? district;
  final String? residencyNumber;
  final String? residencyPhoto;
  final String? licenseNumber;
  final String? licensePhoto;
  final String? status;
  final String? vehicleNumber;
  final String? vehicleLicensePhoto;
  final Null currentLocation;
  final bool? isAvailable;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;
  final String? password;
  DeliveryPartner({this.password,
    this.id,
    this.name,
    this.phoneNumber,
    this.profilePhoto,
    this.city,
    this.district,
    this.residencyNumber,
    this.residencyPhoto,
    this.licenseNumber,
    this.licensePhoto,
    this.status,
    this.vehicleNumber,
    this.vehicleLicensePhoto,
    this.currentLocation,
    this.isAvailable,
    this.createdAt,
    this.totalReviews,
    this.reviewCount});

  factory DeliveryPartner.fromJson(Map<String, dynamic> json) {
    return DeliveryPartner(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      profilePhoto: json['profilePhoto'],
      city: json['city'],
      district: json['district'],
      residencyNumber: json['residencyNumber'],
      residencyPhoto: json['residencyPhoto'],
      licenseNumber: json['licenseNumber'],
      licensePhoto: json['licensePhoto'],
      status: json['status'],
      vehicleNumber: json['vehicleNumber'],
      vehicleLicensePhoto: json['vehicleLicensePhoto'],
      currentLocation: json['currentLocation'],
      isAvailable: json['isAvailable'],
      createdAt: json['createdAt'],
      totalReviews: json['totalReviews'],
      reviewCount: json['reviewCount'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['profilePhoto'] = profilePhoto;
    data['city'] = city;
    data['district'] = district;
    data['residencyNumber'] = residencyNumber;
    data['residencyPhoto'] = residencyPhoto;
    data['licenseNumber'] = licenseNumber;
    data['licensePhoto'] = licensePhoto;
    data['status'] = status;
    data['vehicleNumber'] = vehicleNumber;
    data['vehicleLicensePhoto'] = vehicleLicensePhoto;
    data['currentLocation'] = currentLocation;
    data['isAvailable'] = isAvailable;
    data['createdAt'] = createdAt;
    data['totalReviews'] = totalReviews;
    data['reviewCount'] = reviewCount;
    return data;
  }
}

class Provider {
  final String? id;
  final ProviderName? providerName;
  final String? providerImage;
  final String? providerCover;
  final ProviderName? description;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;

  Provider({this.id, this.providerName, this.providerImage, this.providerCover, this.description, this.createdAt, this.totalReviews, this.reviewCount});

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      providerName: json['provider_name'] != null
          ?  ProviderName.fromJson(json['provider_name'])
          : null,
      providerImage: json['provider_image'],
      providerCover: json['provider_cover'],
      description: json['description'] != null
          ?  ProviderName.fromJson(json['description'])
          : null,
      createdAt: json['createdAt'],
      totalReviews: json['totalReviews'],
      reviewCount: json['reviewCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_name'] = providerName;
    data['provider_image'] = providerImage;
    data['provider_cover'] = providerCover;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['totalReviews'] = totalReviews;
    data['reviewCount'] = reviewCount;
    return data;
  }
}

class ProviderName {
  final String? ar;
  final String? en;

  ProviderName({this.ar, this.en});

  factory ProviderName.fromJson(Map<String, dynamic> json) {
    return ProviderName(
      ar: json['ar'],
      en: json['en'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    data['en'] = en;
    return data;
  }
}

class Company {
  final String? id;
  final ProviderName? name;
  final String? image;
  final String? createdAt;

  Company({this.id, this.name, this.image, this.createdAt});
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'] != null
          ? new ProviderName.fromJson(json['name'])
          : null,
      image: json['image'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    data['createdAt'] = createdAt;
    return data;
  }
}
class Area {
  final String? id;
  final String? description;
  final int? shippingCost;
  final String? name;
  final List<Coordinates>? coordinates;
  final String? cityId;

  Area(
      {this.id,
        this.description,
        this.shippingCost,
        this.name,
        this.coordinates,
        this.cityId});
  factory Area.fromJson(Map<String, dynamic> map) {
    return Area(
      id: map['id'],
      description: map['description'],
      shippingCost: map['shippingCost'],
      name: map['name'],
      coordinates: map['coordinates'] != null
          ? (map['coordinates'] as List).map((item) => Coordinates.fromJson(item)).toList()
          : null,
      cityId: map['cityId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['shippingCost'] = shippingCost;
    data['name'] = name;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.map((v) => v.toJson()).toList();
    }
    data['cityId'] = cityId;
    return data;
  }
}
class Coordinates {
  final Point? point;

  Coordinates({this.point});
  factory Coordinates.fromJson(Map<String, dynamic> map) {
    return Coordinates(
      point: Point.fromJson(map['point']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (point != null) {
      data['point'] = point!.toJson();
    }
    return data;
  }
}
class Point {
  final String? type;
  final List<double>? coordinates;

  Point({this.type, this.coordinates});
  factory Point.fromJson(Map<String, dynamic> map) {
    return Point(
      type: map['type'],
      coordinates: map['coordinates'].cast<double>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}