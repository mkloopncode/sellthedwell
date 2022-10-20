import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/models/aminities_model.dart';
import 'package:sellthedwell/models/feature_model.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/enums.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_outlined_button.dart';
import 'package:sellthedwell/widgets/custom_text_button.dart';
import 'package:sellthedwell/widgets/custom_textfield.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

class CommonMethods {
  // Drawer menu callbacks list
  static List<Function> getCallbacksList(BuildContext context) {
    return [
      () {
        log("Clicked 1 nd time");
        // Navigator.of(context).pop();
        // final auth = Provider.of<AuthProvider>(context, listen: false);
        // auth.setIndex(2);
      },
      () {
        log("Clicked 2 nd time");
        // Navigator.of(context).pop();
        // final auth = Provider.of<AuthProvider>(context, listen: false);
        // auth.setIndex(1);
      },
      //navigate to login screen after logout
      () {
        // Provider.of<AuthProvider>(context, listen: false).logout();
        // Navigator.of(context).pop();

        // Navigator.of(context, rootNavigator: true)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    ];
  }

  static void showToast(String text) {
    showSimpleNotification(
      Text(text),
      background: Colors.black.withOpacity(0.8),
      trailing: const Icon(Icons.info_outline, color: Colors.white),
      autoDismiss: true,
      position: NotificationPosition.top,
    );
  }

  static void GetImageVr() {
    List<String> imageList = [];
  }

  static void showFileSavedToast(String text, String path) {
    showSimpleNotification(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          InkWell(
            onTap: () async {
              OpenFile.open(path);
            },
            child: const Text(
              "Open PDF",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
      background: Colors.black.withOpacity(0.8),
      trailing: const Icon(Icons.info_outline, color: Colors.white),
      autoDismiss: true,
      position: NotificationPosition.top,
      duration: const Duration(seconds: 5),
    );
  }

  static showAlertWithOkButton(
      {required BuildContext context,
      String title = "Alert",
      required String message,
      String buttonText = "OK",
      Function? function}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyles.heading2,
          ),
          content: Text(
            message,
            style: TextStyles.body1,
          ),
          actions: <Widget>[
            CustomFillButton(
              onTapFunction: (function == null)
                  ? () => Navigator.of(context).pop()
                  : function,
              childText: buttonText,
            ),
          ],
        );
      },
    );
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void showLoading(BuildContext context,
      {String message = "Loading..."}) {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressWidget(loadingText: message),
            // const SizedBox(width: 24),
            // Text(
            //   message,
            //   style: TextStyles.loadingStyle,
            // ),
          ],
        ),
      ),
    );
  }

  static dismissLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: false).pop();
  }

  static formatDateFromMillis(int checkInTime) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(checkInTime);
    return DateFormat("dd MMM yyyy hh:mm a").format(dateTime);
  }

  static Future<bool> checkLocationPermission(BuildContext context) async {
    // check if location permission is granted or not
    final status = await Permission.location.serviceStatus;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      return false;
    } else {
      return true;
    }
  }

  static requestLocationPermission(BuildContext context) async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.denied) {
      await showAlertWithOkButton(
          context: context, message: Strings.locationPermissionNeeded);
      await requestLocationPermission(context);
    } else {
      return;
    }
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If not, show dialog to enable location services.
      final bool result = await Geolocator.openLocationSettings();
      if (!result) {
        throw Exception(Strings.locationNotEnabled);
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception(Strings.locationPermissionNeeded);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw Exception(Strings.locationDeniedForever);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  // Get location information from coordinates
  static Future<String> getLocationBasedOnCoordinates(Position position) async {
    try {
      final List<Placemark> list =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (list.isEmpty) {
        return "Hyderabad";
      }
      return list[0].locality ?? "Hyderabad";
    } catch (e) {
      return "Hyderabad";
    }
  }

  // Confirmation dialog
  static showConfirmationDialog(
      {required BuildContext context,
      required String message,
      String? title}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? Strings.confirmation,
            style: TextStyles.heading2,
          ),
          content: Text(
            message,
            style: TextStyles.body1,
          ),
          actions: <Widget>[
            CustomFillButton(
              onTapFunction: () => Navigator.of(context).pop(false),
              childText: Strings.cancel,
              inverted: true,
            ),
            CustomFillButton(
              onTapFunction: () => Navigator.of(context).pop(true),
              childText: Strings.ok,
            ),
          ],
        );
      },
    );
  }

  static Future<String> showListDialogSingleSelect({
    required BuildContext context,
    required String title,
    required List<String> list,
    required String selectedValue,
  }) async {
    List<String> _states = [];
    _states.addAll(list);
    final String result = await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (_, localSetState) {
          return AlertDialog(
              title: Text(
                title,
                style: TextStyles.heading2,
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _states.isEmpty
                          ? SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  "No data ",
                                  style: TextStyles.body1,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _states.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(_states[index]),
                                  onTap: () {
                                    log("Selected state: ${_states[index]}");
                                    Navigator.of(context).pop(_states[index]);
                                  },
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ));
        });
      },
    );
    return result;
  }

  static Future<String> showListDialogMultiSelect({
    required BuildContext context,
    required String title,
    required List<String> list,
    required List<String> selectedValues,
  }) async {
    List<String> _states = [];
    _states.addAll(list);
    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (_, localSetState) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyles.heading2,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    h16,
                    _states.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                "No data ",
                                style: TextStyles.body1,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _states.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: selectedValues.contains(_states[index]),
                                title: Text(_states[index]),
                                onChanged: (v) {
                                  if (v ?? false) {
                                    selectedValues.add(_states[index]);
                                  } else {
                                    selectedValues.remove(_states[index]);
                                  }
                                  localSetState(() {});
                                },
                              );
                            },
                          ),
                    h16,
                  ],
                ),
              ),
            ),
            actions: [
              CustomTextButton(
                  text: Strings.cancel,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              CustomTextButton(
                  text: Strings.ok,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
      },
    );
    return selectedValues.join(",");
  }


  static Future<String> showListFeatureMultiSelect({
    required BuildContext context,
    required String title,
    required List<Features> list,
    required List<String> selectedValues,
  }) async {
    List<Features> _states = [];
    _states.addAll(list);
    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (_, localSetState) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyles.heading2,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    h16,
                    _states.isEmpty
                        ? SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          "No data ",
                          style: TextStyles.body1,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: _states.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          controlAffinity:
                          ListTileControlAffinity.leading,
                          value: selectedValues.contains(_states[index].name),
                          title: Text(_states[index].name.toString()),
                          onChanged: (v) {
                            if (v ?? false) {
                              selectedValues.add(_states[index].name.toString());
                              selectedFeature.add(_states[index].id.toString());
                            } else {
                              selectedValues.remove(_states[index].name.toString());
                              selectedFeature.remove(_states[index].id.toString());
                            }
                            localSetState(() {});
                          },
                        );
                      },
                    ),
                    h16,
                  ],
                ),
              ),
            ),
            actions: [
              CustomTextButton(
                  text: Strings.cancel,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              CustomTextButton(
                  text: Strings.ok,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
      },
    );
    return selectedValues.join(",");
  }

  static Future<String> showListAminitiesMultiSelect({
    required BuildContext context,
    required String title,
    required List<Aminities> list,
    required List<String> selectedValues,
  }) async {
    List<Aminities> _states = [];
    _states.addAll(list);
    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (_, localSetState) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyles.heading2,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    h16,
                    _states.isEmpty
                        ? SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          "No data ",
                          style: TextStyles.body1,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: _states.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          controlAffinity:
                          ListTileControlAffinity.leading,
                          value: selectedValues.contains(_states[index].name),
                          title: Text(_states[index].name.toString()),

                          onChanged: (v) {
                            if (v ?? false) {
                              selectedValues.add(_states[index].name.toString());
                              selectedAminities.add(_states[index].id.toString());
                            } else {
                              selectedValues.remove(_states[index].name.toString());
                              selectedAminities.remove(_states[index].id.toString());
                            }
                            localSetState(() {});
                          },
                        );
                      },
                    ),
                    h16,
                  ],
                ),
              ),
            ),
            actions: [
              CustomTextButton(
                  text: Strings.cancel,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              CustomTextButton(
                  text: Strings.ok,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
      },
    );
    return selectedValues.join(",");
  }

  static getDateInDDMMYYYYFormat(DateTime date) {
    return "${date.day}.${date.month}.${date.year}";
  }

  static getDateInYYYYMMDDFormat(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  static openMap(BuildContext context,
      {String? latitude = "15", String? longitude = "80"}) {
    final String url =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    log("Opening map : $url");
    launch(url);
  }

  static void removeAllRoutesAndPushNamed(
      {required String routeName, required BuildContext context, arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  static Future<void> toggleFavourite(context, PropertyModel prop) async {
    try {
      CommonMethods.showLoading(
        context,
      );
      await NetworkService.makeFavourite(
        propId: "${prop.id}",
        status: "${prop.favorite == 1 ? 0 : 1}",
      );
      log("Clicked favorite");
      CommonMethods.dismissLoading(context);
    } catch (e) {
      CommonMethods.dismissLoading(context);
      toast(e.toString());
    }
  }

  static share({
    required String title,
    String? description,
  }) async {
    await Share.share(
        "Hey, Checkout this property on 'www.sellthedwell.com'\n\n$title\n\n$description",
        subject: "Share property");
  }

  static Future<void> deleteProperty(
      BuildContext context, PropertyModel prop) async {
    try {
      final result = await showConfirmationDialog(
          context: context, message: Strings.confirmDeleteProperty);
      if (result) {
        await NetworkService.deleteProperty(prop);
        toast("Deletion Success");
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  static handleEditClick(BuildContext context, PropertyModel prop) async {
    await Navigator.of(context).pushNamed(Routes.addListing, arguments: prop);
  }

  static List<PropertyModel> getFilteredResults(
    List<PropertyModel> props,
    Map<String, String> filters,
  ) {
    final List<PropertyModel> list = [];

    // Handling sort type
    String sort = filters[Konstants.fSort] ?? Strings.listinghighlow;
    if (sort == Strings.listinghighlow) {
      props.sort((a, b) {
        return double.parse(a.price.toString()) <
                double.parse(b.price.toString())
            ? 1
            : 0;
      });
    } else if (sort == Strings.listinglowhigh) {
      props.sort((a, b) {
        return double.parse(a.price.toString()) >
                double.parse(b.price.toString())
            ? 1
            : 0;
      });
    } else if (sort == Strings.squarefeet) {
      props.sort((a, b) {
        return double.parse(a.square.toString()) <
                double.parse(b.square.toString())
            ? 1
            : 0;
      });
    } else if (sort == Strings.lotsize) {
      props.sort((a, b) {
        return double.parse(a.lotSize.toString()) >
                double.parse(b.lotSize.toString())
            ? 1
            : 0;
      });
    }

    String cat = filters[Konstants.fPropCategory] ?? "";
    if (cat.isNotEmpty) {
      if (cat == Konstants.listTypeResidential) {
        for (var element in props) {
          if (element.categoryName == Konstants.listTypeResidential) {
            list.add(element);
          }
        }
      } else if (cat == Konstants.listTypeCommercial) {
        for (var element in props) {
          if (element.categoryName == Konstants.listTypeCommercial) {
            list.add(element);
          }
        }
      } else if (cat == Konstants.listTypeRentals) {
        for (var element in props) {
          if (element.categoryName == Konstants.listTypeRentals) {
            list.add(element);
          }
        }
      }
    } else {
      list.addAll(props);
    }

    // Handling beds and bath
    String bed = ((filters[Konstants.fBed] == Strings.any)
            ? "0"
            : filters[Konstants.fBed]) ??
        "";
    final int bedcount = int.parse(bed);
    if (bedcount != 0) {
      list.retainWhere((element) => (element.numberBedroom ?? 0) >= bedcount);
    }

    String bath = ((filters[Konstants.fBath] == Strings.any)
            ? "0"
            : filters[Konstants.fBath]) ??
        "";
    final int bathcount = int.parse(bath);
    if (bathcount != 0) {
      list.retainWhere((element) => (element.numberBathroom ?? 0) >= bathcount);
    }

    // Handling price range
    double min = double.parse(filters[Konstants.fMinPrice] ?? "0");
    double max = double.parse(filters[Konstants.fMaxPrice] ?? "10000000");
    list.retainWhere((element) {
      final double price = double.parse(element.price ?? "100");
      return price >= min && price <= max;
    });

    return list;
  }
}
