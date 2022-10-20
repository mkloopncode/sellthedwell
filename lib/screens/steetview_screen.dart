import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';

class GoogleStreetViewScreen extends StatefulWidget {
  final PropertyModel prop;
  const GoogleStreetViewScreen({Key? key, required this.prop})
      : super(key: key);

  @override
  State<GoogleStreetViewScreen> createState() => _GoogleStreetViewScreenState();
}

class _GoogleStreetViewScreenState extends State<GoogleStreetViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
          context: context,
          title: Text(
           "Street View",// widget.prop.name!,
            style: TextStyles.appBarTitle,
          )),
      body: FlutterGoogleStreetView(
        initPos: LatLng(
          double.parse(widget.prop.latitude.toString()),
          double.parse(widget.prop.longitude.toString()),
        ),
      ),
    );
  }
}
