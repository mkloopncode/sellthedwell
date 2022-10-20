import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sellthedwell/chat/ChatScreen.dart';
import 'package:sellthedwell/chat/ChatTabScreen.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/screens/category_screen.dart';
import 'package:sellthedwell/screens/explore_screen.dart';
import 'package:sellthedwell/screens/profile_screen.dart';
import 'package:sellthedwell/screens/save_screen.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool loading = false;
  final List<PropertyModel> savedList = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final auth = Provider.of<AuthProvider>(context, listen: false);
        if (auth.navBarIndex != 0) {
          auth.setNavBarIndex(0);
          return false;
        }
        return await CommonMethods.showConfirmationDialog(
          context: context,
          message: Strings.confirmationToExit,
        );
      },
      child: Scaffold(
        /*   drawer: DrawerMenu(
          callbacks: CommonMethods.getCallbacksList(context),
        ),
        appBar: CustomAppBar(
          isCenter: false,
          titleWidget: Consumer<AuthProvider>(
            builder: (_, auth, ___) {
              return auth.appBarTitle.isNotEmpty
                  ? Image.asset(
                      Konstants.logoPath,
                      height: 32,
                    )
                  : SizedBox.shrink();
            },
          ),
          isBackShown: false,
          actions: [
            ActionButtonsWidget(onFilterTap: () {
              _handleFilterClick(context);
            })
          ],
        ),
        */
        body: Consumer<AuthProvider>(
          builder: (_, auth, ___) {
            if (auth.navBarIndex == 0) {
              return ExploreScreen(
                onFilter: () {
                  _handleFilterClick(context);
                },
              );
            } else if (auth.navBarIndex == 1) {
              return const CategoryScreen();
            } else if (auth.navBarIndex == 2) {
              return SavedScreen();
            } else if (auth.navBarIndex == 3) {
              return ChatTabScreen();
            }
            // } else if (auth.navBarIndex == 3) {
            //   return const ProfileScreen();
            // }
            return ExploreScreen(
              onFilter: () {
                _handleFilterClick(context);
              },
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }

  void _handleFilterClick(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(Routes.filterScreen);
    log("Result: $result");
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, auth, ___) {
        log("Navbar index changed: ${auth.navBarIndex}");
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavBarItem(
                text: Strings.explore,
                itemIndex: 0,
                selectedIndex: auth.navBarIndex,
                iconData: Icons.explore,
              ),
              NavBarItem(
                text: Strings.category,
                itemIndex: 1,
                selectedIndex: auth.navBarIndex,
                iconData: Icons.comment,
              ),
              NavBarItem(
                text: Strings.saved,
                itemIndex: 2,
                selectedIndex: auth.navBarIndex,
                iconData: Icons.favorite,
              ),

              NavBarItem(
                text: "Chat",
                itemIndex: 3,
                selectedIndex: auth.navBarIndex,
                iconData: Icons.comment,
              ),
              // NavBarItem(
              //   text: Strings.account,
              //   itemIndex: 3,
              //   selectedIndex: auth.navBarIndex,
              //   iconData: Icons.person,
              // ),
            ],
          ),
        );
      },
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String text;
  final int itemIndex;
  final int selectedIndex;
  final IconData iconData;

  const NavBarItem({
    Key? key,
    required this.text,
    required this.itemIndex,
    required this.selectedIndex,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool selected = (itemIndex == selectedIndex);
    return InkWell(
      onTap: () {
        final auth = Provider.of<AuthProvider>(context, listen: false);

        auth.setNavBarIndex(itemIndex);
        if (auth.navBarIndex == 0) {
          auth.setTitle(Strings.appName);
        } else {
          auth.setTitle("");
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: selected ? ColorUtils.primary : ColorUtils.backgroundGrey,
          ),
          Text(
            text,
            style: selected ? TextStyles.body2 : TextStyles.labelTextStyle,
          ),
        ],
      ),
    );
  }
}

class ActionButtonsWidget extends StatelessWidget {
  final void Function() onFilterTap;
  const ActionButtonsWidget({Key? key, required this.onFilterTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, auth, ___) => Visibility(
        visible: auth.navBarIndex == 0 || auth.navBarIndex == 2,
        child: Row(
          children: [
            IconButton(
              onPressed: onFilterTap,
              icon: Icon(
                Icons.filter_alt,
                color: ColorUtils.black,
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .setShowMapInExplore(!auth.showMapInExplore);
              },
              icon: Icon(
                auth.showMapInExplore ? Icons.format_list_bulleted : Icons.map,
                color: ColorUtils.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
