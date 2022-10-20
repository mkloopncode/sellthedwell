import 'package:flutter/material.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.profileScreen,
              style: TextStyles.bigTitle,
            ),
            const SizedBox(
              height: 16,
            ),
            const TestingSection(),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
