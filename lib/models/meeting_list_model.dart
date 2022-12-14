///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class MeetingListModelPropertyDetails {
/*
{
  "id": 103,
  "name": "52 BEVERLY ROAD Chicago, IL 60643",
  "content": "<p>About</p>",
  "build_year": "1970-01-01",
  "parking": null,
  "location": "1735 W 107th St, Chicago, IL 60643, USA",
  "latitude": "41.699009",
  "longitude": "-87.66576119999999",
  "images": "[\"ch4.jpg\",\"ch3.jpg\",\"ch2.jpg\",\"ch1.jpg\"]",
  "video_type": 1,
  "video_link": "",
  "project_id": 0,
  "number_bedroom": 4,
  "number_bathroom": 3,
  "number_floor": 0,
  "square": 4098,
  "lot_size": "212",
  "price": "245000",
  "price_unit": null,
  "is_featured": 1,
  "status": "selling",
  "created_at": "2020-11-01 04:44:01",
  "updated_at": "2022-06-14 00:13:21",
  "type": "0",
  "description": "Beverly-Morgan Park Victorian beauty",
  "monthly_mortage": "null",
  "local_legal_protections": "null",
  "property_taxes_and_assessments": "null",
  "price_history": "undefined",
  "public_records": "null",
  "pet": "DOG",
  "currency_id": null,
  "city_id": 0,
  "period": "month",
  "view_type": "Beach",
  "author_id": 19,
  "author_type": "Botble\\ACL\\Models\\User",
  "category_id": 13,
  "moderation_status": "approved",
  "expire_date": "2023-01-26",
  "auto_renew": 0,
  "never_expired": null,
  "active_start_date": "01-19-2023",
  "active_dates": "01-19-2023,01-21-2023,01-25-2023,01-24-2023,01-23-2023",
  "dmodelview_images": null,
  "dmodel": null,
  "virtual_reality": null,
  "image": [
    "ch4.jpg"
  ],
  "listimage": "ch4.jpg"
} 
*/

  int? id;
  String? name;
  String? content;
  String? buildYear;
  String? parking;
  String? location;
  String? latitude;
  String? longitude;
  String? images;
  int? videoType;
  String? videoLink;
  int? projectId;
  int? numberBedroom;
  int? numberBathroom;
  int? numberFloor;
  int? square;
  String? lotSize;
  String? price;
  String? priceUnit;
  int? isFeatured;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? description;
  String? monthlyMortage;
  String? localLegalProtections;
  String? propertyTaxesAndAssessments;
  String? priceHistory;
  String? publicRecords;
  String? pet;
  String? currencyId;
  int? cityId;
  String? period;
  String? viewType;
  int? authorId;
  String? authorType;
  int? categoryId;
  String? moderationStatus;
  String? expireDate;
  int? autoRenew;
  String? neverExpired;
  String? activeStartDate;
  String? activeDates;
  String? dmodelviewImages;
  String? dmodel;
  String? virtualReality;
  List<String?>? image;
  String? listimage;

  MeetingListModelPropertyDetails({
    this.id,
    this.name,
    this.content,
    this.buildYear,
    this.parking,
    this.location,
    this.latitude,
    this.longitude,
    this.images,
    this.videoType,
    this.videoLink,
    this.projectId,
    this.numberBedroom,
    this.numberBathroom,
    this.numberFloor,
    this.square,
    this.lotSize,
    this.price,
    this.priceUnit,
    this.isFeatured,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.description,
    this.monthlyMortage,
    this.localLegalProtections,
    this.propertyTaxesAndAssessments,
    this.priceHistory,
    this.publicRecords,
    this.pet,
    this.currencyId,
    this.cityId,
    this.period,
    this.viewType,
    this.authorId,
    this.authorType,
    this.categoryId,
    this.moderationStatus,
    this.expireDate,
    this.autoRenew,
    this.neverExpired,
    this.activeStartDate,
    this.activeDates,
    this.dmodelviewImages,
    this.dmodel,
    this.virtualReality,
    this.image,
    this.listimage,
  });
  MeetingListModelPropertyDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    content = json['content']?.toString();
    buildYear = json['build_year']?.toString();
    parking = json['parking']?.toString();
    location = json['location']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    images = json['images']?.toString();
    videoType = json['video_type']?.toInt();
    videoLink = json['video_link']?.toString();
    projectId = json['project_id']?.toInt();
    numberBedroom = json['number_bedroom']?.toInt();
    numberBathroom = json['number_bathroom']?.toInt();
    numberFloor = json['number_floor']?.toInt();
    square = json['square']?.toInt();
    lotSize = json['lot_size']?.toString();
    price = json['price']?.toString();
    priceUnit = json['price_unit']?.toString();
    isFeatured = json['is_featured']?.toInt();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    type = json['type']?.toString();
    description = json['description']?.toString();
    monthlyMortage = json['monthly_mortage']?.toString();
    localLegalProtections = json['local_legal_protections']?.toString();
    propertyTaxesAndAssessments =
        json['property_taxes_and_assessments']?.toString();
    priceHistory = json['price_history']?.toString();
    publicRecords = json['public_records']?.toString();
    pet = json['pet']?.toString();
    currencyId = json['currency_id']?.toString();
    cityId = json['city_id']?.toInt();
    period = json['period']?.toString();
    viewType = json['view_type']?.toString();
    authorId = json['author_id']?.toInt();
    authorType = json['author_type']?.toString();
    categoryId = json['category_id']?.toInt();
    moderationStatus = json['moderation_status']?.toString();
    expireDate = json['expire_date']?.toString();
    autoRenew = json['auto_renew']?.toInt();
    neverExpired = json['never_expired']?.toString();
    activeStartDate = json['active_start_date']?.toString();
    activeDates = json['active_dates']?.toString();
    dmodelviewImages = json['dmodelview_images']?.toString();
    dmodel = json['dmodel']?.toString();
    virtualReality = json['virtual_reality']?.toString();
    if (json['image'] != null) {
      final v = json['image'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      image = arr0;
    }
    listimage = json['listimage']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['content'] = content;
    data['build_year'] = buildYear;
    data['parking'] = parking;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['images'] = images;
    data['video_type'] = videoType;
    data['video_link'] = videoLink;
    data['project_id'] = projectId;
    data['number_bedroom'] = numberBedroom;
    data['number_bathroom'] = numberBathroom;
    data['number_floor'] = numberFloor;
    data['square'] = square;
    data['lot_size'] = lotSize;
    data['price'] = price;
    data['price_unit'] = priceUnit;
    data['is_featured'] = isFeatured;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    data['description'] = description;
    data['monthly_mortage'] = monthlyMortage;
    data['local_legal_protections'] = localLegalProtections;
    data['property_taxes_and_assessments'] = propertyTaxesAndAssessments;
    data['price_history'] = priceHistory;
    data['public_records'] = publicRecords;
    data['pet'] = pet;
    data['currency_id'] = currencyId;
    data['city_id'] = cityId;
    data['period'] = period;
    data['view_type'] = viewType;
    data['author_id'] = authorId;
    data['author_type'] = authorType;
    data['category_id'] = categoryId;
    data['moderation_status'] = moderationStatus;
    data['expire_date'] = expireDate;
    data['auto_renew'] = autoRenew;
    data['never_expired'] = neverExpired;
    data['active_start_date'] = activeStartDate;
    data['active_dates'] = activeDates;
    data['dmodelview_images'] = dmodelviewImages;
    data['dmodel'] = dmodel;
    data['virtual_reality'] = virtualReality;
    if (image != null) {
      final v = image;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['image'] = arr0;
    }
    data['listimage'] = listimage;
    return data;
  }
}

class MeetingListModel {
/*
{
  "id": 63,
  "session_id": "2_MX40NjkxMDcwNH5-MTY1Nzk5NTc5MTM2Nn5OS2tCazMxVUZUNU52Y1UzU0d3SUQ5RGR-fg",
  "type": "1",
  "sender_token": null,
  "message_send_by": 55,
  "message_send_by_name": "Sara Ali",
  "message_send_by_email": "sara@sellthedwell.com",
  "message_send_by_phone": null,
  "property_id": 103,
  "receiver_token": null,
  "message_receive_by": 19,
  "message_receive_by_name": "res",
  "message_receive_by_email": "res@gmail.com1",
  "title": "52 BEVERLY ROAD Chicago, IL 60643",
  "message": "undefined",
  "meeting_date": "Mon, Nov 30, -0001 05:30am",
  "meeting_time": "undefined",
  "status": 0,
  "created_at": "2022-07-16 11:23:11",
  "created_date": "2022-07-16 11:23:11",
  "property_details": {
    "id": 103,
    "name": "52 BEVERLY ROAD Chicago, IL 60643",
    "content": "<p>About</p>",
    "build_year": "1970-01-01",
    "parking": null,
    "location": "1735 W 107th St, Chicago, IL 60643, USA",
    "latitude": "41.699009",
    "longitude": "-87.66576119999999",
    "images": "[\"ch4.jpg\",\"ch3.jpg\",\"ch2.jpg\",\"ch1.jpg\"]",
    "video_type": 1,
    "video_link": "",
    "project_id": 0,
    "number_bedroom": 4,
    "number_bathroom": 3,
    "number_floor": 0,
    "square": 4098,
    "lot_size": "212",
    "price": "245000",
    "price_unit": null,
    "is_featured": 1,
    "status": "selling",
    "created_at": "2020-11-01 04:44:01",
    "updated_at": "2022-06-14 00:13:21",
    "type": "0",
    "description": "Beverly-Morgan Park Victorian beauty",
    "monthly_mortage": "null",
    "local_legal_protections": "null",
    "property_taxes_and_assessments": "null",
    "price_history": "undefined",
    "public_records": "null",
    "pet": "DOG",
    "currency_id": null,
    "city_id": 0,
    "period": "month",
    "view_type": "Beach",
    "author_id": 19,
    "author_type": "Botble\\ACL\\Models\\User",
    "category_id": 13,
    "moderation_status": "approved",
    "expire_date": "2023-01-26",
    "auto_renew": 0,
    "never_expired": null,
    "active_start_date": "01-19-2023",
    "active_dates": "01-19-2023,01-21-2023,01-25-2023,01-24-2023,01-23-2023",
    "dmodelview_images": null,
    "dmodel": null,
    "virtual_reality": null,
    "image": [
      "ch4.jpg"
    ],
    "listimage": "ch4.jpg"
  },
  "meeting_state": "Expired"
} 
*/

  int? id;
  String? sessionId;
  String? type;
  String? senderToken;
  int? messageSendBy;
  String? messageSendByName;
  String? messageSendByEmail;
  String? messageSendByPhone;
  int? propertyId;
  String? receiverToken;
  int? messageReceiveBy;
  String? messageReceiveByName;
  String? messageReceiveByEmail;
  String? title;
  String? message;
  String? meetingDate;
  String? meetingTime;
  int? status;
  String? createdAt;
  String? createdDate;
  MeetingListModelPropertyDetails? propertyDetails;
  String? meetingState;
  String? button;

  MeetingListModel({
    this.id,
    this.sessionId,
    this.type,
    this.senderToken,
    this.messageSendBy,
    this.messageSendByName,
    this.messageSendByEmail,
    this.messageSendByPhone,
    this.propertyId,
    this.receiverToken,
    this.messageReceiveBy,
    this.messageReceiveByName,
    this.messageReceiveByEmail,
    this.title,
    this.message,
    this.meetingDate,
    this.meetingTime,
    this.status,
    this.createdAt,
    this.createdDate,
    this.propertyDetails,
    this.meetingState,
    this.button,
  });
  MeetingListModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    sessionId = json['session_id']?.toString();
    type = json['type']?.toString();
    senderToken = json['sender_token']?.toString();
    messageSendBy = json['message_send_by']?.toInt();
    messageSendByName = json['message_send_by_name']?.toString();
    messageSendByEmail = json['message_send_by_email']?.toString();
    messageSendByPhone = json['message_send_by_phone']?.toString();
    propertyId = json['property_id']?.toInt();
    receiverToken = json['receiver_token']?.toString();
    messageReceiveBy = json['message_receive_by']?.toInt();
    messageReceiveByName = json['message_receive_by_name']?.toString();
    messageReceiveByEmail = json['message_receive_by_email']?.toString();
    title = json['title']?.toString();
    message = json['message']?.toString();
    meetingDate = json['meeting_date']?.toString();
    meetingTime = json['meeting_time']?.toString();
    status = json['status']?.toInt();
    createdAt = json['created_at']?.toString();
    createdDate = json['created_date']?.toString();
    button = json['button']?.toString();
    propertyDetails = (json['property_details'] != null &&
            (json['property_details'] is! List))
        ? MeetingListModelPropertyDetails.fromJson(json['property_details'])
        : null;
    meetingState = json['meeting_state']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['session_id'] = sessionId;
    data['type'] = type;
    data['sender_token'] = senderToken;
    data['message_send_by'] = messageSendBy;
    data['message_send_by_name'] = messageSendByName;
    data['message_send_by_email'] = messageSendByEmail;
    data['message_send_by_phone'] = messageSendByPhone;
    data['property_id'] = propertyId;
    data['receiver_token'] = receiverToken;
    data['message_receive_by'] = messageReceiveBy;
    data['message_receive_by_name'] = messageReceiveByName;
    data['message_receive_by_email'] = messageReceiveByEmail;
    data['title'] = title;
    data['message'] = message;
    data['meeting_date'] = meetingDate;
    data['meeting_time'] = meetingTime;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['created_date'] = createdDate;
    if (propertyDetails != null) {
      data['property_details'] = propertyDetails!.toJson();
    }
    data['meeting_state'] = meetingState;
    data['button'] = button;
     return data;
  }
}
