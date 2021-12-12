import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripleuglobal/routes.dart';
import 'package:tripleuglobal/view/about_us_view.dart';
import 'package:tripleuglobal/view/contact_us_view.dart';
import 'package:tripleuglobal/view/edit_profile_view.dart';
import 'package:tripleuglobal/view/employee_job_post%20.dart';
import 'package:tripleuglobal/view/employer_job_post%20.dart';
import 'package:tripleuglobal/view/home_view.dart';
import 'package:tripleuglobal/view/login/login_view.dart';
import 'package:tripleuglobal/view/notification_view.dart';
import 'package:tripleuglobal/view/phone_verification.dart';
import 'package:tripleuglobal/view/pin_code_verification_screen.dart';
import 'package:tripleuglobal/view/signup/signup_screen.dart';
import 'package:tripleuglobal/view/splash/splash_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case MyRoutes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case MyRoutes.signUp:
        var phoneNumber = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SignUpScreen(phoneNumber));

      case MyRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeView());

      case MyRoutes.employeeJobPost:
        return MaterialPageRoute(builder: (_) => EmployeeJobPostView());

      case MyRoutes.employerJobPost:
        return MaterialPageRoute(builder: (_) => EmployerJobPostView());

      case MyRoutes.phoneVerification:
        return MaterialPageRoute(builder: (_) => PhoneVerification());

      case MyRoutes.contactUs:
        return MaterialPageRoute(builder: (_) => ContactUs());
 case MyRoutes.aboutUs:
        return MaterialPageRoute(builder: (_) => AboutUs());

      case MyRoutes.otpVerification:
        var phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => PinCodeVerificationScreen(phoneNumber));

      case MyRoutes.notification:
        return MaterialPageRoute(builder: (_) => NotificationView());

      case MyRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
