
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/screens/explore_map_scren.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/property_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/konstants.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
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
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.recentlyviewed,
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
                                  getUid: propsList[i].id.toString(),
                                  /*onFavourite: () async {
                                    await CommonMethods.toggleFavourite(
                                        context, propsList[i]);
                                    _getPropertyList();
                                  },*/
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



  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }

  _getPropertyList() async {
    try {
      setState(() {
        loading = true;
      });
      final list = await NetworkService.getrecentlyviewproperties();
      propsList.clear();
      propsList.addAll(list);
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
