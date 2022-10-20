import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(context: context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.support,
              style: TextStyles.bigTitle,
            ),
            const SizedBox(
              height: 8,
            ),
            CachedNetworkImage(
              imageUrl: Konstants.defaultSupportPic,
              height: 200,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.mail_rounded,
                      color: ColorUtils.primaryLight,
                    ),
                    title: Text(
                      Strings.generalorbilling,
                      style: TextStyles.heading4,
                    ),
                    subtitle: Text(
                      Konstants.generalinfomail,
                      style: TextStyles.body1,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.mail_rounded,
                      color: ColorUtils.primaryLight,
                    ),
                    title: Text(
                      Strings.techSupport,
                      style: TextStyles.heading4,
                    ),
                    subtitle: Text(
                      Konstants.techSupportMail,
                      style: TextStyles.body1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
