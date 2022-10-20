import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/network_service.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  String? name = '';
  String? emailid = '';

  String? profilePicUrl ;

  @override
  load_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await NetworkService.login(
      email: prefs.getString(Konstants.keyEmail) ?? "",
      password: prefs.getString(Konstants.keyPassword) ?? "",
    );
    setState(() {
      name = result['user_data']['name'];
    emailid = result['user_data']['email'];
    profilePicUrl = result['user_data']['profile_pic'];
    });

    if (profilePicUrl == null || profilePicUrl!.isEmpty) {
      profilePicUrl = Konstants.defaultProfilePic;
    }
  }

  Widget build(BuildContext context) {
    load_data();
    return Scaffold(
      appBar: CustomAppBar2(context: context),
      body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.appSettings,
                style: TextStyles.bigTitle,
              ),
              h16,
              ProfileSection(
                profilePicUrl: profilePicUrl,
                name: name,
                emailId: emailid,
                onTap: () {},
              ),
              h16,
              DrawerMenuItem(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.changePassword);
                  },
                  leading: Icon(Icons.password),
                  title: Strings.changePassword),
              DrawerMenuItem(
                  onTap: () async {
                    final rsult = await CommonMethods.showConfirmationDialog(
                        context: context,
                        message: Strings.confirmDeleteAccount);
                    if (rsult) {
                      CommonMethods.removeAllRoutesAndPushNamed(
                          routeName: Routes.login, context: context);
                    }
                  },
                  leading: Icon(Icons.delete),
                  title: Strings.deleteAccount),
            ],
          )),
    );
  }
}
