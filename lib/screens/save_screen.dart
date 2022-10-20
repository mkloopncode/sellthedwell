import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/screens/explore_map_scren.dart';
import 'package:sellthedwell/screens/explore_screen.dart';
import 'package:sellthedwell/screens/main_screen.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/drawer.dart';

class SavedScreen extends StatefulWidget {
  SavedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  // bool _isMapShown = false;
  final List<PropertyModel> savedList = [];
  final List<PropertyModel> savedListOriginal = [];
  bool leading = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getSavedPropertyList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Image.asset(
          Konstants.logoPath,
          height: 32,
        ),
        actions: [
          ActionButtonsWidget(
            onFilterTap: () {
              _handleFilterClick(context);
            },
          )
        ],
        isBackShown: false,
      ),
      drawer: const DrawerMenu(),
      body: Consumer<AuthProvider>(
        builder: (_, auth, ___) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.saved,
                style: TextStyles.bigTitle,
              ),
              const SizedBox(
                height: 16,
              ),
              Text("${savedList.length} ${Strings.properties}"),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: leading
                    ? const Center(
                        child: CircularProgressWidget(),
                      )
                    : auth.showMapInExplore
                        ? ExloreMapScreen(
                            propsList: savedList,
                          )
                        : savedList.isEmpty
                            ? Center(
                                child: Text(Strings.noData),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (_, i) {
                                  final PropertyModel model = savedList[i];
                                  return InkWell(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(Routes.detailsScreen,
                                            arguments: model),
                                    child: SavedPropItem(
                                      model: model,
                                      onFavourite: () async {
                                        await CommonMethods.toggleFavourite(
                                            context, model);
                                        _getSavedPropertyList();
                                      },
                                    ),
                                  );
                                },
                                itemCount: savedList.length,
                                separatorBuilder: (_, __) => const Divider(
                                  thickness: 1.2,
                                  height: 16,
                                ),
                              ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getSavedPropertyList() async {
    try {
      setState(() {
        leading = true;
      });
      final list = await NetworkService.getSavedProperties();
      savedList.clear();
      savedListOriginal.clear();
      savedListOriginal.addAll(list);
      savedList.addAll(list);
      setState(() {
        leading = false;
      });
    } catch (e) {
      setState(() {
        leading = false;
      });
      toast(e.toString());
      print(e.toString());
    }
  }

  _handleFilterClick(BuildContext context) async {
    final Map<String, String> result = await Navigator.of(context)
        .pushNamed(Routes.filterScreen) as Map<String, String>;
    log("Result: $result");
    if (result != null) {
      final List<PropertyModel> list =
          CommonMethods.getFilteredResults(savedListOriginal, result);
      savedList.clear();
      savedList.addAll(list);
      setState(() {});
    }
  }
}

class SavedPropItem extends StatelessWidget {
  final PropertyModel model;
  final void Function() onFavourite;
  const SavedPropItem(
      {Key? key, required this.model, required this.onFavourite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // border: Border.all(
                //     color: ColorUtils.backgroundGrey, width: 1)),
              ),
              child: CachedNetworkImage(
                imageUrl: model.listimage ?? Konstants.defaultHousePic,
                height: 400,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (_, __, ___) => CachedNetworkImage(
                  imageUrl: Konstants.defaultHousePic,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                right: 8,
                top: 16,
                child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 0.2,
                      blurRadius: 20,
                    ),
                  ]),
                  child: InkWell(
                    onTap: onFavourite,
                    child: const Icon(
                      Icons.favorite,
                      color: ColorUtils.primary,
                      size: 24,
                    ),
                  ),
                )),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("${model.numberBedroom} ${Strings.beds}"),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.circle,
                      size: 4,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("${model.numberBathroom} ${Strings.baths}"),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.circle,
                      size: 4,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("${model.square} ${Strings.sqft}"),
                  ],
                ),
                Text(
                  "${model.name}",
                  softWrap: true,
                  style: TextStyles.heading4,
                ),
                Text(
                  "\$${model.price}",
                  style: TextStyles.amountTextStyle.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
