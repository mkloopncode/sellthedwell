import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_outlined_button.dart';

class ExloreMapScreen extends StatefulWidget {
  final List<PropertyModel> propsList;
  const ExloreMapScreen({Key? key, required this.propsList}) : super(key: key);

  @override
  State<ExloreMapScreen> createState() => _ExloreMapScreenState();
}

class _ExloreMapScreenState extends State<ExloreMapScreen> {
  late GoogleMapController _controller;
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            _controller = controller;
            for (var prop in widget.propsList) {
              final Marker marker = Marker(
                markerId: MarkerId("${prop.id}"),
                position: LatLng(
                  double.parse("${prop.latitude}"),
                  double.parse("${prop.longitude}"),
                ),
                infoWindow: InfoWindow(
                  title: prop.name,
                  snippet: prop.location,
                ),
              );
              _markers["${prop.id}"] = marker;
            }
            setState(() {});
          },
          markers: _markers.values.toSet(),
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
            zoom: 15,
            target: LatLng(
              double.parse(widget.propsList[0].latitude.toString()),
              double.parse(
                widget.propsList[0].longitude.toString(),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 0,
          left: 0,
          child: Container(
            height: 150,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _handlePropertyClick(context, widget.propsList[index]);
                  },
                  child: Container(
                    constraints:
                        const BoxConstraints(maxHeight: 150, maxWidth: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorUtils.backgroundLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${widget.propsList[index].name}",
                          style: TextStyles.heading5,
                        ),
                        h8,
                        Text(
                          "\$${widget.propsList[index].price}",
                          style: TextStyles.heading4,
                        ),
                        h8,
                        Container(
                          alignment: Alignment.bottomRight,
                          height: 32,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: CustomFillButton(
                                childText: Strings.details,
                                icon: Icons.info_outline,
                                onTapFunction: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.detailsScreen,
                                      arguments: widget.propsList[index]);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: widget.propsList.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) {
                return w16;
              },
            ),
          ),
        ),
      ],
    );
  }

  void _handlePropertyClick(BuildContext context, PropertyModel prop) {
    _controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          double.parse("${prop.latitude}"),
          double.parse(
            "${prop.longitude}",
          ),
        ),
      ),
    );
  }
}
