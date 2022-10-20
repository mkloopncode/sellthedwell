import 'package:flutter/material.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/screens/about_list.dart';
import 'package:sellthedwell/screens/about_membership.dart';
import 'package:sellthedwell/screens/active_open_houses.dart';
import 'package:sellthedwell/screens/add_listing.dart';
import 'package:sellthedwell/screens/after_login_screen.dart';
import 'package:sellthedwell/screens/app_settings_screen.dart';
import 'package:sellthedwell/screens/billing_history.dart';
import 'package:sellthedwell/screens/category_screen.dart';
import 'package:sellthedwell/screens/change_password_screen.dart';
import 'package:sellthedwell/screens/closed_listings.dart';
import 'package:sellthedwell/screens/create_tour_request.dart';
import 'package:sellthedwell/screens/details_screen.dart';
import 'package:sellthedwell/screens/explore_screen.dart';
import 'package:sellthedwell/screens/filter_screen.dart';
import 'package:sellthedwell/screens/forgot_password.dart';
import 'package:sellthedwell/screens/invalid_screen.dart';
import 'package:sellthedwell/screens/login_screen.dart';
import 'package:sellthedwell/screens/main_screen.dart';
import 'package:sellthedwell/screens/membership_plan.dart';
import 'package:sellthedwell/screens/modify_listings_screen.dart';
import 'package:sellthedwell/screens/my_active_listings.dart';
import 'package:sellthedwell/screens/onboard_screen.dart';
import 'package:sellthedwell/screens/profile_editing_screen.dart';
import 'package:sellthedwell/screens/recent_views.dart';
import 'package:sellthedwell/screens/registration_screen.dart';
import 'package:sellthedwell/screens/schedule_listings.dart';
import 'package:sellthedwell/screens/schedule_open_houses.dart';
import 'package:sellthedwell/screens/splash_screen.dart';
import 'package:sellthedwell/screens/steetview_screen.dart';
import 'package:sellthedwell/screens/support_screen.dart';
import 'package:sellthedwell/screens/tour_requests.dart';
import 'package:sellthedwell/screens/welcome_location_screen.dart';
import 'package:sellthedwell/screens/your_location_screen.dart';
import 'package:sellthedwell/utils/enums.dart';

class Routes {
  static const String onboard = "/onboard";

  Routes._();

  //SplashScreen
  static const String initial = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String forgotpassword = "/forgot_password";
  static const String afterlogin = "/after_login";
  static const String main = '/main';
  static const String changePassword = "/change_password";
  static const String welcomeLocation = "/welcome_location";
  static const String explore = "/explore";
  static const String yourLocation = "/your_location";
  static const String filterScreen = "/filter_screen";
  static const String tourRequest = "/tourRequests";
  static const String categories = "/categories";
  static const String streetView = "/street_view";
  static const String activeOpenHouses = "/active_open_houses";
  static const String scheduledOpenHouses = "/schedule_open_houses";
  static const String activeListings = "/myactive_listings";
  static const String aboutUs = "/aboutus";
  static const String aboutMemebership = "/aboutMemebership";
  static const String detailsScreen = "/property_detail";
  static const String membershipplan = "/membership_plan";
  static const String closedListings = "/closed_listings";
  static const String billingHistory = "/billing_history";
  static const String support = "/support";
  static const String scheduledListings = "/scheduled_listings";
  static const String recentlyViewed = "/recently_viewed";
  static const String editProfile = "/edit_profile";
  static const String appSettings = "/app_settings";
  static const String addListing = "/add_listing";
  static const String modifyListings = "/modify_listings";
  static const String createTourRequest = "/tour_request";

  static const String invalid = 'invalid';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return _getPageRoute(
          routeName: initial,
          viewToShow: const SplashScreen(),
        );

      case login:
        return _getPageRoute(
          routeName: login,
          viewToShow: const LoginScreen(),
        );
      case onboard:
        return _getPageRoute(
          routeName: onboard,
          viewToShow: const OnBoardScreen(),
        );

      case registration:
        return _getPageRoute(
          routeName: registration,
          viewToShow: const RegistrationScreen(),
        );

      case forgotpassword:
        return _getPageRoute(
          routeName: forgotpassword,
          viewToShow: const ForgotPasswordScreen(),
        );

      case afterlogin:
        return _getPageRoute(
          routeName: afterlogin,
          viewToShow: const AfterLoginScreen(),
        );

      case main:
        return _getPageRoute(
          routeName: main,
          viewToShow: const MainScreen(),
        );

      case changePassword:
        return _getPageRoute(
          routeName: changePassword,
          viewToShow: const ChangePasswordScreen(),
        );

      case welcomeLocation:
        return _getPageRoute(
          routeName: welcomeLocation,
          viewToShow: const WelcomeLocationScreen(),
        );

      case explore:
        return _getPageRoute(
          routeName: explore,
          viewToShow: const ExploreScreen(),
        );
      case yourLocation:
        return _getPageRoute(
          routeName: yourLocation,
          viewToShow: const YourLocationScreen(),
        );

      case categories:
        return _getPageRoute(
          routeName: categories,
          viewToShow: const CategoryScreen(),
        );
      case tourRequest:
        final args = settings.arguments as TourRequest;
        return _getPageRoute(
          routeName: tourRequest,
          viewToShow: TourRequests(type: args),
        );

      case filterScreen:
        return _getPageRoute(
          routeName: filterScreen,
          viewToShow: const FilterScreen(),
        );
      case activeListings:
        return _getPageRoute(
          routeName: activeListings,
          viewToShow: const MyActiveListings(),
        );
      case modifyListings:
        return _getPageRoute(
          routeName: modifyListings,
          viewToShow: const ModifyListings(),
        );
      case aboutUs:
        return _getPageRoute(
          routeName: aboutUs,
          viewToShow: const AboutScreen(),
        );
      case aboutMemebership:
        return _getPageRoute(
          routeName: aboutMemebership,
          viewToShow: const AboutMemebership(),
        );
      case detailsScreen:
        final args = settings.arguments as PropertyModel;
        return _getPageRoute(
          routeName: detailsScreen,
          viewToShow: DetailsScreen(prop: args),
        );
      case membershipplan:
        return _getPageRoute(
          routeName: membershipplan,
          viewToShow: const MembershipPlanDetails(),
        );
      case closedListings:
        return _getPageRoute(
          routeName: closedListings,
          viewToShow: const ClosedListings(),
        );
      case billingHistory:
        return _getPageRoute(
          routeName: billingHistory,
          viewToShow: const BillingHistory(),
        );
      case support:
        return _getPageRoute(
          routeName: support,
          viewToShow: const SupportScreen(),
        );
      case scheduledListings:
        return _getPageRoute(
          routeName: scheduledListings,
          viewToShow: const ScheduledListings(),
        );
      case streetView:
        final args = settings.arguments as PropertyModel;
        return _getPageRoute(
          routeName: streetView,
          viewToShow: GoogleStreetViewScreen(
            prop: args,
          ),
        );
      case recentlyViewed:
        return _getPageRoute(
          routeName: streetView,
          viewToShow: const RecentlyViewedScreen(),
        );
      case activeOpenHouses:
        return _getPageRoute(
          routeName: activeOpenHouses,
          viewToShow: const ActiveOpenHousesScreen(),
        );
      case scheduledOpenHouses:
        return _getPageRoute(
          routeName: scheduledOpenHouses,
          viewToShow: const ScheduleOpenHousesScreen(),
        );
      case appSettings:
        return _getPageRoute(
          routeName: appSettings,
          viewToShow: const AppSettingsScreen(),
        );
      case editProfile:
        return _getPageRoute(
          routeName: appSettings,
          viewToShow: const ProfileEditingScreen(),
        );
      case addListing:
        final args = settings.arguments as PropertyModel?;
        return _getPageRoute(
          routeName: addListing,
          viewToShow: AddNewPropertyScreen(propertyModel: args),
        );
      case createTourRequest:
        final args = settings.arguments as Map<String, dynamic>;
        PropertyModel model = args['prop'];
        int index = args['index'];
        return _getPageRoute(
          routeName: addListing,
          viewToShow: CreateTourRequest(
            model: model,
            index: index,
          ),
        );
    }
    return _getPageRoute(
      routeName: invalid,
      viewToShow: const InvalidScreen(),
    );
  }

  static PageRoute _getPageRoute(
      {required String routeName, required Widget viewToShow}) {
    return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow,
    );
  }
}
