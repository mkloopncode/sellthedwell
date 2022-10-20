import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/konstants.dart';
import '../utils/strings.dart';
import '../widgets/circular_progress.dart';



class BillingHistory extends StatefulWidget {
  const BillingHistory({Key? key}) : super(key: key);

  @override
  State<BillingHistory> createState() => _BillingHistoryState();
}


class _BillingHistoryState extends State<BillingHistory> {
  bool loading = false;
  var historyList = [];


  @override
  void initState() {
    getPayementHistory();

    super.initState();
  }


  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }


  void getPayementHistory() async{

    try{

      Response response = await post(
        Uri.parse(Konstants.baseUrl+"/users/package_list_details"),
        body: {},
        headers: await getHeaders(),
      );
      if(response.statusCode == 200){
        var listData =  jsonDecode(response.body)["data"]["packagedetails"];

        setState(() {
          loading = true;
          historyList.addAll(listData);
          print(historyList);
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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child:  loading == false
            ?  Container(child :  Center(child: CircularProgressWidget())) :
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.billingHistory,
                style: TextStyles.bigTitle,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemBuilder: (_, i) {
                  return InkWell(
                    onTap: () async {
                     // await makePayment();
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.list_alt,
                        color: ColorUtils.blueColor,
                        size: 20,
                      ),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            historyList[i]["package_name"].toString(),
                            style: TextStyles.heading4,
                          ),
                          Text(
                            historyList[i]["created_at"].toString(),
                            style: TextStyles.body2.copyWith(
                              color: ColorUtils.primaryLight,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorUtils.blueColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Text(
                              "\$"+historyList[i]["price"].toString(),
                              style: TextStyles.body2.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: ColorUtils.successLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child:  historyList[i]["payment_status"].toString() == "2"
                            ? Text(
                          "Paid",
                          style: TextStyles.body2.copyWith(color: Colors.white),
                        ):
                        Text(
                          "Not Paid",
                          style: TextStyles.body2.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: historyList.length,
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
