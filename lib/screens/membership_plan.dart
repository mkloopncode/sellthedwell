import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/models/membership_plan_response.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/konstants.dart';

class MembershipPlanDetails extends StatefulWidget {
  const MembershipPlanDetails({Key? key}) : super(key: key);

  @override
  State<MembershipPlanDetails> createState() => _MembershipPlanDetailsState();
}

class _MembershipPlanDetailsState extends State<MembershipPlanDetails> {
  MembershipPlanResponse? membership;

  List subscriptionList = [];
  bool loading = false;
  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    _getAboutDetails();
  }

  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }

  _handleSavePayment(var data) async {
    try{
      var body_data= {
      "id": data['id'],
      "member_plan_id": data["member_plan_id"].toString(),
      "object": data["object"],
    "amount": data["amount"].toString(),
    "amount_capturable": data["amount_capturable"],
    "amount_details": {
    "tip": {}
    },
    "amount_received": data["amount_received"],
    "application": "",
    "application_fee_amount": "",
    "automatic_payment_methods": "",
    "canceled_at": "",
    "cancellation_reason": "",
    "capture_method": data["capture_method"],
    "charges": {
    "object": data["charges"]["object"],
    "data": [],
    "has_more": data["charges"]["has_more"],
    "total_count": data["charges"]["total_count"],
    "url": data["charges"]["url"],
    },
    "client_secret": data["client_secret"],
    "confirmation_method": data["confirmation_method"],
    "created": data["created"].toString(),
    "currency": data["currency"],
    "customer": "",
    "description": "",
    "invoice": "",
    "last_payment_error": "",
    "livemode": data["livemode"],
    "metadata": {},
    "next_action": "",
    "on_behalf_of": "",
    "payment_method": "",
    "payment_method_options": {
    "card": {
    "installments": "",
    "mandate_options": "",
    "network": "",
    "request_three_d_secure": "automatic"
    }
    },
    "payment_method_types": [
    "card"
    ],
    "processing": "",
    "receipt_email": "",
    "review": "",
    "setup_future_usage": "",
    "shipping": "",
    "source": "",
    "statement_descriptor": "",
    "statement_descriptor_suffix": "",
    "status": "requires_payment_method",
    "transfer_data": "",
    "transfer_group": "",
    };
      print("Payment Date");
      print(body_data);
      Response response = await post(
        Uri.parse(Konstants.baseUrl+"/payment_save"),
        body: jsonEncode(body_data),
        headers: await getHeaders(),
      );
      print("Check");
      print(response.statusCode);
      if(response.statusCode == 200){
        print(response.statusCode);
        return ;
      }else{
        print("failed");
      }

    }catch(e){
      print(e.toString());
    }
  }


  _getAboutDetails() async {
    try{
      Response response = await get(
        Uri.parse(Konstants.baseUrl+"/users/getpackagedetails"),
        headers: await getHeaders(),
      );
      if(response.statusCode == 200){
        var  data = jsonDecode(response.body.toString());
        var listData =  jsonDecode(response.body)["data"]["packagedetails"];
        subscriptionList = [];
        setState(() {
          loading = true;
          subscriptionList.addAll(listData);
          print(subscriptionList);
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
      appBar: CustomAppBar2(context: context),
      body:
      loading == false
          ? const Center(child: CircularProgressWidget())
      :
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child:  ListView.builder(itemCount: subscriptionList.length,
          padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 15),
          itemBuilder: (BuildContext context, int index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                const SizedBox(
                  height: 16,
                ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: CustomTriangleClipper(),
                        child: Container(
                          width: double.maxFinite,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: ColorUtils.primaryLight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${subscriptionList[index]["name"]}",
                                style: TextStyles.bigTitle
                                    .copyWith(color: Colors.white),
                              ),
                              Visibility(
                                visible: true,
                                child: Text(
                                  "\$${subscriptionList[index]["price"]}/m",
                                  style: TextStyles.bigTitle
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${Strings.propertySubmitLimit}${subscriptionList[index]["number_of_listings"]}",
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              thickness: 1.2,
                              endIndent: 32,
                              indent: 32,
                            ),
                            Text(
                              "${Strings.noOfUsersRealtimeVideoCall} ${subscriptionList[index]["max_video_call"]} ",
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              thickness: 1.2,
                              endIndent: 32,
                              indent: 32,
                            ),
                            Text(
                              Strings.customOrderString,
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              thickness: 1.2,
                              endIndent: 32,
                              indent: 32,
                            ),
                            Text(
                              "${Strings.featuredProperty} : ${subscriptionList[index]["featured_property"]}",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomFillButton(
                              onTapFunction: () async {
                                await makePayment(subscriptionList[index]["price"].round().toString(),index);
                              },
                              childText: subscriptionList[index]["subscription_text"].toString(),
                              color: Colors.black,
                              height: 32,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
      ),
    );
  }


    Future<void> makePayment(String price,int index) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {


        paymentIntentData = await createPaymentIntent(price, 'INR');
        print("Data");
        print(paymentIntentData);//json.decode(response.body);
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                // applePay: true,
                // googlePay: true,
                // testEnv: true,
                customerId: paymentIntentData!['id'],
                returnURL: paymentIntentData!['url'],
                style: ThemeMode.dark,
                billingDetails: BillingDetails(
                  address: Address(
                    country: 'IN',//prefs.getString('country'),
                      line2: '',
                      postalCode: prefs.getString('postalCode'),
                      city: prefs.getString('city'),
                      line1: prefs.getString('address'),
                      state: prefs.getString('state')
                  ),
                  email: prefs.getString('keyEmail'),
                  name: prefs.getString('name'),
                  phone: prefs.getString('phone'),
                ),
                merchantDisplayName: prefs.getString('name'))).then((value){
        });

        print(paymentIntentData!['client_secret']);

        print('now finally display payment sheeet');

        displayPaymentSheet(index);
      } catch (e, s) {
        print('exception:$e$s');
      }
    }

    displayPaymentSheet(int index) async {

      try {
        await Stripe.instance.presentPaymentSheet(
            parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true,
            )).then((newValue) async {
              paymentIntentData?.addAll({"member_plan_id" : subscriptionList[index]["id"].toString()});
              print("Daya");
              print(paymentIntentData!["member_plan_id"]);
          await _handleSavePayment(paymentIntentData);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));

          paymentIntentData = null;

        }).onError((error, stackTrace){
          print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        });


      } on StripeException catch (e) {
        print('Exception/DISPLAYPAYMENTSHEET==> $e');
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text("Cancelled "),
            ));
      } catch (e) {
        print('$e');
      }
    }

    //  Future<Map<String, dynamic>>
    createPaymentIntent(String amount, String currency) async {
      try {
        Map<String, dynamic> body = {
          'amount': calculateAmount(amount),
          'currency': currency,
          'payment_method_types[]': 'card'
        };
        print(body);
        var response = await http.post(
            Uri.parse('https://api.stripe.com/v1/payment_intents'),
            body: body,
            headers: {
              'Authorization':
              'Bearer sk_test_51KnmU8SJj6Mu7NjBtPhLHRV1cW1UCnENPeZTIP5C5dZqRSppmBKsTJIWFZAy0UmtJZyte3BHrhntDCp9c4bdZGQk00hrdD16TF',
              'Content-Type': 'application/x-www-form-urlencoded'
            });
        print('Create Intent reponse ===> ${response.body.toString()}');
        return jsonDecode(response.body);
      } catch (err) {
        print('err charging user: ${err.toString()}');
      }
    }

    calculateAmount(String amount) {
      final a = (int.parse(amount)) * 100 ;
      return a.toString();
    }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 1.5);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 1.5);

    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

