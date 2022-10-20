import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_text_button.dart';

class WelcomeLocationScreen extends StatefulWidget {
  const WelcomeLocationScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeLocationScreen> createState() => _WelcomeLocationScreenState();
}

class _WelcomeLocationScreenState extends State<WelcomeLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtils.black,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: ColorUtils.primaryDark,
                size: 72,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Strings.hiniceto,
                style: TextStyles.heading1.copyWith(
                  color: ColorUtils.white,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Strings.seyourlocation,
                style: TextStyles.heading3.copyWith(
                  color: ColorUtils.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomFillButton(
                      icon: Icons.bolt_rounded,
                      onTapFunction: () {
                        _handleUseCurrentLocation(context);
                      },
                      childText: Strings.userCurrentLocation,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                Strings.weonlyaccess,
                style: TextStyles.body2.copyWith(color: ColorUtils.white),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextButton(
                onTap: () {
                  _handleLocationManual(context);
                },
                text: Strings.orSetLocation,
                color: ColorUtils.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleUseCurrentLocation(BuildContext context) async {
    CommonMethods.showLoading(context);
    try {
      final result = await CommonMethods.determinePosition();
      log("Location got: ${result.latitude}-${result.longitude}");
      if (mounted) CommonMethods.dismissLoading(context);
      if (mounted) {
        CommonMethods.removeAllRoutesAndPushNamed(
            routeName: Routes.afterlogin, context: context);
      }
    } catch (e) {
      CommonMethods.showAlertWithOkButton(
          context: context, message: e.toString());
    }
  }

  void _handleLocationManual(BuildContext context) async {
    if (mounted) Navigator.of(context).pushNamed(Routes.yourLocation);
  }
}
