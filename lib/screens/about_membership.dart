import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/models/about_membership.dart';
import 'package:sellthedwell/screens/about_list.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutMemebership extends StatefulWidget {
  const AboutMemebership({Key? key}) : super(key: key);

  @override
  State<AboutMemebership> createState() => _AboutMemebershipState();
}

class _AboutMemebershipState extends State<AboutMemebership> {
  AboutMembershipResponse? about;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAboutDetails();
    });
    super.initState();
  }

  _getAboutDetails() async {
    try {
      about = await NetworkService.getAboutMembershipDetails();
    } catch (e) {
      toast(e.toString());
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(context: context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.aboutMembership,
                style: TextStyles.bigTitle,
              ),
              about == null
                  ? const SizedBox(
                      height: 400,
                      child: Center(child: CircularProgressWidget()),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "${about?.header}",
                          textAlign: TextAlign.center,
                          style: TextStyles.heading2,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Html(
                          data: "${about?.subLine_1}",
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${about?.header_2}",
                          textAlign: TextAlign.center,
                          style: TextStyles.heading4,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${about?.subHeader_2}",
                          textAlign: TextAlign.center,
                          style: TextStyles.body1,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // BoxItem(
                        //   header: "${about?.box_1Header}",
                        //   content: "${about?..box_1Content}",
                        // ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // BoxItem(
                        //   header: "${about?.box_2Header}",
                        //   content: "${about?.box_2Content}",
                        // ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // BoxItem(
                        //   header: "${about?..box_3Header}",
                        //   content: "${about?.box_3Content}",
                        // ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // BoxItem(
                        //   header: "${about?.box_4Header}",
                        //   content: "${about?.box_4Content}",
                        // ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
