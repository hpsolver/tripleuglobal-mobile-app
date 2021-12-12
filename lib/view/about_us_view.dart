import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:tripleuglobal/constants/string_constants.dart';
import 'package:tripleuglobal/helper/decoration.dart';

class AboutUs extends StatefulWidget{
  @override
  AboutUsState createState() => AboutUsState();

}

class AboutUsState  extends State<AboutUs>{
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "About Us",
          style: ViewDecoration.textStyleBold(
              Colors.white, scaler.getTextSize(10)),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConstants.aboutUs,
              style: ViewDecoration.textStyleRegular(
                  Colors.black, scaler.getTextSize(11)),
            )
        ],),
      ),
    );
  }
}