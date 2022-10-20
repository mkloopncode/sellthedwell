import 'package:flutter/material.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailContorller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      Strings.welcomeback,
                      style: TextStyles.heading1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      Strings.signintocontinue,
                      style: TextStyles.body1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFieldWidget(
                      controller: _emailContorller,
                      labelText: Strings.email,
                      isRequired: true,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFieldWidget(
                      controller: _passwordController,
                      labelText: Strings.password,
                      isRequired: true,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomFillButton(
                              onTapFunction: () {
                                _handleSignIn(context);
                              },
                              childText: Strings.signin),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextButton(
                      onTap: () {
                        _handleForgotPassword(context);
                      },
                      text: Strings.forgotPassword,
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
                  Strings.donthaveaccount,
                  style: TextStyles.heading4.copyWith(
                    color: ColorUtils.backgroundDark,
                  ),
                ),
                CustomTextButton(
                  onTap: () {
                    _handleSignUp(context);
                  },
                  text: Strings.signup,
                  color: ColorUtils.white,
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: ColorUtils.backgroundGrey,
    );
  }

  void _handleSignIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState?.validate() ?? false) {
      CommonMethods.showLoading(context);
      try {
        final result = await NetworkService.login(
          email: _emailContorller.text.trim(),
          password: _passwordController.text.trim(),
          devicetype: Konstants.android,
        );
        if (mounted) {
          final auth = Provider.of<AuthProvider>(context, listen: false);
          auth.setLoginResponse(result);
          await auth.saveLocalLogin(
            email: _emailContorller.text.trim(),
            password: _passwordController.text.trim(),
            token: result['token'],
            id: result['user_data']['id'].toString(),
            package_name: result['user_data']['subscription']["package_name"] ?? "",
            name: result['user_data']['name'],

          );
          await prefs.setString("name", result['user_data']['name']);
          await prefs.setString("address", result['user_data']['address']);
          await prefs.setString("country", result['user_data']['country']);
          await prefs.setString("phone", result['user_data']['phone']);
          await prefs.setString("state", result['user_data']['state']);
          await prefs.setString("postalCode", result['user_data']['zipcode']);
        }
        if (mounted) {
          CommonMethods.dismissLoading(context);
          CommonMethods.removeAllRoutesAndPushNamed(
              routeName: Routes.welcomeLocation, context: context);
        }
      } catch (e) {
        CommonMethods.dismissLoading(context);
        CommonMethods.showAlertWithOkButton(
            context: context, message: e.toString());
      }
    }
  }

  void _handleForgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.forgotpassword);
  }

  void _handleSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.registration);
  }
}
