import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/screens/explore_map_scren.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/enums.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/property_item.dart';

class ClosedListings extends StatefulWidget {
  const ClosedListings({Key? key}) : super(key: key);

  @override
  State<ClosedListings> createState() => _ClosedListingsState();
}

class _ClosedListingsState extends State<ClosedListings> {
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
        actions: [
        /*  IconButton(
            onPressed: () {
              _handleFilterClick(context);
            },
            icon: Icon(
              Icons.filter_alt,
              color: ColorUtils.black,
            ),
          ),*/
          /*_isMapShown
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isMapShown = !_isMapShown;
                    });
                  },
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: ColorUtils.black,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _isMapShown = !_isMapShown;
                    });
                  },
                  icon: Icon(
                    Icons.map,
                    color: ColorUtils.black,
                  ),
                ),*/
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.closedListings,
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
      final list = await NetworkService.getclosedviewproperties();
      propsList.clear();
      for (PropertyModel element in list) {
        if (getDateFromStringInMMDDYYYY(element.activeStartDate ?? "")
            .isBefore(DateTime.now())) {
          propsList.add(element);
        }
      }
      // propsList.addAll(list);
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
