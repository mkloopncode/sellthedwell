import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/screens/explore_map_scren.dart';
import 'package:sellthedwell/screens/main_screen.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/property_item.dart';

class ActiveOpenHousesScreen extends StatefulWidget {
  const ActiveOpenHousesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ActiveOpenHousesScreen> createState() => _ActiveOpenHousesScreenState();
}

class _ActiveOpenHousesScreenState extends State<ActiveOpenHousesScreen> {
  final List<PropertyModel> propsList = [];
  late BuildContext _context;
  bool loading = false;
  bool _isMapShown = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final auth = Provider.of<AuthProvider>(
      //   _context,
      //   listen: false,
      // );
      // read from provider , if empty, call again.
      await _getPropertyList();
      // if (auth.allProperties.isEmpty) {
      // } else {
      //   propsList.addAll(auth.allProperties);
      // }
      // _filterActiveOpenHouses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: CustomAppBar2(
        context: context,
        // actions: [
        //   ActionButtonsWidget(onFilterTap: () {
        //     _handleFilterClick(context);
        //   }),
        // ],
      ),
      body: Consumer<AuthProvider>(
        builder: (_, auth, ___) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.activeOpenHouses,
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
                        : auth.showMapInExplore
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
                                    onTap: () async {
                                      await Navigator.of(context,
                                              rootNavigator: true)
                                          .pushNamed(
                                        Routes.detailsScreen,
                                        arguments: propsList[i],
                                      );
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
      ),
    );
  }

  _getPropertyList() async {
    try {
      setState(() {
        loading = true;
      });
      final list = await NetworkService.getActiveOpenProperties();
      propsList.clear();
      propsList.addAll(list);
      // final auth = Provider.of<AuthProvider>(_context, listen: false);
      // auth.addProperties(propsList);
    } catch (e) {
      toast(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  // _filterActiveOpenHouses() {
  //   final List<PropertyModel> list = [];
  //   final String todayDate = DateFormat("MM-dd-yyyy").format(DateTime.now());
  //   for (var prop in propsList) {
  //     if (prop.activeDates?.contains(todayDate) ?? false) {
  //       list.add(prop);
  //     }
  //   }
  //   propsList.clear();
  //   propsList.addAll(list);
  //   setState(() {});
  // }

  void _handleFilterClick(BuildContext context) {}
}
