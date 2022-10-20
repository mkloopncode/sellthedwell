import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'agora/pages/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51KnmU8SJj6Mu7NjB1weADi5X5PQ0UKTL8jXvSuoohZd5slj1r9RnQlf1cqjcvmdZ5svGYyTDyA53NK0hmOwJFaOe00fV1DyU9A';
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
       // home: IndexPage(),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.initial,
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
