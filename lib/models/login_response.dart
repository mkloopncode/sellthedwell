class UserSubscription {
/*
{
  "id": 279,
  "package_id": 1,
  "user_id": 125,
  "price": "0",
  "noofdays": 0,
  "payment_status": 2,
  "paypal_payment_id": "",
  "created_date": "0000-00-00",
  "created_at": "2022-07-19 17:02:02",
  "package_name": "FREE",
  "type": 1,
  "expiry_date": "-0001-11-30"
} 
*/

  int? id;
  int? packageId;
  int? userId;
  String? price;
  int? noofdays;
  int? paymentStatus;
  String? paypalPaymentId;
  String? createdDate;
  String? createdAt;
  String? packageName;
  int? type;
  String? expiryDate;

  UserSubscription({
    this.id,
    this.packageId,
    this.userId,
    this.price,
    this.noofdays,
    this.paymentStatus,
    this.paypalPaymentId,
    this.createdDate,
    this.createdAt,
    this.packageName,
    this.type,
    this.expiryDate,
  });
  UserSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    packageId = json['package_id']?.toInt();
    userId = json['user_id']?.toInt();
    price = json['price']?.toString();
    noofdays = json['noofdays']?.toInt();
    paymentStatus = json['payment_status']?.toInt();
    paypalPaymentId = json['paypal_payment_id']?.toString();
    createdDate = json['created_date']?.toString();
    createdAt = json['created_at']?.toString();
    packageName = json['package_name']?.toString();
    type = json['type']?.toInt();
    expiryDate = json['expiry_date']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['package_id'] = packageId;
    data['user_id'] = userId;
    data['price'] = price;
    data['noofdays'] = noofdays;
    data['payment_status'] = paymentStatus;
    data['paypal_payment_id'] = paypalPaymentId;
    data['created_date'] = createdDate;
    data['created_at'] = createdAt;
    data['package_name'] = packageName;
    data['type'] = type;
    data['expiry_date'] = expiryDate;
    return data;
  }
}

class UserLoginResponse {
/*
{
  "id": 125,
  "name": "amit",
  "email": "amit@gmail.com",
  "phone": "8209240091",
  "address": "test",
  "city": "",
  "state": "",
  "country": "",
  "zipcode": "",
  "OTP": null,
  "device_type": "android",
  "firebase_token": "",
  "password": "$2y$10$gotvpVolfODg8kFSphrdROr1ipNqiIaAKMV9AQ0ucHmMbuhhSNMPW",
  "profile_pic": "",
  "created_at": "2022-07-20T00:02:02.000000Z",
  "updated_at": "2022-07-20T05:13:22.000000Z",
  "status": 1,
  "property_credit": 1,
  "notification_enable": 0,
  "promotions_enable": 0,
  "history_enable": 0,
  "subscription": {
    "id": 279,
    "package_id": 1,
    "user_id": 125,
    "price": "0",
    "noofdays": 0,
    "payment_status": 2,
    "paypal_payment_id": "",
    "created_date": "0000-00-00",
    "created_at": "2022-07-19 17:02:02",
    "package_name": "FREE",
    "type": 1,
    "expiry_date": "-0001-11-30"
  },
  "published_properties": 0
} 
*/

  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? OTP;
  String? deviceType;
  String? firebaseToken;
  String? password;
  String? profilePic;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? propertyCredit;
  int? notificationEnable;
  int? promotionsEnable;
  int? historyEnable;
  UserSubscription? subscription;
  int? publishedProperties;

  UserLoginResponse({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.OTP,
    this.deviceType,
    this.firebaseToken,
    this.password,
    this.profilePic,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.propertyCredit,
    this.notificationEnable,
    this.promotionsEnable,
    this.historyEnable,
    this.subscription,
    this.publishedProperties,
  });
  UserLoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    address = json['address']?.toString();
    city = json['city']?.toString();
    state = json['state']?.toString();
    country = json['country']?.toString();
    zipcode = json['zipcode']?.toString();
    OTP = json['OTP']?.toString();
    deviceType = json['device_type']?.toString();
    firebaseToken = json['firebase_token']?.toString();
    password = json['password']?.toString();
    profilePic = json['profile_pic']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    status = json['status']?.toInt();
    propertyCredit = json['property_credit']?.toInt();
    notificationEnable = json['notification_enable']?.toInt();
    promotionsEnable = json['promotions_enable']?.toInt();
    historyEnable = json['history_enable']?.toInt();
    subscription = (json['subscription'] != null)
        ? UserSubscription.fromJson(json['subscription'])
        : null;
    publishedProperties = json['published_properties']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipcode'] = zipcode;
    data['OTP'] = OTP;
    data['device_type'] = deviceType;
    data['firebase_token'] = firebaseToken;
    data['password'] = password;
    data['profile_pic'] = profilePic;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['property_credit'] = propertyCredit;
    data['notification_enable'] = notificationEnable;
    data['promotions_enable'] = promotionsEnable;
    data['history_enable'] = historyEnable;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    data['published_properties'] = publishedProperties;
    return data;
  }
}
