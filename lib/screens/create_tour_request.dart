import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/dimensions.dart';
import 'package:sellthedwell/utils/enums.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:sellthedwell/widgets/custom_textfield.dart';

class CreateTourRequest extends StatefulWidget {
  final int index;
  final PropertyModel model;
  const CreateTourRequest({
    Key? key,
    this.index = 0,
    required this.model,
  }) : super(key: key);

  @override
  State<CreateTourRequest> createState() => _CreateTourRequestState();
}

class _CreateTourRequestState extends State<CreateTourRequest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(context: context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.createRequest,
              style: TextStyles.bigTitle,
            ),
            h16,
            TabBar(
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? ColorUtils.blueColor
                          : Colors.transparent,
                    ),
                    constraints: BoxConstraints.expand(),
                    child: Text(
                      Strings.inperson,
                      style: TextStyle(
                        color: selectedIndex == 0
                            ? ColorUtils.white
                            : ColorUtils.blueColor,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? ColorUtils.blueColor
                          : Colors.transparent,
                    ),
                    constraints: BoxConstraints.expand(),
                    child: Text(
                      Strings.videoTour,
                      style: TextStyle(
                        color: selectedIndex == 1
                            ? ColorUtils.white
                            : ColorUtils.blueColor,
                      ),
                    ),
                  ),
                ),
              ],
              onTap: (v) {
                setState(() {
                  selectedIndex = v;
                });
              },
              controller: _tabController,
            ),
            h16,
            Expanded(
              child: TabBarView(
                children: [
                  InPersonRequestWidget(model: widget.model, type: "1"),
                  InPersonRequestWidget(model: widget.model, type: "2"),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InPersonRequestWidget extends StatefulWidget {
  final PropertyModel model;
  final String type;
  const InPersonRequestWidget(
      {Key? key, required this.model, required this.type})
      : super(key: key);

  @override
  State<InPersonRequestWidget> createState() => _InPersonRequestWidgetState();
}

class _InPersonRequestWidgetState extends State<InPersonRequestWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _visitDateController = TextEditingController();
  final TextEditingController _bestHourController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  DateTime visitDate = DateTime.now().add(Duration(days: 5));
  TimeOfDay time = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    _visitDateController.text = getStringFromDateinYYYYMMDD(visitDate);
    _bestHourController.text = getStringFromTimeinHHMM(time);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadValues();
    });

    super.initState();
  }

  loadValues() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (auth.loginResponse == null) {
      return;
    }
    final user = auth.loginResponse;
    _emailController.text = user?.email ?? "";
    _nameController.text = user?.name ?? "";
    _phoneController.text = user?.phone ?? "";
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFieldWidget(
              controller: _nameController,
              labelText: Strings.name,
              isRequired: true,
            ),
            h16,
            CustomTextFieldWidget(
              controller: _emailController,
              labelText: Strings.email,
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
            ),
            h16,
            CustomTextFieldWidget(
              controller: _phoneController,
              labelText: Strings.phone,
              isRequired: true,
              keyboardType: TextInputType.phone,
            ),
            h16,
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldWidget(
                    controller: _visitDateController,
                    labelText: Strings.visitDate,
                    isRequired: true,
                    readOnly: true,
                    onTap: () {
                      _handleOnTapDate(context);
                    },
                  ),
                ),
                w16,
                Expanded(
                  child: CustomTextFieldWidget(
                    controller: _bestHourController,
                    labelText: Strings.bestHour,
                    isRequired: true,
                    readOnly: true,
                    onTap: () {
                      _handleOnTapTime(context);
                    },
                  ),
                ),
              ],
            ),
            h16,
            CustomTextFieldWidget(
              controller: _messageController,
              labelText: Strings.message,
              isRequired: true,
            ),
            h16,
            Row(
              children: [
                Expanded(
                  child: CustomFillButton(
                    onTapFunction: () {
                      _handleRequestSubmit(context);
                    },
                    childText: Strings.requestButton,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _handleOnTapDate(BuildContext context) async {
    final result = await showDatePicker(
      context: context,
      initialDate: visitDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (result != null) {
      visitDate = result;
      _visitDateController.text = getStringFromDateinYYYYMMDD(visitDate);
    }
  }

  _handleOnTapTime(BuildContext context) async {
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result != null) {
      time = result;
      _bestHourController.text = getStringFromTimeinHHMM(time);
    }
  }

  void _handleRequestSubmit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      CommonMethods.hideKeyboard(context);
      CommonMethods.showLoading(context);
      try {
        final va = await NetworkService.crateRequest({
          'property_id': '${widget.model.id}',
          'type': widget.type,
          'message_send_by_name': _nameController.text.trim(),
          'message_send_by_email': _emailController.text.trim(),
          'message_send_by_phone': _phoneController.text.trim(),
          'message': _messageController.text.trim(),
          'meeting_date': _visitDateController.text..trim(),
          'meeting_time': _bestHourController.text.trim(),
          'author_id':
              '${Provider.of<AuthProvider>(context, listen: false).loginResponse?.id}',
        });
        if (va) {
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Thank you", style: TextStyles.heading5),
                        h16,
                        Text(
                            "Your request has for '${widget.model.name}' been sent!",
                            style: TextStyles.heading3),
                        h16,
                        Text(
                            "Your have requested a tour on ${_visitDateController.text} at ${_bestHourController.text}",
                            style: TextStyles.body1),
                        h16,
                        Row(
                          children: [
                            Expanded(
                              child: CustomFillButton(
                                childText: Strings.ok,
                                onTapFunction: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
          Navigator.of(context).pop();
        }
      } catch (e) {
        toast(e.toString());
      } finally {
        CommonMethods.dismissLoading(context);
      }
    }
  }
}
