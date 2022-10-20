// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/screens/profile_editing_screen.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/enums.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_text_button.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.black,
                        )),
                  ],
                ),
                DrawerMenuItem(
                  onTap: () {
                    Navigator.of(context).pop();
                    Provider.of<AuthProvider>(context, listen: false)
                        .setNavBarIndex(0);
                    //  Navigator.of(context).pushNamed(Routes.yourLocation);
                  },
                  title: Strings.searchOpenHouses,
                  leading: const Icon(Icons.search),
                ),
                const FreeServiceSection(),
                const PaidServiceSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleEditClick(BuildContext context) {}
}

class TestingSection extends StatelessWidget {
  const TestingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Testing
        DrawerMenuItem(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.changePassword);
            },
            leading: const Icon(Icons.password),
            title: Strings.changePassword),

        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.aboutMemebership);
          },
          title: "About Membership",
          leading: const Icon(Icons.info),
        ),

        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.tourRequest);
          },
          title: Strings.tourRequests,
          leading: const Icon(Icons.request_quote),
        ),
        DrawerMenuItem(
          onTap: () async {
            // Navigator.of(context).pop();
            final result = await CommonMethods.showConfirmationDialog(
                context: context, message: Strings.confirmationToLogout);

            if (!result) {
              return;
            }
            CommonMethods.showLoading(context);
            await Provider.of<AuthProvider>(context, listen: false).logout();
            CommonMethods.dismissLoading(context);
            CommonMethods.removeAllRoutesAndPushNamed(
                routeName: Routes.login, context: context);
          },
          title: Strings.logout,
          leading: const Icon(Icons.logout),
        ),
      ],
    );
  }
}

class FreeServiceSection extends StatelessWidget {
  const FreeServiceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            Strings.freeService,
            style: TextStyles.labelTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.recentlyViewed);
          },
          title: Strings.recentlyviewed,
          leading: const Icon(Icons.history),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.activeOpenHouses);
          },
          title: Strings.activeOpenHouses,
          leading: const Icon(Icons.home),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.scheduledOpenHouses);
          },
          title: Strings.scheduleOpenHouses,
          leading: const Icon(Icons.schedule),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<AuthProvider>(context, listen: false).setNavBarIndex(2);
          },
          title: Strings.favourites,
          leading: const Icon(Icons.favorite),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context)
                .pushNamed(Routes.tourRequest, arguments: TourRequest.SEND);
          },
          title: Strings.tourRequests,
          leading: const Icon(Icons.request_quote),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.support);
          },
          title: Strings.support,
          leading: const Icon(Icons.schedule),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.aboutUs);
          },
          title: Strings.aboutus,
          leading: const Icon(Icons.info),
        ),
      ],
    );
  }
}

class PaidServiceSection extends StatelessWidget {
  const PaidServiceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            Strings.paidServices,
            style: TextStyles.labelTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.addListing);
          },
          title: Strings.addListing,
          leading: const Icon(Icons.add_circle),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.activeListings);
          },
          title: Strings.activeListing,
          leading: const Icon(Icons.home),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.closedListings);
          },
          title: Strings.closedListings,
          leading: const Icon(Icons.remove_circle),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.scheduledListings);
          },
          title: Strings.scheduleListing,
          leading: const Icon(Icons.schedule),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.modifyListings);
          },
          title: Strings.modifyListings,
          leading: const Icon(Icons.edit_note),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context)
                .pushNamed(Routes.tourRequest, arguments: TourRequest.RECIEVE);
          },
          title: Strings.tourRequests,
          leading: const Icon(Icons.request_quote),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.membershipplan);
          },
          title: Strings.membershipplan,
          leading: const Icon(Icons.favorite),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.billingHistory);
          },
          title: Strings.billingHistory,
          leading: const Icon(Icons.attach_money),
        ),
        DrawerMenuItem(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.appSettings);
          },
          title: Strings.appSettings,
          leading: const Icon(Icons.settings),
        ),
      ],
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String? name;
  final String? profilePicUrl;
  final String? emailId;
  final void Function() onTap;
  const ProfileSection({
    Key? key,
    required this.profilePicUrl,
    required this.name,
    required this.emailId,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
            profilePicUrl ?? Konstants.defaultProfilePic,
          ),
          radius: 32,
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name ?? "User",
                  textAlign: TextAlign.start,
                  style: TextStyles.heading2,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      emailId ?? "-",
                      style: TextStyles.labelTextStyle,
                    ),
                    h8,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return ProfileEditingScreen(profileImage: profilePicUrl,);
                                }));
                         //   Navigator.of(context).pushNamed(Routes.editProfile);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorUtils.blueColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              Strings.editProfile,
                              style: TextStyles.textLink.copyWith(
                                color: ColorUtils.white,
                              ),
                            ),
                          ),
                        ),
                        w16,
                        InkWell(
                          onTap: () async {
                            final result =
                                await CommonMethods.showConfirmationDialog(
                                    context: context,
                                    message: Strings.confirmationToLogout);
                            if (result) {
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .logout();
                              CommonMethods.removeAllRoutesAndPushNamed(
                                  routeName: Routes.login, context: context);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorUtils.primaryDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              Strings.logout,
                              style: TextStyles.textLink.copyWith(
                                color: ColorUtils.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final void Function() onTap;
  final Widget leading;
  final String title;
  const DrawerMenuItem({
    Key? key,
    required this.onTap,
    required this.leading,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const SizedBox(
            //   width: 16,
            // ),
            leading,
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              title,
              style: TextStyles.drawerItem,
            )),
          ],
        ),
      ),
    );
  }
}
