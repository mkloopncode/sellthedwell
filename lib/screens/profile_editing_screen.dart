
import 'dart:typed_data';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_textfield.dart';
import 'package:sellthedwell/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditingScreen extends StatefulWidget {
  final String? profileImage;
  const ProfileEditingScreen({Key? key, this.profileImage}) : super(key: key);

  @override
  State<ProfileEditingScreen> createState() => _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends State<ProfileEditingScreen> {
  final TextEditingController _fullNamecontroller = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  late BuildContext _context;
  String? profilePic;

  final _formKey = GlobalKey<FormState>();
  XFile? _image ;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadValues();
    });
    super.initState();
  }

  loadValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = Provider.of<AuthProvider>(_context, listen: false);
    final result = await NetworkService.login(
      email: prefs.getString(Konstants.keyEmail) ?? "",
      password: prefs.getString(Konstants.keyPassword) ?? "",
    );
    auth.setLoginResponse(result);
    if (auth.loginResponse == null) {
      return;
    }
    final user = await auth.loginResponse;
    _addressController.text = user?.address ?? "";
    _cityController.text = user?.city ?? "";
    _countryController.text = user?.country ?? "";
    _emailController.text = user?.email ?? "";
    _fullNamecontroller.text = user?.name ?? "";
    _mobileNoController.text = user?.phone ?? "";
    _stateController.text = user?.state ?? "";
    profilePic = widget.profileImage ?? "";


  }

  void _handleProfilePic(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (pickedFile != null) {
      _image = pickedFile;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar2(context: context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.editProfile,
                style: TextStyles.bigTitle,
              ),
              // profile section
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: ColorUtils.blueColor,
                ),
                child: Column(
                  children: [
                    _image != null ?CircleAvatar(
                          child: ClipOval(
                            child: Image.file(
                              File(_image!.path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                      radius: 48,
                        ) : widget.profileImage != null ?
                    CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          widget.profileImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      radius: 48,
                    ) :CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-Images.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      radius: 48,
                    ),
                    h16,
                    Text(
                      "${auth.loginResponse?.name}",
                      style: TextStyles.heading2.copyWith(
                        color: ColorUtils.white,
                      ),
                    ),
                    h16,
                    CustomFillButton(
                      onTapFunction: () {
                        _handleProfilePic(context);
                      },
                      childText: Strings.choosePhoto,
                      icon: Icons.picture_in_picture,
                    ),
                  ],
                ),
              ),
              // userinfo
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h16,
                    Text(
                      Strings.userinfo,
                      style: TextStyles.heading3,
                    ),
                    h16,
                    CustomTextFieldWidget(
                        controller: _fullNamecontroller,
                        labelText: Strings.fullName,
                        isRequired: true),
                    h8,
                    CustomTextFieldWidget(
                        controller: _mobileNoController,
                        labelText: Strings.mobileNo,
                        isRequired: true),
                    h8,
                    CustomTextFieldWidget(
                        controller: _emailController,
                        labelText: Strings.email,
                        isRequired: true),
                    h8,
                    CustomTextFieldWidget(
                        controller: _addressController,
                        labelText: Strings.address,
                        isRequired: true),
                    h8,
                    CustomTextFieldWidget(
                        controller: _cityController,
                        labelText: Strings.city,
                        isRequired: true),
                    h8,
                    CustomTextFieldWidget(
                        controller: _stateController,
                        labelText: Strings.state,
                        isRequired: true),
                    h8,
                    CustomTextFieldWidget(
                        controller: _countryController,
                        labelText: Strings.country,
                        isRequired: true),
                    h16,
                    Row(
                      children: [
                        Expanded(
                          child: CustomFillButton(
                            onTapFunction: () {
                              _handleUpdateButton(context);
                            },
                            childText: Strings.update,
                          ),
                        ),
                      ],
                    ),
                    h16,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleUpdateButton(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
       var res =  await NetworkService.updateProfile(
          name: _fullNamecontroller.text,
          mobile: _mobileNoController.text,
          email: _emailController.text,
          address: _addressController.text,
          city: _cityController.text,
          state: _stateController.text,
          country: _countryController.text,
         profilePic: _image!,
        );
        if (res['status']) {
          Navigator.of(context).pop();
        }
        else{
        toast("Profile update failed!");
        }
      } catch (e) {
        toast(e.toString());
      }
    }
    print("123");
    return;
  }
}
