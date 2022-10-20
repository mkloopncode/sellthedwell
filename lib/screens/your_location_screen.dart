import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_place/google_place.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/custom_text_button.dart';
import 'package:sellthedwell/widgets/custom_textfield.dart';

class YourLocationScreen extends StatefulWidget {
  const YourLocationScreen({Key? key}) : super(key: key);

  @override
  State<YourLocationScreen> createState() => _YourLocationScreenState();
}

class _YourLocationScreenState extends State<YourLocationScreen> {
  List<SearchResult>? suggestions = [];
  final TextEditingController _searchController = TextEditingController();
  late GooglePlace googlePlace;
  bool loading = false;

  @override
  void initState() {
    googlePlace = GooglePlace(
      Konstants.mapAPIKey,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(context: context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.yourLocation,
                style: TextStyles.bigTitle,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextButton(
                onTap: () {
                  _handleCurrentLocation(context);
                },
                text: Strings.userCurrentLocation,
                icon: Icons.near_me,
                color: ColorUtils.primary,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFieldWidget(
                controller: _searchController,
                hintText: Strings.locationhint,
                labelText: Strings.location,
                isRequired: false,
                prefixIcon: Icons.search,
                onChanged: (newVal) {
                  _handleSearchLocation(context, newVal);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                Strings.locationnote,
                style: TextStyles.body1.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Visibility(
                visible: loading,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressWidget(),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  return ListTile(
                    title: Text(suggestions?[i].name ?? ""),
                    leading: const Icon(
                      Icons.near_me,
                      color: Colors.grey,
                    ),
                    subtitle: Text(suggestions?[i].formattedAddress ?? ""),
                    onTap: () async {
                      final auth =
                          Provider.of<AuthProvider>(context, listen: false);
                      await auth.saveLatLng(
                        lat: suggestions?[i].geometry?.location?.lat,
                        lng: suggestions?[i].geometry?.location?.lng,
                      );
                      await auth.saveLocation(
                          location: suggestions?[i].name ?? "");

                      CommonMethods.removeAllRoutesAndPushNamed(
                          routeName: Routes.main, context: context);
                    },
                  );
                },
                itemCount: suggestions?.length,
                physics: const ClampingScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  autoCompleteSearch(String value) async {
    var result = await googlePlace.search.getTextSearch(value);
    if (result != null && result.results != null && mounted) {
      setState(() {
        suggestions = result.results;
      });
    }
  }

  _handleCurrentLocation(BuildContext context) async {
    CommonMethods.showLoading(context);
    try {
      final result = await CommonMethods.determinePosition();
      log("Location got: ${result.latitude}-${result.longitude}");
      if (mounted) CommonMethods.dismissLoading(context);
      if (mounted) {
        CommonMethods.removeAllRoutesAndPushNamed(
            routeName: Routes.main, context: context);
      }
    } catch (e) {
      CommonMethods.showAlertWithOkButton(
          context: context, message: e.toString());
    }
  }

  void _handleSearchLocation(BuildContext context, String newVal) async {
    if (newVal.length < 3) {
      return toast("Minimum 3 characters");
    }
    setState(() {
      loading = true;
    });
    // CommonMethods.showLoading(context);
    await autoCompleteSearch(newVal);
    // if (mounted) CommonMethods.dismissLoading(context);
    setState(() {
      loading = false;
    });
  }
}
