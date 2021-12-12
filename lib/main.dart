// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripleuglobal/constants/string_constants.dart';
import 'package:tripleuglobal/routes.dart';
import 'Router.dart' as router;
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
  setupLocator();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appname,
      theme: ThemeData(
        primarySwatch: color,
        fontFamily: StringConstants.roboto
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.splash,
      onGenerateRoute: router.Router.generateRoute,

    );
  }


  MaterialColor color = const MaterialColor(0xFF52B2BF, <int, Color>{
    50: Color(0xFF52B2BF),
    100: Color(0xFF52B2BF),
    200: Color(0xFF52B2BF),
    300: Color(0xFF52B2BF),
    400: Color(0xFF52B2BF),
    500: Color(0xFF52B2BF),
    600: Color(0xFF52B2BF),
    700: Color(0xFF52B2BF),
    800: Color(0xFF52B2BF),
    900: Color(0xFF52B2BF),
  });
}
