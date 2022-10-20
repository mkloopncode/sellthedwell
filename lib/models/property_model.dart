// class PropertyModel {
// /*
// {
//   "id": 86,
//   "name": "1526 W Harle Pl, Anaheim, CA 92802",
//   "content": "<p>This is the home you have been searching for! Here is a beautiful home that is on a well cared for cul-de-sac street. This prime location is just a short walk to highly desired Downtown Disney in Anaheim. Single story, 4 bedrooms, family kitchen, large living room with fireplace and sliding glass door overlooking backyard. The patio is excellent for entertaining with a separate lawn area making it a terrific backyard.</p>",
//   "build_year": "1966-06-08",
//   "parking": null,
//   "location": "1526 W Harle Pl, Anaheim, CA 92802",
//   "latitude": "40.6781784",
//   "longitude": "-73.9441579",
//   "images": "[\"properties\\/4-19.jpg\",\"properties\\/3-21.jpg\",\"properties\\/2-21.jpg\",\"properties\\/1-21.jpg\"]",
//   "video_type": 1,
//   "video_link": "",
//   "project_id": 0,
//   "number_bedroom": 4,
//   "number_bathroom": 2,
//   "number_floor": 3,
//   "square": 500000,
//   "lot_size": "2,200 sqft",
//   "price": "2000000",
//   "price_unit": null,
//   "is_featured": 0,
//   "status": "selling",
//   "created_at": "2020-10-20 07:17:33",
//   "updated_at": "2021-03-30 22:57:32",
//   "type": "Home",
//   "description": "This is the home you have been searching for!",
//   "monthly_mortage": "Property two",
//   "local_legal_protections": "Property two",
//   "property_taxes_and_assessments": "Property two",
//   "price_history": "Property two",
//   "public_records": "Property two",
//   "pet": "Any",
//   "currency_id": null,
//   "city_id": 4,
//   "period": "month",
//   "view_type": null,
//   "author_id": 57,
//   "author_type": "Botble\\ACL\\Models\\User",
//   "category_id": 13,
//   "moderation_status": "approved",
//   "expire_date": "2021-04-07",
//   "auto_renew": 0,
//   "never_expired": null,
//   "active_start_date": "08-02-2021",
//   "active_dates": [
//     "03-31-2021"
//   ],
//   "dmodelview_images": null,
//   "dmodel": null,
//   "virtual_reality": null,
//   "favorite": 1,
//   "image": [
//     "properties/4-19.jpg"
//   ],
//   "listimage": "properties/4-19.jpg",
//   "property_status": "Scheduled"
// }
// */

//   int? id;
//   String? name;
//   String? content;
//   String? buildYear;
//   String? parking;
//   String? location;
//   String? latitude;
//   String? longitude;
//   String? images;
//   int? videoType;
//   String? videoLink;
//   int? projectId;
//   int? numberBedroom;
//   int? numberBathroom;
//   int? numberFloor;
//   int? square;
//   String? lotSize;
//   String? price;
//   String? priceUnit;
//   int? isFeatured;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   String? type;
//   String? description;
//   String? monthlyMortage;
//   String? localLegalProtections;
//   String? propertyTaxesAndAssessments;
//   String? priceHistory;
//   String? publicRecords;
//   String? pet;
//   String? currencyId;
//   int? cityId;
//   String? period;
//   String? viewType;
//   int? authorId;
//   String? authorType;
//   int? categoryId;
//   String? moderationStatus;
//   String? expireDate;
//   int? autoRenew;
//   String? neverExpired;
//   String? activeStartDate;
//   List<String?>? activeDates;
//   String? dmodelviewImages;
//   String? dmodel;
//   String? virtualReality;
//   int? favorite;
//   List<String?>? image;
//   String? listimage;
//   String? propertyStatus;

//   PropertyModel({
//     this.id,
//     this.name,
//     this.content,
//     this.buildYear,
//     this.parking,
//     this.location,
//     this.latitude,
//     this.longitude,
//     this.images,
//     this.videoType,
//     this.videoLink,
//     this.projectId,
//     this.numberBedroom,
//     this.numberBathroom,
//     this.numberFloor,
//     this.square,
//     this.lotSize,
//     this.price,
//     this.priceUnit,
//     this.isFeatured,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.type,
//     this.description,
//     this.monthlyMortage,
//     this.localLegalProtections,
//     this.propertyTaxesAndAssessments,
//     this.priceHistory,
//     this.publicRecords,
//     this.pet,
//     this.currencyId,
//     this.cityId,
//     this.period,
//     this.viewType,
//     this.authorId,
//     this.authorType,
//     this.categoryId,
//     this.moderationStatus,
//     this.expireDate,
//     this.autoRenew,
//     this.neverExpired,
//     this.activeStartDate,
//     this.activeDates,
//     this.dmodelviewImages,
//     this.dmodel,
//     this.virtualReality,
//     this.favorite,
//     this.image,
//     this.listimage,
//     this.propertyStatus,
//   });
//   PropertyModel.fromJson(Map<String, dynamic> json) {
//     id = json['id']?.toInt();
//     name = json['name']?.toString();
//     content = json['content']?.toString();
//     buildYear = json['build_year']?.toString();
//     parking = json['parking']?.toString();
//     location = json['location']?.toString();
//     latitude = json['latitude']?.toString();
//     longitude = json['longitude']?.toString();
//     images = json['images']?.toString();
//     videoType = json['video_type']?.toInt();
//     videoLink = json['video_link']?.toString();
//     projectId = json['project_id']?.toInt();
//     numberBedroom = json['number_bedroom']?.toInt();
//     numberBathroom = json['number_bathroom']?.toInt();
//     numberFloor = json['number_floor']?.toInt();
//     square = json['square']?.toInt();
//     lotSize = json['lot_size']?.toString();
//     price = json['price']?.toString();
//     priceUnit = json['price_unit']?.toString();
//     isFeatured = json['is_featured']?.toInt();
//     status = json['status']?.toString();
//     createdAt = json['created_at']?.toString();
//     updatedAt = json['updated_at']?.toString();
//     type = json['type']?.toString();
//     description = json['description']?.toString();
//     monthlyMortage = json['monthly_mortage']?.toString();
//     localLegalProtections = json['local_legal_protections']?.toString();
//     propertyTaxesAndAssessments =
//         json['property_taxes_and_assessments']?.toString();
//     priceHistory = json['price_history']?.toString();
//     publicRecords = json['public_records']?.toString();
//     pet = json['pet']?.toString();
//     currencyId = json['currency_id']?.toString();
//     cityId = json['city_id']?.toInt();
//     period = json['period']?.toString();
//     viewType = json['view_type']?.toString();
//     authorId = json['author_id']?.toInt();
//     authorType = json['author_type']?.toString();
//     categoryId = json['category_id']?.toInt();
//     moderationStatus = json['moderation_status']?.toString();
//     expireDate = json['expire_date']?.toString();
//     autoRenew = json['auto_renew']?.toInt();
//     neverExpired = json['never_expired']?.toString();
//     activeStartDate = json['active_start_date']?.toString();
//     if (json['active_dates'] != null) {
//       final v = json['active_dates'];
//       final arr0 = <String>[];
//       v.forEach((v) {
//         arr0.add(v.toString());
//       });
//       activeDates = arr0;
//     }
//     dmodelviewImages = json['dmodelview_images']?.toString();
//     dmodel = json['dmodel']?.toString();
//     virtualReality = json['virtual_reality']?.toString();
//     favorite = json['favorite']?.toInt();
//     if (json['image'] != null) {
//       final v = json['image'];
//       final arr0 = <String>[];
//       v.forEach((v) {
//         arr0.add(v.toString());
//       });
//       image = arr0;
//     }
//     listimage = json['listimage']?.toString();
//     propertyStatus = json['property_status']?.toString();
//   }
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['content'] = content;
//     data['build_year'] = buildYear;
//     data['parking'] = parking;
//     data['location'] = location;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['images'] = images;
//     data['video_type'] = videoType;
//     data['video_link'] = videoLink;
//     data['project_id'] = projectId;
//     data['number_bedroom'] = numberBedroom;
//     data['number_bathroom'] = numberBathroom;
//     data['number_floor'] = numberFloor;
//     data['square'] = square;
//     data['lot_size'] = lotSize;
//     data['price'] = price;
//     data['price_unit'] = priceUnit;
//     data['is_featured'] = isFeatured;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['type'] = type;
//     data['description'] = description;
//     data['monthly_mortage'] = monthlyMortage;
//     data['local_legal_protections'] = localLegalProtections;
//     data['property_taxes_and_assessments'] = propertyTaxesAndAssessments;
//     data['price_history'] = priceHistory;
//     data['public_records'] = publicRecords;
//     data['pet'] = pet;
//     data['currency_id'] = currencyId;
//     data['city_id'] = cityId;
//     data['period'] = period;
//     data['view_type'] = viewType;
//     data['author_id'] = authorId;
//     data['author_type'] = authorType;
//     data['category_id'] = categoryId;
//     data['moderation_status'] = moderationStatus;
//     data['expire_date'] = expireDate;
//     data['auto_renew'] = autoRenew;
//     data['never_expired'] = neverExpired;
//     data['active_start_date'] = activeStartDate;
//     if (activeDates != null) {
//       final v = activeDates;
//       final arr0 = [];
//       v!.forEach((v) {
//         arr0.add(v);
//       });
//       data['active_dates'] = arr0;
//     }
//     data['dmodelview_images'] = dmodelviewImages;
//     data['dmodel'] = dmodel;
//     data['virtual_reality'] = virtualReality;
//     data['favorite'] = favorite;
//     if (image != null) {
//       final v = image;
//       final arr0 = [];
//       v!.forEach((v) {
//         arr0.add(v);
//       });
//       data['image'] = arr0;
//     }
//     data['listimage'] = listimage;
//     data['property_status'] = propertyStatus;
//     return data;
//   }
// }

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class PropertyModelPropertyFeatures {
/*
{
  "property_id": 72,
  "feature_id": 1,
  "feature_name": "Washer/Dryer"
} 
*/

  int? propertyId;
  int? featureId;
  String? featureName;

  PropertyModelPropertyFeatures({
    this.propertyId,
    this.featureId,
    this.featureName,
  });
  PropertyModelPropertyFeatures.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id']?.toInt();
    featureId = json['feature_id']?.toInt();
    featureName = json['feature_name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['property_id'] = propertyId;
    data['feature_id'] = featureId;
    data['feature_name'] = featureName;
    return data;
  }
}

class PropertyModelPropertyAminities {
/*
{
  "property_id": 72,
  "aminities_id": 1,
  "aminity_name": "Flexible Pet Policy"
} 
*/

  int? propertyId;
  int? aminitiesId;
  String? aminityName;

  PropertyModelPropertyAminities({
    this.propertyId,
    this.aminitiesId,
    this.aminityName,
  });
  PropertyModelPropertyAminities.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id']?.toInt();
    aminitiesId = json['aminities_id']?.toInt();
    aminityName = json['aminity_name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['property_id'] = propertyId;
    data['aminities_id'] = aminitiesId;
    data['aminity_name'] = aminityName;
    return data;
  }
}

class PropertyModel {
/*
{
  "id": 72,
  "name": "1101 JUNIPER STREET, San Francisco, CA 94110",
  "content": "<p>If turnkey, move-in-ready and fully-renovated sound nice to you...this is your next home! Park Central at it&#39;s very best. Beautiful updated kitchen with quartz countertops and new cabinets; bright and spacious bath; new porcelain (imported) tile; large bedroom with gorgeous new carpet; contemporary lighting upgrades; custom roller shades throughout. Every detail was addressed in this magnificent one-bedroom home. Don&#39;t miss the indoor lap pool, sunny outdoor pool, well-equipped gym, and yes, there is extra storage on the terrace level for this unit. A great spot for those bulky household items and seasonal accoutrements.One block to Piedmont Park. One block to Colony Square with all its new restaurants, movie theater, shops and yoga studio. A short walk to the best Whole Foods in the city. Easy access to MARTA. Park Central is where you want to be.</p>",
  "build_year": "2002-06-07",
  "parking": null,
  "location": "819 Hampshire St, San Francisco, CA 94110, USA",
  "latitude": "37.758899",
  "longitude": "-122.40759",
  "images": "[\"rn4.jpg\",\"rn3.jpg\",\"rn2.jpg\",\"rn1.jpg\"]",
  "video_type": 1,
  "video_link": "",
  "project_id": 0,
  "number_bedroom": 1,
  "number_bathroom": 1,
  "number_floor": 2,
  "square": 764,
  "lot_size": "764 sqft",
  "price": "270000",
  "price_unit": null,
  "is_featured": 1,
  "status": "selling",
  "created_at": "2020-09-12 04:18:21",
  "updated_at": "2021-08-18 04:31:34",
  "type": "4",
  "description": "Completely Remodeled Full Floor 3-bed 2-bath Inner Mission Flat",
  "monthly_mortage": "monthly",
  "local_legal_protections": "legal",
  "property_taxes_and_assessments": "assesment",
  "price_history": "price",
  "public_records": "records",
  "pet": "Any",
  "currency_id": null,
  "city_id": 5,
  "period": "month",
  "view_type": "Houseing",
  "author_id": 37,
  "author_type": "Botble\\ACL\\Models\\User",
  "category_id": 15,
  "moderation_status": "approved",
  "expire_date": "2021-10-28",
  "auto_renew": 0,
  "never_expired": null,
  "active_start_date": "10-21-2021",
  "active_dates": [
    "10-26-2021"
  ],
  "dmodelview_images": null,
  "dmodel": null,
  "virtual_reality": null,
  "category_name": "Rentals",
  "city_name": "San Francisco",
  "favorite": 1,
  "property_aminities": [
    {
      "property_id": 72,
      "aminities_id": 1,
      "aminity_name": "Flexible Pet Policy"
    }
  ],
  "property_features": [
    {
      "property_id": 72,
      "feature_id": 1,
      "feature_name": "Washer/Dryer"
    }
  ],
  "image": [
    "rn4.jpg"
  ],
  "listimage": "rn4.jpg"
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
  List<String?>? activeDates;
  String? dmodelviewImages;
  String? dmodel;
  String? panorama_image;
  String? virtualReality;
  String? categoryName;
  String? cityName;
  int? favorite;
  String? webView;
  List<PropertyModelPropertyAminities?>? propertyAminities;
  List<PropertyModelPropertyFeatures?>? propertyFeatures;
  List<String>? image;
  String? video_vr;
  List<String>? images_vr;
  String? listimage;
  String? modal_assets;

  PropertyModel({
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
    this.categoryName,
    this.cityName,
    this.favorite,
    this.webView,
    this.propertyAminities,
    this.propertyFeatures,
    this.image,
    this.video_vr,
    this.images_vr,
    this.listimage,
    this.modal_assets,
    this.panorama_image,
  });
  PropertyModel.fromJson(Map<String, dynamic> json) {
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
    video_vr = json['video_vr']?.toString();
    modal_assets = json["modal_assets"]?.toString();
    panorama_image = json["panorama_image"]?.toString();
/*    if (json['active_dates'] != null) {
      final v = json['active_dates'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      activeDates = arr0;
    }*/
    dmodelviewImages = json['dmodelview_images']?.toString();
    dmodel = json['dmodel']?.toString();
    virtualReality = json['virtual_reality']?.toString();
    categoryName = json['category_name']?.toString();
    cityName = json['city_name']?.toString();
    favorite = json['favorite']?.toInt();
    webView = json['web_view']?.toString();
    if (json['property_aminities'] != null) {
      final v = json['property_aminities'];
      final arr0 = <PropertyModelPropertyAminities>[];
      v.forEach((v) {
        arr0.add(PropertyModelPropertyAminities.fromJson(v));
      });
      propertyAminities = arr0;
    }
    if (json['property_features'] != null) {
      final v = json['property_features'];
      final arr0 = <PropertyModelPropertyFeatures>[];
      v.forEach((v) {
        arr0.add(PropertyModelPropertyFeatures.fromJson(v));
      });
      propertyFeatures = arr0;
    }
    if (json['image'] != null && json['image'].isNotEmpty) {
      final v = json['image'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      image = arr0;
    }
    if (json['images_vr'] != null && json['images_vr'].isNotEmpty) {
      final v = json['images_vr'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      images_vr = arr0;
    }

    if (json['images_vr'] != null && json['images_vr'].isNotEmpty) {
      final v = json['images_vr'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      images_vr = arr0;
    }

    listimage = (json['listimage'] ?? image?[0]).toString();
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
    data['video_vr'] = video_vr;
    data['modal_assets'] = modal_assets;
    data["panorama_image"] = panorama_image;
    data["web_view"] = webView;
    if (activeDates != null) {
      final v = activeDates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['active_dates'] = arr0;
    }
    data['dmodelview_images'] = dmodelviewImages;
    data['dmodel'] = dmodel;
    data['virtual_reality'] = virtualReality;
    data['category_name'] = categoryName;
    data['city_name'] = cityName;
    data['favorite'] = favorite;
    if (propertyAminities != null) {
      final v = propertyAminities;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['property_aminities'] = arr0;
    }
    if (propertyFeatures != null) {
      final v = propertyFeatures;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['property_features'] = arr0;
    }
    if (propertyFeatures != null) {
      final v = propertyFeatures;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['property_features'] = arr0;
    }

    if (image != null) {
      final v = image;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['image'] = arr0;
    }
    if (images_vr != null) {
      final v = images_vr;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['images_vr'] = arr0;
    }
    data['listimage'] = listimage;
    return data;
  }
}
