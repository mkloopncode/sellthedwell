import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/models/about_model.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  AboutResponseModel? about;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAboutDetails();
    });
    super.initState();
  }

  _getAboutDetails() async {
    try {
      about = await NetworkService.getAboutDetails();
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
                Strings.aboutus,
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
                          "${about?.about?.header}",
                          textAlign: TextAlign.center,
                          style: TextStyles.heading2.copyWith(
                            color: ColorUtils.primaryLight,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${about?.about?.subHeader}",
                          textAlign: TextAlign.center,
                          style: TextStyles.body1,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrlString("${about?.about?.youtubeLink}");
                          },
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                            color: ColorUtils.primaryLight,
                            size: 48,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "${about?.about?.header_2}",
                          textAlign: TextAlign.center,
                          style: TextStyles.heading4,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${about?.about?.subHeader_2}",
                          textAlign: TextAlign.center,
                          style: TextStyles.body1,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BoxItem(
                          header: "${about?.about?.box_1Header}",
                          content: "${about?.about?.box_1Content}",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BoxItem(
                          header: "${about?.about?.box_2Header}",
                          content: "${about?.about?.box_2Content}",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BoxItem(
                          header: "${about?.about?.box_3Header}",
                          content: "${about?.about?.box_3Content}",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BoxItem(
                          header: "${about?.about?.box_4Header}",
                          content: "${about?.about?.box_4Content}",
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class BoxItem extends StatelessWidget {
  final String header;
  final String content;
  const BoxItem({Key? key, required this.header, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyles.heading4,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            content,
            style: TextStyles.body1,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
