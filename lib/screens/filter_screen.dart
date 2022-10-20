import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_text_button.dart';
import 'package:sellthedwell/widgets/custom_textfield.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String selectedSort = Strings.listinghighlow;
  String selectedPropCat = "";
  String selectedOpenHouse = Strings.active;
  String selectedBeds = Strings.any;
  String selectedBaths = Strings.any;
  double minSlider = 0;
  double maxSlider = 10000000;
  double selectedPriceMin = 0;
  double selectedPriceMax = 10000000;

  final TextEditingController _keywordsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        context: context,
        title: Text(
          Strings.filter,
          textAlign: TextAlign.center,
          style: TextStyles.appBarTitle,
        ),
        actions: [
          CustomTextButton(
            onTap: () {
              Navigator.of(context).pop();
            },
            text: Strings.reset,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sorting Options
              Text(Strings.sortOptions),
              StatefulBuilder(
                builder: (_, localState) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      ...[
                        Strings.listinghighlow,
                        Strings.listinglowhigh,
                        // Strings.yearbuiltnewtoolder,
                        Strings.squarefeet,
                        Strings.lotsizeSort,
                      ]
                          .map<Widget>(
                            (title) => InkWell(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyles.heading4,
                                    ),
                                    selectedSort == title
                                        ? const Icon(
                                            Icons.done,
                                            color: ColorUtils.primary,
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                ),
                              ),
                              onTap: () {
                                localState(() {
                                  selectedSort = title;
                                });
                              },
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 16,
              ),
              // property category
              Text(Strings.openhouses),
              const SizedBox(
                height: 8,
              ),
              StatefulBuilder(
                builder: (_, localState) {
                  return Row(
                    children: [
                      ...[
                        Strings.resedential,
                        Strings.commercial,
                        Strings.rentals,
                      ]
                          .map<Widget>(
                            (title) => Expanded(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedPropCat == title
                                        ? ColorUtils.primary
                                        : Colors.white,
                                    border: Border.all(
                                      color: ColorUtils.primaryDark,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    title,
                                    style: TextStyles.heading6.copyWith(
                                      color: selectedPropCat == title
                                          ? ColorUtils.white
                                          : ColorUtils.primary,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  localState(() {
                                    selectedPropCat = title;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 16,
              ),

              // Openhouses category
              /*    Text(Strings.propertyCategory),
              const SizedBox(
                height: 8,
              ),
              StatefulBuilder(
                builder: (_, localState) {
                  return Row(
                    children: [
                      ...[
                        Strings.active,
                        Strings.scheduled,
                        Strings.all,
                      ]
                          .map<Widget>(
                            (title) => Expanded(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedOpenHouse == title
                                        ? ColorUtils.primary
                                        : Colors.white,
                                    border: Border.all(
                                      color: ColorUtils.primaryDark,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    title,
                                    style: TextStyles.heading6.copyWith(
                                      color: selectedOpenHouse == title
                                          ? ColorUtils.white
                                          : ColorUtils.primary,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  localState(() {
                                    selectedOpenHouse = title;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
              ),const SizedBox(
                height: 16,
              ),
 */

              // Beds category
              Text(Strings.beds),
              const SizedBox(
                height: 8,
              ),
              StatefulBuilder(
                builder: (_, localState) {
                  return Row(
                    children: [
                      ...[
                        Strings.any,
                        "1",
                        "2",
                        "3",
                        "4",
                      ]
                          .map<Widget>(
                            (title) => Expanded(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedBeds == title
                                        ? ColorUtils.primary
                                        : Colors.white,
                                    border: Border.all(
                                      color: ColorUtils.primaryDark,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    title,
                                    style: TextStyles.heading6.copyWith(
                                      color: selectedBeds == title
                                          ? ColorUtils.white
                                          : ColorUtils.primary,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  localState(() {
                                    selectedBeds = title;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 16,
              ),

              // Beds category
              Text(Strings.baths),
              const SizedBox(
                height: 8,
              ),
              StatefulBuilder(
                builder: (_, localState) {
                  return Row(
                    children: [
                      ...[
                        Strings.any,
                        "1",
                        "2",
                        "3",
                        "4",
                      ]
                          .map<Widget>(
                            (title) => Expanded(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedBaths == title
                                        ? ColorUtils.primary
                                        : Colors.white,
                                    border: Border.all(
                                      color: ColorUtils.primaryDark,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    style: TextStyles.heading6.copyWith(
                                      color: selectedBaths == title
                                          ? ColorUtils.white
                                          : ColorUtils.primary,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  localState(() {
                                    selectedBaths = title;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 16,
              ),
              Text(Strings.priceRange),
              StatefulBuilder(
                builder: (_, localSetState) => Column(
                  children: [
                    RangeSlider(
                      values: RangeValues(selectedPriceMin, selectedPriceMax),
                      min: minSlider,
                      max: maxSlider,
                      activeColor: ColorUtils.primary,
                      inactiveColor: ColorUtils.backgroundDark,
                      labels: const RangeLabels("\$minSlider", "\$end"),
                      onChanged: (range) {
                        selectedPriceMin = range.start;
                        selectedPriceMax = range.end;
                        localSetState(() {});
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${minSlider}",
                          style: TextStyles.body1,
                        ),
                        Text(
                          "\$${selectedPriceMin.toStringAsFixed(0)} - \$${selectedPriceMax.toStringAsFixed(0)}",
                          style: TextStyles.heading4,
                        ),
                        Text(
                          "\$${maxSlider}",
                          style: TextStyles.body1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 16,
              ),
              /*   Text(
                Strings.moreoptions,
              ),
              MoreOptionsTile(title: Strings.squareFeet, onTap: () {}),
              MoreOptionsTile(title: Strings.lotsize, onTap: () {}),
              MoreOptionsTile(title: Strings.yearBuilt, onTap: () {}),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.keywords,
                      style: TextStyles.heading4,
                    ),
                  ],
                ),
              ),
             */
              /*   CustomTextFieldWidget(
                controller: _keywordsController,
                labelText: Strings.keywordsnote,
                hintText: Strings.keywordsnote,
                isRequired: false,
              ), */
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomFillButton(
                    onTapFunction: () {
                      _handleApplyFilters(context);
                    },
                    childText: Strings.applyFilters,
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleApplyFilters(BuildContext context) async {
    Navigator.of(context).pop({
      Konstants.fSort: selectedSort,
      Konstants.fOpen: selectedOpenHouse,
      Konstants.fPropCategory: selectedPropCat,
      Konstants.fBed: selectedBeds,
      Konstants.fBath: selectedBaths,
      Konstants.fMinPrice: selectedPriceMin.toStringAsFixed(0),
      Konstants.fMaxPrice: selectedPriceMax.toStringAsFixed(0),
    });
  }
}

class MoreOptionsTile extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const MoreOptionsTile({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.heading4,
            ),
            Icon(
              Icons.arrow_right,
              color: ColorUtils.backgroundGrey,
            )
          ],
        ),
      ),
    );
  }
}
