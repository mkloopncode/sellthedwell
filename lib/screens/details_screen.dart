import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/panoramic_view/PanoramicView.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/screens/image_screen.dart';
import 'package:sellthedwell/threedobject/ImageAssests_HomePage.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/vr/initial_page.dart';
import 'package:sellthedwell/widgets/custom_outlined_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/circular_progress.dart';
import '../widgets/custom_textfield.dart';

class DetailsScreen extends StatefulWidget {
  final PropertyModel prop;
  const DetailsScreen({Key? key, required this.prop}) : super(key: key);


  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  static PropertyModel prop = PropertyModel();
  final Map<String, Marker> _markers = {};
  bool loading = false;


  @override
  void initState() {
    prop = widget.prop;

    super.initState();
    print(prop.images_vr);
    postRecentView();
  }


  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }

  void postRecentView() async{

    try{

      Response response = await post(
        Uri.parse(Konstants.baseUrl+"/recentlyview"),
        body: {
          "property_id": prop.id.toString(),
        },
        headers: await getHeaders(),
      );
      if(response.statusCode == 200){
        setState(() {
          loading = true;
        });

      }else{
        print("failed");
      }

    }catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  loading == false
            ?  Container(child :  Center(child: CircularProgressWidget())) :
        SingleChildScrollView(
          child:
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: prop.listimage ?? Konstants.defaultHousePic,
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
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        color: ColorUtils.white,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await CommonMethods.toggleFavourite(
                                  context, prop);
                              setState(() {
                                prop.favorite = prop.favorite == 1 ? 0 : 1;
                              });
                            },
                            icon: prop.favorite == 0
                                ? const Icon(Icons.favorite_outline)
                                : const Icon(Icons.favorite),
                            color: ColorUtils.primary,
                          ),
                          IconButton(
                            onPressed: () {
                              CommonMethods.share(
                                title: prop.name ?? "",
                                description: prop.images![0],
                              );
                            },
                            icon: const Icon(Icons.ios_share),
                            color: ColorUtils.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorUtils.white.withOpacity(0.8),
                          ColorUtils.white
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${prop.numberBedroom} ${Strings.beds}",
                              style: TextStyles.heading5,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.circle,
                                size: 8,
                              ),
                            ),
                            Text(
                              "${prop.numberBathroom} ${Strings.baths}",
                              style: TextStyles.heading5,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.circle,
                                size: 8,
                              ),
                            ),
                            Text(
                              "${prop.square} ${Strings.sqft}",
                              style: TextStyles.heading5,
                            ),
                          ],
                        ),
                        Text(
                          prop.name!,
                          style: TextStyles.heading1,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "\$${prop.price}",
                          style: TextStyles.heading2,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            prop.images?.replaceAll("[", "");
                            prop.images?.replaceAll("]", "");
                            final List<String> list = prop.image?.map<String>((e) => e!).toList() ?? [];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageScreen(imageList: list)
                              ),
                            );
                            //_handlePhotosClick(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Konstants.defaultPhotosPath,
                                height: 70,
                              ),
                              h8,
                              Text(
                                Strings.photos,
                                style: TextStyles.labelDark,
                              ),
                            ],
                          ),
                          /*  Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    prop.image?[0] ?? Konstants.defaultHousePic,
                                placeholder: (_, __) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                                fit: BoxFit.fill,
                                errorWidget: (_, __, ___) => CachedNetworkImage(
                                  imageUrl: Konstants.defaultHousePic,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Text(
                                  "${prop.image?.length} ${Strings.photos}",
                                  textAlign: TextAlign.center,
                                  style: TextStyles.heading6.copyWith(
                                    color: ColorUtils.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                         */
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _handleStreetView(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Konstants.defaultStreetPath,
                                height: 70,
                              ),
                              h8,
                              Text(
                                Strings.streetView,
                                style: TextStyles.labelDark,
                              )
                            ],
                          ), /* Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    prop.listimage ?? Konstants.defaultHousePic,
                                placeholder: (_, __) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                                fit: BoxFit.fill,
                                errorWidget: (_, __, ___) => CachedNetworkImage(
                                  imageUrl: Konstants.defaultHousePic,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Text(Strings.streetView,
                                    textAlign: TextAlign.center,
                                    style: TextStyles.heading6.copyWith(
                                      color: ColorUtils.white,
                                    )),
                              ),
                            ],
                          ), */
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _handle3DImage(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Konstants.default3dModel,
                                height: 70,
                              ),
                              h8,
                              Text(
                                "3D Model",
                                style: TextStyles.labelDark,
                              )
                            ],
                          ), /* Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    prop.listimage ?? Konstants.defaultHousePic,
                                placeholder: (_, __) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                                fit: BoxFit.fill,
                                errorWidget: (_, __, ___) => CachedNetworkImage(
                                  imageUrl: Konstants.defaultHousePic,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Text(Strings.streetView,
                                    textAlign: TextAlign.center,
                                    style: TextStyles.heading6.copyWith(
                                      color: ColorUtils.white,
                                    )),
                              ),
                            ],
                          ), */
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if(prop.panorama_image != null ) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return PanoramicView(prop.webView);
                                  }));
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("NO Data Found")));
                            }

                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Konstants.agu_glasses,
                                height: 70,
                              ),
                              h8,
                              Text(
                                "Photo View",
                                style: TextStyles.labelDark,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          /* Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    prop.listimage ?? Konstants.defaultHousePic,
                                fit: BoxFit.fill,
                                placeholder: (_, __) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                                errorWidget: (_, __, ___) => CachedNetworkImage(
                                  imageUrl: Konstants.defaultHousePic,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Text(
                                  "${Strings.threedWalk}",
                                  textAlign: TextAlign.center,
                                  style: TextStyles.heading6.copyWith(
                                    color: ColorUtils.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                         */
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _handle3DWalkThroughClick(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Konstants.vr_glasses,
                                height: 70,
                              ),
                              h8,
                              Text(
                                Strings.virtualRealityTour,
                                style: TextStyles.labelDark,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          /* Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    prop.listimage ?? Konstants.defaultHousePic,
                                fit: BoxFit.fill,
                                placeholder: (_, __) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                                errorWidget: (_, __, ___) => CachedNetworkImage(
                                  imageUrl: Konstants.defaultHousePic,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Text(
                                  "${Strings.threedWalk}",
                                  textAlign: TextAlign.center,
                                  style: TextStyles.heading6.copyWith(
                                    color: ColorUtils.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                         */
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      /*Expanded(
                        child: InkWell(
                          onTap: () {
                            showCustomDialog(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Konstants.defaultVedioCall,
                                height: 70,
                              ),
                              h8,
                              Text(
                                "VR Video Call",
                                style: TextStyles.labelDark,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ), *//* Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    prop.listimage ?? Konstants.defaultHousePic,
                                fit: BoxFit.fill,
                                placeholder: (_, __) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                                errorWidget: (_, __, ___) => CachedNetworkImage(
                                  imageUrl: Konstants.defaultHousePic,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Text(
                                  "${Strings.threedWalk}",
                                  textAlign: TextAlign.center,
                                  style: TextStyles.heading6.copyWith(
                                    color: ColorUtils.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                         *//*
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),*/

                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  Strings.description,
                  style: TextStyles.labelHeadingStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${prop.description}",
                  style: TextStyles.body1,
                ),
                h8,
                prop.content != null ?Html(
                  data: "${prop.content}",
                ):SizedBox(),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  Strings.location,
                  style: TextStyles.labelHeadingStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${prop.location}",
                  style: TextStyles.body1,
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 200,
                  child: GoogleMap(
                    onMapCreated: (controller) {
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
                      setState(() {});
                    },
                    markers: _markers.values.toSet(),
                    initialCameraPosition: CameraPosition(
                      zoom: 15,
                      target: LatLng(
                        double.parse(prop.latitude.toString()),
                        double.parse(
                          prop.longitude.toString(),
                        ),
                      ),
                    ),
                  ),
                ),
                h16,
                Text(
                  Strings.howToTour,
                  style: TextStyles.heading3,
                ),
                h16,
                Row(
                  children: [
                    CustomOutlinedButton(
                      onTap: () {
                        _handleTourInPersonClick(
                          context,
                        );
                      },
                      icon: Icons.home,
                      text: Strings.tourInPerson,
                    ),
                    w16,
                    Expanded(
                      child: CustomOutlinedButton(
                        onTap: () {
                          _handleTourVideoChatClick(
                            context,
                          );
                        },
                        icon: Icons.home,
                        text: Strings.tourViaVideoChat,
                      ),
                    ),
                  ],
                ),
                h16,
                Text(
                  Strings.moreInformation,
                  style: TextStyles.labelHeadingStyle,
                ),
                h8,
                ExpansionTile(
                  title: Text(Strings.features),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 32),
                  children: prop.propertyFeatures
                          ?.map<Widget>((e) => Row(
                                children: [
                                  Text(
                                    e?.featureName ?? "",
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ))
                          .toList() ??
                      [],
                ),
                ExpansionTile(
                  expandedAlignment: Alignment.centerLeft,
                  title: Text(Strings.aminities),
                  childrenPadding: EdgeInsets.symmetric(horizontal: 32),
                  children: prop.propertyAminities
                          ?.map<Widget>((e) => Row(
                                children: [
                                  Text(
                                    e?.aminityName ?? "",
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ))
                          .toList() ??
                      [],
                ),
                /*   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Strings.desclaimer),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                */ /*  hCustom(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomFillButton(
                      onTapFunction: () {
                        _handleCallButton(context);
                      },
                      height: 48,
                      childText: Strings.call,
                      icon: Icons.call,
                    )
                  ],
                ),
                */
                hCustom(64),
              ],
            ),
          ),


        ],
      ),
        ));
  }

  void _handleCallButton(BuildContext context) async {}

  void _handlePhotosClick(BuildContext context) async {
    prop.images?.replaceAll("[", "");
    prop.images?.replaceAll("]", "");
    final List<String> list = prop.image?.map<String>((e) => e!).toList() ?? [];
    // final list = Konstants.defaultImagesList;
    ImageViewer.showImageSlider(
      images: list,
      startingPosition: 1,
    );
  }

  void _handle3DWalkThroughClick(BuildContext context) {
    if(prop.images_vr != null || prop.video_vr != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return InitialPage(prop.images_vr ?? [], prop.video_vr ?? "");
      }));
    }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("NO Data Found")));
      }
  }

  void _handleStreetView(BuildContext context) async {
    Navigator.of(context).pushNamed(Routes.streetView, arguments: prop);
    // toast("Work in progress");
    // await showDialog(
    //     context: context,
    //     builder: (_) {
    //       return AlertDialog(
    //         content: Container(
    //           width: MediaQuery.of(context).size.width / 1.2,
    //           height: MediaQuery.of(context).size.height / 1.2,
    //           child: street.,
    //         ),
    //       );
    //     });
  }


  void _handle3DImage(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return ImageAssests_HomePage(prop.modal_assets);
    }));
    // toast("Work in progress");
    // await showDialog(
    //     context: context,
    //     builder: (_) {
    //       return AlertDialog(
    //         content: Container(
    //           width: MediaQuery.of(context).size.width / 1.2,
    //           height: MediaQuery.of(context).size.height / 1.2,
    //           child: street.,
    //         ),
    //       );
    //     });
  }

  void _handleTourInPersonClick(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.createTourRequest,
        arguments: {"prop": prop, "index": 0});
  }

  void _handleTourVideoChatClick(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.createTourRequest,
        arguments: {"prop": prop, "index": 1});
  }

  void showCustomDialog(BuildContext buildContext) {
    showGeneralDialog(
      context: buildContext,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
            child : Card(
              margin: EdgeInsets.symmetric(horizontal: 25),
              shape:
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadowColor: Colors.blueAccent,
              child: Container(
                height: 150,
                padding: EdgeInsets.all(10),
                child : Column(
                  children: [
                    Center(
                      child :Container(
                        margin: EdgeInsets.only(top: 15,bottom: 25),
                        child :  Text("Phone Not Supported", style: TextStyles.heading3),
                      )
            ),


                      Align(
                        alignment: Alignment.centerRight,
                        child : Container(
                          child :  TextButton(
                            child : Text("Ok".toUpperCase(),style: TextStyles.heading1,),
                            onPressed: () {
                              Navigator.pop(context);
                            },),
                        )
                      ),
                  ],
                )
              ),
            )
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
