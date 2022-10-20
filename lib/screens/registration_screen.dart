import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_text_button.dart';
import 'package:sellthedwell/widgets/custom_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailContorller = TextEditingController();
  final TextEditingController _phoneContorller = TextEditingController();
  final TextEditingController _confirmContorller = TextEditingController();
  final TextEditingController _addressContorller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        Strings.welcomeuser,
                        style: TextStyles.heading1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        Strings.signuptocontinue,
                        style: TextStyles.body1,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextFieldWidget(
                        controller: _nameController,
                        labelText: Strings.name,
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFieldWidget(
                        controller: _emailContorller,
                        labelText: Strings.email,
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFieldWidget(
                        controller: _phoneContorller,
                        labelText: Strings.phone,
                        isRequired: true,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFieldWidget(
                        controller: _addressContorller,
                        labelText: Strings.address,
                        isRequired: true,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFieldWidget(
                        controller: _passwordController,
                        labelText: Strings.password,
                        isRequired: true,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFieldWidget(
                        controller: _confirmContorller,
                        labelText: Strings.confirmpassworrd,
                        isRequired: true,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _image == null
                                ? CustomFillButton(
                                    onTapFunction: () {
                                      _handleProfilePic(context);
                                    },
                                    childText: Strings.profilePic,
                                    icon: Icons.image,
                                    color: ColorUtils.black,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.memory(
                                        _image!,
                                        height: 80,
                                        width: 80,
                                      ),
                                      CustomFillButton(
                                        onTapFunction: () {
                                          _handleProfilePic(context);
                                        },
                                        childText: Strings.change,
                                        icon: Icons.image,
                                        color: ColorUtils.black,
                                      )
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomFillButton(
                                onTapFunction: () {
                                  _handleSignUp(context);
                                },
                                childText: Strings.signup),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Strings.byCliicking,
                              style: TextStyles.body1,
                            ),
                            TextSpan(
                              text: Strings.termsOfService,
                              style: TextStyles.body1.copyWith(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " and ",
                              style: TextStyles.body1,
                            ),
                            TextSpan(
                              text: Strings.policy,
                              style: TextStyles.body1.copyWith(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.haveanaccount,
                    style: TextStyles.heading4.copyWith(
                      color: ColorUtils.backgroundDark,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CustomTextButton(
                    onTap: () {
                      _handleSignIn(context);
                    },
                    text: Strings.signin,
                    color: ColorUtils.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: ColorUtils.backgroundGrey,
    );
  }

  void _handleSignUp(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
     /* if (_image == null || (_image?.isEmpty ?? false)) {
        toast("Please select image");
      }
      else{*/

      try {
        final auth = Provider.of<AuthProvider>(context, listen: false);
        CommonMethods.showLoading(context);
        final result = await NetworkService.register(
          name: _nameController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneContorller.text.trim(),
          address: _addressContorller.text.trim(),
          email: _emailContorller.text.trim(),
          devicetype: Platform.isAndroid ? Konstants.android : Konstants.ios,
        );
        auth.setLoginResponse(result);
        print("DONE");
        await auth.saveLocalLogin(
            email: _emailContorller.text.trim(),
            password: _passwordController.text.trim(),
            token: result['token'],
            id: result['user_data']['id'].toString(),
            package_name: result['user_data']['subscription'] != null ? result['user_data']['subscription']["package_name"] :
                '',
            name: result['user_data']['name']);
        print("D!");
        //CommonMethods.dismissLoading(context);
        CommonMethods.removeAllRoutesAndPushNamed(
            routeName: Routes.main, context: context);
      } catch (e) {
        CommonMethods.dismissLoading(context);
        CommonMethods.showAlertWithOkButton(
            context: context, message: e.toString());
      }
   // }

    }
  }

  void _handleSignIn(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }

  void _handleProfilePic(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (pickedFile != null) {
      _image = await pickedFile.readAsBytes();
      setState(() {});
    }
  }
}
