import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/enums.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chat/ChatDetailPage.dart';

class PropertyItem extends StatelessWidget {
  final PropertyModel prop;
  final String getUid;
  final void Function()? onFavourite;
  final void Function()? onEdit;
  final void Function()? onDelete;
  final void Function()? onTap;
  final void Function()? onChatClick;
  final void Function()? onFlagClick;

  const PropertyItem({
    Key? key,
    required this.prop,
    required this.getUid,
    this.onFavourite,
    this.onEdit,
    this.onDelete,
    this.onTap,
    this.onChatClick,
    this.onFlagClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    print(getUid);
    print(prop.authorId);
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    // border: Border.all(
                    //     color: ColorUtils.backgroundGrey, width: 1)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: prop.listimage ??
                        prop.image?[0] ??
                        Konstants.defaultHousePic,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const Center(
                        child: CircularProgressIndicator.adaptive()),
                    errorWidget: (_, __, ___) => CachedNetworkImage(
                      imageUrl: Konstants.defaultHousePic,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .51,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Wrap(
                                      children: [
                                        Text("${prop.numberBedroom} ${Strings.beds}")
                                      ],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.circle,
                                    size: 4,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Wrap(
                                    children: [
                                      Text("${prop.numberBathroom} ${Strings.baths}")
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.circle,
                                    size: 4,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*.13,
                                    child: Text("${prop.square} ${Strings.sqft}hhhhhhhhhhhhhhhhhhhh",overflow: TextOverflow.ellipsis,maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${prop.name}",
                                      style: TextStyles.heading4,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$${prop.price}",
                                style: TextStyles.amountTextStyle,
                              ),
                              Visibility(
                                visible: _checkScheduledStatus(),
                                child: Text(
                                  Strings.scheduled,
                                  style: TextStyles.body1,
                                ),
                              ),
                            ],
                          ),
                      ),
                      onEdit != null || onChatClick != null ?
                      Column(
                        children: [
                          Visibility(
                            visible: onEdit != null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: onEdit,
                                  icon: const Icon(
                                    Icons.edit_note,
                                    color: ColorUtils.primaryLight,
                                  ),
                                ),
                                IconButton(
                                  onPressed: onDelete,
                                  icon: const Icon(
                                    Icons.delete,
                                    color: ColorUtils.primaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            /*width: MediaQuery
                                .of(context)
                                .size
                                .width * .38,*/
                            child:
                            Visibility(
                              visible: onChatClick != null,
                              child: Wrap(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(.5),
                                        child: IconButton(
                                          onPressed: onFavourite,
                                          icon: Icon(
                                            prop.favorite == 1 ? Icons.favorite : Icons.favorite_outline,
                                            color: ColorUtils.primary,
                                          ),
                                        ),
                                      ),

                                      Container(
                                          padding: EdgeInsets.all(.5),
                                          child:
                                          Visibility(
                                            visible: getUid == prop.authorId.toString()? false : true,
                                            child :  IconButton(
                                              onPressed: onChatClick,
                                              icon: Icon(
                                                Icons.comment ,
                                                color: ColorUtils.primary,
                                              ),
                                            ),
                                          )
                                      ),

                                      Container(
                                          padding: EdgeInsets.all(.5),
                                          child:
                                          Visibility(
                                            visible: true,
                                            child :  IconButton(
                                              onPressed: onFlagClick,
                                              icon: Icon(
                                                Icons.flag_outlined ,
                                                color: ColorUtils.primary,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ) ,
                          )
                        ],
                      ) : SizedBox(),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        /*Row(
          children: [
            Positioned(
            right: 8,
            top: 8,
            child: IconButton(
              onPressed: onFavourite,
              icon: Icon(
                prop.favorite == 1 ? Icons.favorite : Icons.favorite_outline,
                color: ColorUtils.primary,
              ),
            ),
          ),

            Positioned(
                right: 8,
                top: 45,
                child:
                Visibility(
                  visible: getUid == prop.authorId.toString()? false : true,
                  child :  IconButton(
                    onPressed: onChatClick,
                    icon: Icon(
                      Icons.comment ,
                      color: ColorUtils.primary,
                    ),
                  ),
                )
            ),

            Positioned(
                right: 8,
                top: 85,
                child:
                Visibility(
                  visible: getUid == prop.authorId.toString()? false : true,
                  child :  IconButton(
                    onPressed: onFlagClick,
                    icon: Icon(
                      Icons.flag ,
                      color: ColorUtils.primary,
                    ),
                  ),
                )
            )],
        )*/
      ],
    );
  }

  _checkScheduledStatus() {
    if (getDateFromStringInMMDDYYYY(prop.activeStartDate ?? "")
        .isAfter(DateTime.now())) {
      return true;
    }
    return false;
    // String todayDate =
    //     DateFormat(Konstants.mmddyyyyFormat).format(DateTime.now());
    // if (prop.activeDates?.contains(todayDate) ?? false) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

}
