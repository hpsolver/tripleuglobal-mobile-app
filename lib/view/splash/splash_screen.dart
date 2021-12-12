import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tripleuglobal/constants/constant_color.dart';
import 'package:tripleuglobal/helper/SharedPref.dart';
import 'package:tripleuglobal/routes.dart';

import 'component/background.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  var timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "WELCOME TO TripleUGlobal",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.05),
                CircularProgressIndicator(
                  color: kPrimaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> startTimer() async {
    timer = Timer(Duration(seconds: 2), () async {
     var userId= await SharedPref.getStringFromSF(SharedPref.USER_ID);

      if (userId!=null&&userId.isNotEmpty) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(
            MyRoutes.home,
                (Route<dynamic> route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(
            MyRoutes.loginRoute,
                (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
