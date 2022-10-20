import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_text_button.dart';

import '../utils/colors.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CarouselSlider(
        carouselController: _controller,
        items: [
          _discoverPlace(context),
          _searchPlaceEasily(context),
          _readyToMove(context),
        ],
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          viewportFraction: 1.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
        ),
      ),
    );
  }

  _discoverPlace(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: Konstants.defaultImagesList[1],
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
              ),
             /* Positioned(
                right: 16,
                top: 64,
                child: CustomTextButton(
                  color: Colors.white,
                  text: "Skip",
                  onTap: () {
                    gotoLoginPage(context);
                  },
                ),
              ),*/
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            children: [
              hCustom(64),
              Text(
                "Discover place near you",
                style: TextStyles.bigTitle.copyWith(color: Colors.white),
              ),
              h16,
              Text(
                "Find the best place you want by your location or neighborhood",
                style: TextStyles.body1.copyWith(color: Colors.white),
              ),
              hCustom(64),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Positioned(
                    right: 16,
                    top: 64,
                    child: CustomTextButton(
                      color: ColorUtils.primary,
                      text: "Skip",
                      onTap: () {
                        gotoLoginPage(context);
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  CustomFillButton(
                      onTapFunction: () {
                        _controller.jumpToPage(1);
                      },
                      childText: Strings.next)
                ],
              ),
              hCustom(64),
            ],
          ),
        ),
      ],
    );
  }

  _searchPlaceEasily(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: Konstants.defaultImagesList[0],
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
              ),
              /*Positioned(
                right: 16,
                top: 64,
                child: CustomTextButton(
                  color: Colors.white,
                  text: "Skip",
                  onTap: () {
                    gotoLoginPage(context);
                  },
                ),
              ),*/
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            children: [
              hCustom(64),
              Text(
                "Search for place easily",
                style: TextStyles.bigTitle.copyWith(color: Colors.white),
              ),
              h16,
              Text(
                "Decide where to sleep with family and friends to enjoy the beautiful day",
                style: TextStyles.body1.copyWith(color: Colors.white),
              ),
              hCustom(64),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Positioned(
                    right: 16,
                    top: 64,
                    child: CustomTextButton(
                      color: ColorUtils.primary,
                      text: "Skip",
                      onTap: () {
                        gotoLoginPage(context);
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  CustomFillButton(
                      onTapFunction: () {
                        _controller.jumpToPage(2);
                      },
                      childText: Strings.next)
                ],
              ),
              hCustom(64),
            ],
          ),
        ),
      ],
    );
  }

  _readyToMove(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CachedNetworkImage(
            imageUrl: Konstants.defaultImagesList[2],
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            children: [
              hCustom(64),
              Text(
                "Ready to move in beautiful place",
                style: TextStyles.bigTitle.copyWith(color: Colors.white),
              ),
              h16,
              Text(
                "A beautiful day with hot chocolate in a new place with loved ones",
                style: TextStyles.body1.copyWith(color: Colors.white),
              ),
              hCustom(64),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomFillButton(
                      onTapFunction: () {
                        gotoLoginPage(context);
                      },
                      childText: Strings.getStarted)
                ],
              ),
              hCustom(64),
            ],
          ),
        ),
      ],
    );
  }

  gotoLoginPage(BuildContext context) {
    CommonMethods.removeAllRoutesAndPushNamed(
        routeName: Routes.login, context: context);
  }
}
