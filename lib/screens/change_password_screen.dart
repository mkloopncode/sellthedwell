import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_textfield.dart';

import '../services/network_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        context: context,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.changePassword,
                style: TextStyles.bigTitle,
              ),
              h16,
              CustomTextFieldWidget(
                controller: _currentPassController,
                labelText: Strings.currentPassword,
                isRequired: true,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextFieldWidget(
                controller: _newPassController,
                labelText: Strings.newPassword,
                isRequired: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomFillButton(
                      onTapFunction: () {
                        _handleChangePassword(context);
                      },
                      childText: Strings.changePassword,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleChangePassword(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        var res =  await NetworkService.updatePassword(
          newPassword: _currentPassController.text,
          currentPassword:  _newPassController.text
        );
        if (res['status']) {
          Navigator.of(context).pop();
          toast(res['message']);
        }
        else{
          toast("Password update failed!");
        }
      } catch (e) {
        toast(e.toString());
      }
    }
    return ;
  }
}
