import 'package:flutter/material.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/custom_button_filled.dart';

class AfterLoginScreen extends StatelessWidget {
  const AfterLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   isBackShown: false,
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.settings,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ],
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomFillButton(
                    onTapFunction: () {
                      _handelCategoriesClick(
                          context, Konstants.listTypeResidential);
                    },
                    childText: Strings.resedential.toUpperCase(),
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomFillButton(
                    onTapFunction: () {
                      _handelCategoriesClick(
                          context, Konstants.listTypeCommercial);
                    },
                    childText: Strings.commercial.toUpperCase(),
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomFillButton(
                    onTapFunction: () {
                      _handelCategoriesClick(
                          context, Konstants.listTypeRentals);
                    },
                    childText: Strings.rentals,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _handelCategoriesClick(context, dynamic category) {
    CommonMethods.removeAllRoutesAndPushNamed(
        routeName: Routes.main, context: context, arguments: category);
  }
}
