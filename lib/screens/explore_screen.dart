import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/screens/explore_map_scren.dart';
import 'package:sellthedwell/screens/main_screen.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/enums.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/custom_outlined_button.dart';
import 'package:sellthedwell/widgets/drawer.dart';
import 'package:sellthedwell/widgets/property_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../widgets/custom_button_filled.dart';
import '../widgets/custom_textfield.dart';

import '../chat/ChatDetailPage.dart';
import '../widgets/custom_button_filled.dart';
import '../widgets/custom_textfield.dart';
import 'FlagScreen.dart';

class ExploreScreen extends StatefulWidget {
  final void Function()? onFilter;
  const ExploreScreen({
    Key? key,
    this.onFilter,
  }) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final  List<PropertyModel> propsList = [];
  final List<PropertyModel> propsListOriginal = [];
  late BuildContext _context;
  bool loading = false;
  String uId = "";
  bool isVisibleChat = true;

  final TextEditingController _flagContorller = TextEditingController();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getPropertyList();
      _getFeatureList();
      _getAminitiesList();
    });

    SharedPreferences.getInstance().then((prefValue) => {
      setState(() {
        uId = prefValue.getString("uid")!;
      })
    });

    super.initState();
  }

  /*_getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = int.parse(prefs.getString(Konstants.uId)!);
    print(uId.toString()+"this is sara uid");
  }*/

  @override
  Widget build(BuildContext context) {
    _context = context;
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
      body: RefreshIndicator(
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: Consumer<AuthProvider>(
          builder: (_, auth, ___) {
            final List<PropertyModel> list = _getPropsList(auth.selectedCategory);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.explore,
                    style: TextStyles.bigTitle,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${list.length} ${Strings.properties}",
                        ), // in '${auth.selectedCategory}'"),
                      ),
                      Visibility(
                        visible: auth.selectedCategory != 'All',
                        child: CustomOutlinedButton(
                          text: Strings.clear,
                          onTap: () {
                            auth.setCategory('All');
                          },
                          icon: Icons.clear,
                        ),
                      ),
                    ],
                  ),
                  h8,
                  Expanded(
                    child: loading
                        ? const Center(child: CircularProgressWidget())
                        : list.isEmpty
                            ? Center(
                                child: Text(Strings.noData),
                              )
                            : auth.showMapInExplore
                                ? ExloreMapScreen(
                                    propsList: list,
                                  )
                                : ListView.separated(
                                    itemBuilder: (_, i) {
                                      return PropertyItem(
                                        prop: list[i],
                                        getUid: uId,
                                        onChatClick : (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return ChatDetailPage(list[i].authorId.toString(),"","");
                                          }));
                                      },

                                        onFlagClick: (){
                                          return addFlag(context,propsList[i].id.toString());
                                        },
                                        onFavourite: () async {
                                          await CommonMethods.toggleFavourite(
                                              context, list[i]);
                                          _getPropertyList();
                                        },
                                        onTap: () async {
                                          await Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamed(
                                            Routes.detailsScreen,
                                            arguments: list[i],
                                          );
                                          _getPropertyList();
                                        },
                                      );
                                    },
                                    separatorBuilder: (_, __) => const Divider(),
                                    itemCount: list.length,
                                    shrinkWrap: true,
                                  ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  _getPropertyList() async {
    try {
      setState(() {
        loading = true;
      });
      final list = await NetworkService.getAllProperties();
      print(list);
      propsList.clear();
      propsListOriginal.clear();
      propsList.addAll(list);
      propsListOriginal.addAll(list);
      final auth = Provider.of<AuthProvider>(_context, listen: false);
      auth.addProperties(propsList);
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

  _getFeatureList() async {
    try {
      setState(() {
        loading = true;
      });
      final list = await NetworkService.getAllFeature();

      propsList.clear();
      features.addAll(list);
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

  _getAminitiesList() async {
    try {
      setState(() {
        loading = true;
      });
      final list = await NetworkService.getAllAminities();

      propsList.clear();
      aminities.addAll(list);
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

  _getPropsList(String selectedCategory) {
    if (selectedCategory == "All" || selectedCategory.isEmpty) {
      return propsList;
    }
    final List<PropertyModel> list = [];
    for (var element in propsList) {
      if (element.categoryName == selectedCategory) {
        list.add(element);
      }
    }
    return list;
  }

  void _handleFilterClick(BuildContext context) async {
    final Map<String, String> result = await Navigator.of(context)
        .pushNamed(Routes.filterScreen) as Map<String, String>;
    log("Result: $result");
    if (result != null) {
      final List<PropertyModel> list =
          CommonMethods.getFilteredResults(propsListOriginal, result);
      propsList.clear();
      propsList.addAll(list);
      setState(() {});
    }
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
              margin: EdgeInsets.symmetric(horizontal: 20),
              shape:
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadowColor: Colors.blueAccent,
              child: Container(
                height: 200,
                padding: EdgeInsets.all(25),
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child :  CustomTextFieldWidget(
                        controller: _flagContorller,
                        labelText: "Please enter message",
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                      child :  Row(
                        children: [
                          Expanded(
                            child: CustomFillButton(
                                onTapFunction: () {
                                  if(_flagContorller.text.toString().trim().length == 0){
                                    toast("Please enter message");
                                  }else{
                                  }
                                },
                                childText: "Submit"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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


  void addFlag(BuildContext buildContext, String propId) async{

    CommonMethods.showLoading(buildContext);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{

      var response = await post(
        Uri.parse(Konstants.baseUrl+"/add_to_flga"),
        body: {
          "property_id" : propId,
          "message" : "abc",
        },
        headers: await getHeaders(),
      );
      if(response.statusCode == 200){
        toast("Succesfully done");
        CommonMethods.dismissLoading(buildContext);

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _getPropertyList();
        });

      }else{
        print("failed");
      }

    }catch(e){
      print(e.toString());
    }
  }

  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }

}
