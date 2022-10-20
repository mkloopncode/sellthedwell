import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/screens/explore_map_scren.dart';
import 'package:sellthedwell/screens/main_screen.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/property_item.dart';

class MyActiveListings extends StatefulWidget {
  const MyActiveListings({
    Key? key,
  }) : super(key: key);

  @override
  State<MyActiveListings> createState() => _MyActiveListingsState();
}

class _MyActiveListingsState extends State<MyActiveListings> {
  bool _isMapShown = false;
  final List<PropertyModel> propsList = [];
  bool loading = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getPropertyList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        context: context,
        // actions: [
        //   // ActionButtonsWidget(onFilterTap: () {
        //   //   _handleFilterClick(context);
        //   // })
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.myactivelistings,
              style: TextStyles.bigTitle,
            ),
            const SizedBox(
              height: 16,
            ),
            Text("${propsList.length} ${Strings.properties}"),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressWidget())
                  : propsList.isEmpty
                      ? Center(
                          child: Text(Strings.noData),
                        )
                      : _isMapShown
                          ? ExloreMapScreen(
                              propsList: propsList,
                            )
                          : ListView.separated(
                              itemBuilder: (_, i) {
                                return PropertyItem(
                                  prop: propsList[i],
                                  getUid: "",
                                  onFavourite: () async {
                                    await CommonMethods.toggleFavourite(
                                        context, propsList[i]);
                                    _getPropertyList();
                                  },
                                  onEdit: () async {
                                    await CommonMethods.handleEditClick(
                                        context, propsList[i]);
                                    _getPropertyList();
                                  },
                                  onDelete: () async {
                                    await CommonMethods.deleteProperty(
                                        context, propsList[i]);
                                    _getPropertyList();
                                  },
                                );
                              },
                              separatorBuilder: (_, __) => const Divider(),
                              itemCount: propsList.length,
                              shrinkWrap: true,
                            ),
            )
          ],
        ),
      ),
    );
  }



  _getPropertyList() async {
    try {
      setState(() {
        loading = true;
      });
      final List<PropertyModel> list =
          await NetworkService.getactiveviewproperties();
      propsList.clear();
      for (var p in list) {
        propsList.add(p);
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      toast(e.toString());
    }
  }

  void _handleFilterClick(BuildContext context) {}
}
