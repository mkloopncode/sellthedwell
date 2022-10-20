import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sellthedwell/models/aminities_model.dart';
import 'package:sellthedwell/models/feature_model.dart';

List<String> propCategories = ["Residential", "Rentals", "Commercial"];

List<String> propType = [
  "Single Family",
  "Multi family",
  "townhouse",
  "Sale",
  "Lease",
  "Condo",
  "Lot/ Land",
];

List<Features> features = [];
List<Aminities> aminities = [];
List<String> selectedFeature = [];
List<String> selectedAminities = [];

/*
List<String> features = [
  "Washer/dryer",
  "Walk in Closet",
  "Mother-n-law suite",
  "Fireplace",
  "Granite / Custom",
  "Penthouse/Roof top",
  "Fenced in property",
  "Stainless Steel appliances",
  "Deck/ balcony",
  "Solar",
  "Vaulted ceilings",
  "Penthouse/ roof top",
  "Fenced in property",
];

List<String> aminities = [
  "Flexible Pet Policy",
  "Pool",
  "Fitness center",
  "Jacuzzi/Spa",
  "Security Onsite",
  "Covered parking",
  "On site parking",
  "Storage space",
  "Internet/cable",
  "Utilities",
  "Conference facilities",
  "Concierge services",
  "Playground",
  "Designated outdoor",
  "Furnished",
];
*/

List<String> noOfBed = ["1", "2", "3", "4", "5"];
List<String> noOfBath = ["1", "2", "3", "4", "5"];

enum TourRequest {
  SEND,
  RECIEVE,
}

String getStringFromDateinMMDDYYYY(DateTime time) {
  var f = DateFormat('MM-dd-yyyy');
  return f.format(time);
}

String getStringFromDateinYYYYMMDD(DateTime time) {
  var f = DateFormat('yyyy-MM-dd');
  return f.format(time);
}

String getStringFromDateinDDMMYYYY(DateTime time) {
  var f = DateFormat('dd-MM-yyyy');
  return f.format(time);
}

String getStringFromTimeinHHMM(TimeOfDay time) {
  return "${time.hour}:${time.minute}";
}

DateTime getDateFromStringInMMDDYYYY(String date) {
  var f = DateFormat('MM-dd-yyyy');
  return f.parse(date);
}

DateTime getDateFromStringInYYYYMMDD(String date) {
  var f = DateFormat('yyyy-MM-dd');
  return f.parse(date);
}

DateTime getDateFromStringInDDMMYYYY(String date) {
  var f = DateFormat('dd-MM-yyyy');
  return f.parse(date);
}
