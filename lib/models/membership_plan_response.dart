///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class MembershipPlanResponseSubscription {
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

  MembershipPlanResponseSubscription({
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
  MembershipPlanResponseSubscription.fromJson(Map<String, dynamic> json) {
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

class MembershipPlanResponse {
/*
{
  "id": 1,
  "name": "FREE",
  "content": "<ul class=\"list-unstyled pricing-list\">             <li>One Category Listing <span data-toggle=\"tooltip\" data-placement=\"top\" title=\"\" data-original-title=\"I'm pricing note content\"> <i class=\"fas fa-question-circle\"></i></span> </li>             <li>1 month Free<span data-toggle=\"tooltip\" data-placement=\"top\" title=\"\" data-original-title=\"I'm pricing note content\"> <i class=\"fas fa-question-circle\"></i></span></li>             <li>Basic Email Support</li>             <li>No Payment Guarantee</li>           </ul>",
  "features_list": "80,79",
  "features_visible": "",
  "price": 0,
  "enable_video_call": 3,
  "currency_id": 1,
  "type": 1,
  "noofdays": 0,
  "number_of_listings": 4,
  "order": 0,
  "can_add_featured": 0,
  "is_default": 0,
  "status": "published",
  "created_at": "2020-03-24 18:21:49",
  "updated_at": "2022-07-03 21:26:02",
  "percent_save": 0,
  "featured_property": 0,
  "free_magazine": 0,
  "access_realestate_nmarket_data": 0,
  "account_limit": 1,
  "max_video_call": "100",
  "check_one": "1",
  "check_two": "",
  "check_three": "",
  "show_only_available_on_user_side": 0,
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
  }
} 
*/

  int? id;
  String? name;
  String? content;
  String? featuresList;
  String? featuresVisible;
  int? price;
  int? enableVideoCall;
  int? currencyId;
  int? type;
  int? noofdays;
  int? numberOfListings;
  int? order;
  int? canAddFeatured;
  int? isDefault;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? percentSave;
  int? featuredProperty;
  int? freeMagazine;
  int? accessRealestateNmarketData;
  int? accountLimit;
  String? maxVideoCall;
  String? checkOne;
  String? checkTwo;
  String? checkThree;
  int? showOnlyAvailableOnUserSide;
  MembershipPlanResponseSubscription? subscription;

  MembershipPlanResponse({
    this.id,
    this.name,
    this.content,
    this.featuresList,
    this.featuresVisible,
    this.price,
    this.enableVideoCall,
    this.currencyId,
    this.type,
    this.noofdays,
    this.numberOfListings,
    this.order,
    this.canAddFeatured,
    this.isDefault,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.percentSave,
    this.featuredProperty,
    this.freeMagazine,
    this.accessRealestateNmarketData,
    this.accountLimit,
    this.maxVideoCall,
    this.checkOne,
    this.checkTwo,
    this.checkThree,
    this.showOnlyAvailableOnUserSide,
    this.subscription,
  });
  MembershipPlanResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    content = json['content']?.toString();
    featuresList = json['features_list']?.toString();
    featuresVisible = json['features_visible']?.toString();
    price = json['price']?.toInt();
    enableVideoCall = json['enable_video_call']?.toInt();
    currencyId = json['currency_id']?.toInt();
    type = json['type']?.toInt();
    noofdays = json['noofdays']?.toInt();
    numberOfListings = json['number_of_listings']?.toInt();
    order = json['order']?.toInt();
    canAddFeatured = json['can_add_featured']?.toInt();
    isDefault = json['is_default']?.toInt();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    percentSave = json['percent_save']?.toInt();
    featuredProperty = json['featured_property']?.toInt();
    freeMagazine = json['free_magazine']?.toInt();
    accessRealestateNmarketData = json['access_realestate_nmarket_data']?.toInt();
    accountLimit = json['account_limit']?.toInt();
    maxVideoCall = json['max_video_call']?.toString();
    checkOne = json['check_one']?.toString();
    checkTwo = json['check_two']?.toString();
    checkThree = json['check_three']?.toString();
    showOnlyAvailableOnUserSide = json['show_only_available_on_user_side']?.toInt();
    subscription = (json['subscription'] != null) ? MembershipPlanResponseSubscription.fromJson(json['subscription']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['content'] = content;
    data['features_list'] = featuresList;
    data['features_visible'] = featuresVisible;
    data['price'] = price;
    data['enable_video_call'] = enableVideoCall;
    data['currency_id'] = currencyId;
    data['type'] = type;
    data['noofdays'] = noofdays;
    data['number_of_listings'] = numberOfListings;
    data['order'] = order;
    data['can_add_featured'] = canAddFeatured;
    data['is_default'] = isDefault;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['percent_save'] = percentSave;
    data['featured_property'] = featuredProperty;
    data['free_magazine'] = freeMagazine;
    data['access_realestate_nmarket_data'] = accessRealestateNmarketData;
    data['account_limit'] = accountLimit;
    data['max_video_call'] = maxVideoCall;
    data['check_one'] = checkOne;
    data['check_two'] = checkTwo;
    data['check_three'] = checkThree;
    data['show_only_available_on_user_side'] = showOnlyAvailableOnUserSide;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    return data;
  }
}