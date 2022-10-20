import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:google_place/google_place.dart';
import 'package:http/http.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/enums.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_outlined_button.dart';
import 'package:sellthedwell/widgets/custom_search_map.dart';
import 'package:sellthedwell/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:video_player/video_player.dart';

class AddNewPropertyScreen extends StatefulWidget {
  final PropertyModel? propertyModel;
  const AddNewPropertyScreen({Key? key, this.propertyModel}) : super(key: key);

  @override
  State<AddNewPropertyScreen> createState() => _AddNewPropertyScreenState();
}
final TextEditingController _aminitiesIdController = TextEditingController();
class _AddNewPropertyScreenState extends State<AddNewPropertyScreen> {
  final TextEditingController _propNameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _featureController = TextEditingController();
  final TextEditingController _aminitiesController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _bedRoomController = TextEditingController();
  final TextEditingController _bathRoomController = TextEditingController();
  final TextEditingController _sqftController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _activeDatesController = TextEditingController();
  final TextEditingController _activeStartDateController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _activeStartDate = DateTime.now();
  String selectedPropCat = Strings.resedential;
  final List<DateTime> activeDates = [];
  SearchResult? _selectedPlace;

  List<XFile> selectedImages = [];
  List<XFile> selectedVRImages = [];
  List<XFile> selectedVideos = [];
  List<XFile> selectedVRVideos = [];
  FilePickerResult? selected3DFiles;
  VideoPlayerController? _controller;
  VideoPlayerController? _VRcontroller;
  String path = "";

  late PropertyModel? prop;
  bool editMode = false;
  String _locationLat = "";
  String _locationLng = "";

  List<String> activeDateList = ["12-03-2022","11-04-2023","11-21-2022"];
  List imageVRList = [
  ];
  List<String> imageList = [
    "https://sellthedwell.com/public/storage/rn4.jpg",
    "https://sellthedwell.com/public/storage/rn3.jpg",
    "https://sellthedwell.com/public/storage/rn2.jpg",
    "https://sellthedwell.com/public/storage/rn1.jpg"
  ];

  List property_aminitiesList = [];

  // final HtmlEditorController htmlController = HtmlEditorController();
  // final q.QuillController quillController = q.QuillController.basic();

  @override
  void initState() {
    prop = widget.propertyModel;
    _activeStartDateController.text =
        getStringFromDateinMMDDYYYY(_activeStartDate);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (prop != null) {
        setState(() {
          editMode = true;
        });
        _populateValues();
      }
    });
    super.initState();
  }

  _populateValues() async {
    _aboutController.text = prop?.description ?? "";
    _propNameController.text = prop?.name ?? "";
    selectedPropCat = prop?.categoryName ?? "";
    _typeController.text = prop?.type ?? "";
    _featureController.text =
        (prop?.propertyFeatures?.map((e) => e!.featureName ?? "").toList() ??
                [])
            .join(",");
    _aminitiesController.text =
        (prop?.propertyAminities?.map((e) => e!.aminityName ?? "").toList() ??
                [])
            .join(",");
    _bedRoomController.text = prop?.numberBedroom?.toString() ?? "";
    _bathRoomController.text = prop?.numberBathroom?.toString() ?? "";
    _sqftController.text = prop?.square.toString() ?? "";
    _priceController.text = prop?.price.toString() ?? "";
    _activeStartDateController.text = prop?.activeStartDate.toString() ?? "";
    _locationController.text = prop?.location ?? "";
    _locationLat = prop?.latitude ?? "";
    _locationLng = prop?.longitude ?? "";
    _activeStartDate =
        getDateFromStringInMMDDYYYY(prop?.activeStartDate?.toString() ?? "");
    path = prop?.modal_assets.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(context: context),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.addListing,
                  style: TextStyles.bigTitle,
                ),
                h16,
                CustomTextFieldWidget(
                  controller: _propNameController,
                  labelText: Strings.propName,
                  isRequired: true,
                ),
                h16,
                Visibility(
                  visible: selectedImages.isNotEmpty,
                  child: Text(
                    "Selected images",
                    style: TextStyles.heading6,
                  ),
                ),
                Wrap(
                  children: editMode
                      ? [
                          CachedNetworkImage(
                            imageUrl: prop?.listimage ?? "",
                            height: 100,
                            width: 100,
                            placeholder: (_, __) => const Center(
                                child: CircularProgressIndicator.adaptive()),
                            errorWidget: (_, __, ___) {
                              return Image.asset(Konstants.defaultHousePic);
                            },
                          )
                        ]
                      : selectedImages
                          .map<Widget>(
                            (e) => Container(
                              height: 100,
                              width: 100,
                              child: Image.file(
                                File(e.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .toList(),
                ),
                h16,
                Visibility(
                  visible: selectedVideos.isNotEmpty && _controller != null,
                  child: Text(
                    "Selected Video",
                    style: TextStyles.heading3,
                  ),
                ),
                _controller == null
                    ? SizedBox.shrink()
                    : Wrap(
                        children: selectedImages
                            .map<Widget>(
                              (e) => Container(
                                height: 100,
                                width: 100,
                                child: VideoPlayer(_controller!),
                              ),
                            )
                            .toList(),
                      ),
                h16,
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        text: Strings.addImage,
                        icon: Icons.photo,
                        onTap: () {
                          _handleAddImageClick(context);
                        },
                      ),
                    ),
                    w16,
                    Expanded(
                      child: CustomOutlinedButton(
                        text: Strings.addVideo,
                        icon: Icons.videocam,
                        onTap: () {
                          _handleAddVideoClick(context);
                        },
                      ),
                    ),
                  ],
                ),
                h16,
                Visibility(
                  visible: selectedImages.isNotEmpty,
                  child: Text(
                    "Selected VR images",
                    style: TextStyles.heading6,
                  ),
                ),
                Wrap(
                  children: editMode
                      ? [
                    CachedNetworkImage(
                      imageUrl: prop?.listimage ?? "",
                      height: 100,
                      width: 100,
                      placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator.adaptive()),
                      errorWidget: (_, __, ___) {
                        return Image.asset(Konstants.defaultHousePic);
                      },
                    )
                  ]
                      : selectedVRImages
                      .map<Widget>(
                        (e) => Container(
                      height: 100,
                      width: 100,
                      child: Image.file(
                        File(e.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      .toList(),
                ),
                h16,
                Visibility(
                  visible: selectedVRVideos.isNotEmpty && _VRcontroller != null,
                  child: Text(
                    "Selected VR Video",
                    style: TextStyles.heading3,
                  ),
                ),
                _VRcontroller == null
                    ? SizedBox.shrink()
                    : Wrap(
                  children: selectedVRImages
                      .map<Widget>(
                        (e) => Container(
                      height: 100,
                      width: 100,
                      child: VideoPlayer(_controller!),
                    ),
                  )
                      .toList(),
                ),
                h16,
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        text: "Add VR Images",
                        icon: Icons.photo,
                        onTap: () {
                          _handleAddVRImageClick(context);
                        },
                      ),
                    ),
                    w16,
                    Expanded(
                      child: CustomOutlinedButton(
                        text: "Add VR Video",
                        icon: Icons.videocam,
                        onTap: () {
                          _handleAddVRVideoClick(context);
                        },
                      ),
                    ),
                  ],
                ),
                h16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomOutlinedButton(
                      text: "Add 3D File",
                      icon: Icons.file_copy_rounded,
                      onTap: () {
                          _handleAddMODALASSETSClick(context);
                      },
                    ),
                    SizedBox(width: 10,),
                    path != ""?
                    Text(path.split('/').last,maxLines:2,style: TextStyle(color: Colors.black,overflow: TextOverflow.fade),)
                        :SizedBox(),
                  ],
                ),
                h16,
                StatefulBuilder(
                  builder: (_, localState) {
                    return Row(
                      children: propCategories
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
                                    style: TextStyles.heading7.copyWith(
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
                    );
                  },
                ),
                h16,
                CustomTextFieldWidget(
                  controller: _typeController,
                  labelText: Strings.type,
                  isRequired: true,
                  readOnly: true,
                  onTap: () {
                    _handleTypeClick(context);
                  },
                ),
                h16,
                CustomTextFieldWidget(
                  controller: _featureController,
                  labelText: Strings.feature,
                  isRequired: true,
                  readOnly: true,
                  onTap: () {
                    _handleFeaturesClick(context);
                  },
                ),
                h16,
                CustomTextFieldWidget(
                  controller: _aminitiesController,
                  labelText: Strings.aminities,
                  isRequired: true,
                  readOnly: true,
                  onTap: () {
                    _handleAminitiesClick(context);
                  },
                ),
                h16,
                Text(Strings.description),
                /*    Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: EdgeInsets.all(8),
                  child: q.QuillToolbar.basic(controller: quillController),
                ),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300)),
                  height: 400,
                  padding: EdgeInsets.all(8),
                  child: q.QuillEditor.basic(
                    controller: quillController,
                    readOnly: false, // true for view only mode
                  ),
                ),
                */ // HtmlEditor(
                //   callbacks: Callbacks(),
                //   controller: htmlController,
                //   otherOptions: OtherOptions(height: 400),
                //   htmlEditorOptions: HtmlEditorOptions(
                //       hint: Strings.description,
                //       shouldEnsureVisible: true,
                //       darkMode: false),
                // ),
                h16,
                CustomTextFieldWidget(
                  controller: _aboutController,
                  labelText: Strings.aboutOpenHouse,
                  isRequired: true,
                  minLines: 5,
                  maxLines: 7,
                ),
                h16,
                CustomTextFieldWidget(
                  controller: _locationController,
                  labelText: Strings.location,
                  isRequired: true,
                  readOnly: true,
                  onTap: () {
                    _handleLocationClick(context);
                  },
                ),
                h16,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWidget(
                        controller: _bedRoomController,
                        labelText: Strings.noBedroom,
                        isRequired: true,
                        readOnly: true,
                        onTap: () {
                          _handleBedroomClick(context);
                        },
                      ),
                    ),
                    w16,
                    Expanded(
                      child: CustomTextFieldWidget(
                        controller: _bathRoomController,
                        labelText: Strings.noBathroom,
                        isRequired: true,
                        readOnly: true,
                        onTap: () {
                          _handleBathroomClick(context);
                        },
                      ),
                    ),
                  ],
                ),
                h16,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWidget(
                        controller: _sqftController,
                        labelText: Strings.squareFeet,
                        isRequired: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    w16,
                    Expanded(
                      child: CustomTextFieldWidget(
                        controller: _priceController,
                        labelText: Strings.price,
                        isRequired: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                h16,
                CustomTextFieldWidget(
                  controller: _activeStartDateController,
                  labelText: Strings.activeStartDate,
                  isRequired: true,
                  onTap: () {
                    _handleActiveStartDate(context);
                  },
                  readOnly: true,
                ),
                h16,
                CustomTextFieldWidget(
                  controller: _activeDatesController,
                  labelText: Strings.chooseActiveDate,
                  isRequired: true,
                  readOnly: true,
                ),
                SfDateRangePicker(
                  enablePastDates: false,
                  selectionMode: DateRangePickerSelectionMode.multiple,
                  initialSelectedDates: activeDates,
                  minDate: _activeStartDate,
                  maxDate: _activeStartDate.add(const Duration(days: 6)),
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    activeDates.clear();
                    activeDates.addAll(args.value);
                    for(int i = 0;i < activeDates.length; i++){
                      activeDateList.add(getStringFromDateinYYYYMMDD(activeDates[i]));
                    }
                    final List<String> list = activeDates
                        .map((e) => getStringFromDateinDDMMYYYY(e))
                        .toList();
                    _activeDatesController.text = list.join(",");
                    setState(() {});
                  },
                ),
                h16,
                Row(
                  children: [
                    Expanded(
                      child: CustomFillButton(
                        onTapFunction: () {
                          _handleSaveProperty(context);
                        },
                        childText: Strings.saveProperty,
                      ),
                    ),
                  ],
                ),
                h16,
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleTypeClick(BuildContext context) async {
    final result = await CommonMethods.showListDialogMultiSelect(
      context: context,
      title: Strings.type,
      list: propType,
      selectedValues:
          _typeController.text.isEmpty ? [] : _typeController.text.split(","),
    );
    _typeController.text = result;
  }

  _handleFeaturesClick(BuildContext context) async {
    selectedFeature = [];
    final result = await CommonMethods.showListFeatureMultiSelect(
      context: context,
      title: Strings.feature,
      list: features,
      selectedValues: _featureController.text.isEmpty
          ? []
          : _featureController.text.split(","),
    );
    _featureController.text = result;
  }

  _handleAminitiesClick(BuildContext context) async {
    selectedAminities = [];
    final result = await CommonMethods.showListAminitiesMultiSelect(
      context: context,
      title: Strings.aminities,
      list: aminities,
      selectedValues: _aminitiesController.text.isEmpty
          ? []
          :_aminitiesController.text.split(","),
    );
    _aminitiesController.text = result;
  }

  _handleBedroomClick(BuildContext context) async {
    final result = await CommonMethods.showListDialogSingleSelect(
      context: context,
      title: Strings.noBedroom,
      list: noOfBed,
      selectedValue: _bedRoomController.text,
    );
    _bedRoomController.text = result;
  }

  _handleBathroomClick(BuildContext context) async {
    final result = await CommonMethods.showListDialogSingleSelect(
      context: context,
      title: Strings.noBathroom,
      list: noOfBath,
      selectedValue: _bathRoomController.text,
    );
    _bathRoomController.text = result;
  }

  _handleLocationClick(BuildContext context) async {
    final GooglePlace googlePlace = GooglePlace(Konstants.mapAPIKey);
    final SearchResult result = await showSearch(
        context: context, delegate: CustomLocationSearch(googlePlace));
    _locationController.text = result.name ?? "";
    _selectedPlace = result;
  }

  _handleActiveStartDate(BuildContext context) async {
    if (_activeStartDate.isBefore(DateTime.now())) {
      _activeStartDate = DateTime.now();
    }

    final selected = await showDatePicker(
        context: context,
        initialDate: _activeStartDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (selected != null) {
      _activeStartDate = selected;
      _activeStartDateController.text = getStringFromDateinMMDDYYYY(selected);
      setState(() {});
    }
  }

  static getHeaders2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
      "Content-Type": "multipart/form-data",
    };
  }


/*  void saveProperty(BuildContext dialogContext) async{

    CommonMethods.showLoading(dialogContext);

    var data ={

    };

    try{
      Response response = await post(
        Uri.parse('${Konstants.baseUrl}/users/property/save'),
        body: jsonEncode({
        'title': '${_propNameController.text.toString()}',
        'content': '${_propNameController.text.toString()}',
        'build_year': '2022',
        'Parking' : '',
        'location': '${_locationController.text.toString()}',
        'latitude': editMode ? _locationLat : '${_selectedPlace?.geometry?.location?.lat.toString()}',
        'longitude': editMode ? _locationLng : '${_selectedPlace?.geometry?.location?.lng.toString()}',
        'images' : "",
        'video_type' : 0,
        'video_link' : "",
        'project_id' : 0,
        'number_bedroom': '${_bedRoomController.text.toString()}',
        'number_bathroom': '${_bathRoomController.text.toString()}',
        'number_floor': 0,
        'square': '${_sqftController.text.toString()}',
        'lot_size': "",
        'price': _priceController.text.toString(),
        'price_unit': "",
        'type': '$selectedPropCat',
        'active_dates' : activeDateList,
        // 'description': '${await htmlController.getText()}',
        'category_name' : "Rentals",
        'category_id': 15,
        "status": "selling",
        "period": "month",
        "view_type": "Houseing",
        "author_id": 37,
        "author_type": "Botble\\ACL\\Models\\User",
        "category_id": 15,
        "moderation_status": "approved",
        "expire_date": "2023-01-06",
        'city_name' : "",
        'favorite' : 1,
        'property_aminities' :  property_aminitiesList,
        'property_features' : property_aminitiesList,
        'description': '${_aboutController.text}',
        'monthly_mortage': 'monthly',
        'local_legal_protections': 'legal',
        'property_taxes_and_assessments': 'assesment',
        'price_history': 'price',
        'public_records': 'records',
        'pet': 'Any',
        'city_id': '5',
        'active_start_date': *//*'${getStringFromDateinMMDDYYYY(_activeStartDate)}'*//*"2023-01-06",
        'aminities': '${_aminitiesController.text.toString()}',
        'features': '${_featureController.text.toString()}',
        'video_vr' : "https://sellthedwell.com/public/storage/16623723598241.mp4",
          'images_vr' : imageVRList,
            'image' : imageList,
            'modal_assets' : "",
            'panorama_image' : "",}),
      );
      if(response.statusCode == 200){
        var  data = jsonDecode(response.body.toString());
        CommonMethods.dismissLoading(context);
        toast("SuccessFully saved");
      }else{
        CommonMethods.dismissLoading(context);
        print("failed");
        toast("failed");
      }

    }catch(e){
      CommonMethods.dismissLoading(context);
      toast("failled");
      print(e.toString());
    }

  }*/

  _handleSaveProperty(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // if ((await htmlController.getText()).isEmpty) {
      //   toast("Enter description");
      // }


      var data ={
          'title': '${_propNameController.text}',
          'content': '${_propNameController.text}',
          'build_year': '2010-06-07',
          'location': '${_locationController.text}',
          'latitude': editMode ? _locationLat : '${_selectedPlace?.geometry?.location?.lat}',
          'longitude': editMode ? _locationLng : '${_selectedPlace?.geometry?.location?.lng}',
          'number_bedroom': '${_bedRoomController.text}',
          'number_bathroom': '${_bathRoomController.text}',
          'square': '${_sqftController.text}',
          'price': '${_priceController.text}',
          'category_id' : '$selectedPropCat',
          'type': '${_typeController.text}',
          // 'description': '${await htmlController.getText()}',
          'description': '${_aboutController.text}',
          'monthly_mortage': 'monthly',
          'local_legal_protections': 'legal',
          'property_taxes_and_assessments': 'assesment',
          'price_history': 'price',
          'public_records': 'records',
          'pet': 'Any',
          'city_id': '5',
          'active_start_date': '${getStringFromDateinMMDDYYYY(_activeStartDate)}',
          'aminities': '${selectedAminities}',
          'features': '${selectedFeature}',
          'id' : prop?.id.toString() ?? "",
      };
      print("Hello data");
      print(data);


    //  saveProperty(context);

      try {
        CommonMethods.showLoading(context);
        final result = await NetworkService.addProperty(
          data,
          activeDateList,
          selectedImages,
          selectedVideos,
          selectedVRImages,
          selectedVRVideos,
          path,
          edit: editMode,
          id: prop?.id,
        );
        print(result);
        if (result) {
          toast("Saved Successfully");
          Navigator.of(context).pop();/*
          print(result);
          CommonMethods.dismissLoading(context);*/
        }
      } catch (e) {
        log(e.toString());
      } finally {
        CommonMethods.dismissLoading(context);
      }
    }
  }

  _handleAddImageClick(BuildContext context) async {
    final imagepicker = await ImagePicker().pickMultiImage();
    selectedImages.addAll(imagepicker ?? []);
    setState(() {});
  }

  _handleAddVideoClick(BuildContext context) async {
    final picker = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picker == null) {
      return;
    }

    _controller = VideoPlayerController.file(File(picker.path))
      ..initialize().then((_) {
        setState(() {});
      });
    selectedVideos.add(picker);
    setState(() {});
  }

  _handleAddVRImageClick(BuildContext context) async {
    final imagepicker = await ImagePicker().pickMultiImage();
    selectedVRImages.addAll(imagepicker ?? []);
    setState(() {});
  }

  _handleAddVRVideoClick(BuildContext context) async {
    final picker = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picker == null) {
      return;
    }

    _VRcontroller = VideoPlayerController.file(File(picker.path))
      ..initialize().then((_) {
        setState(() {});
      });
    selectedVRVideos.add(picker);
    setState(() {});
  }

  _handleAddMODALASSETSClick(BuildContext context) async {
   FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      path = result.files.single.path.toString();
      if(true) {
        setState(() {
        selected3DFiles = result;
      return;});

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select .glb File")));
      }
    } else {
      // User canceled the picker
    }

  }


}
