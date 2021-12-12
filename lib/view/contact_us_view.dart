import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:tripleuglobal/constants/string_constants.dart';
import 'package:tripleuglobal/helper/decoration.dart';

class ContactUs extends StatefulWidget{
  @override
  ContactUsState createState() => ContactUsState();

}

class ContactUsState  extends State<ContactUs>{
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
          "Contact Us",
          style: ViewDecoration.textStyleBold(
              Colors.white, scaler.getTextSize(10)),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: scaler.getHeight(.5),),
              Text(
                "Phone Numbers",
                style: ViewDecoration.textStyleBold(
                    Colors.black, scaler.getTextSize(10)),
              ),
            ],
          ),
         SizedBox(height: scaler.getHeight(.2),),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              StringConstants.phoneNumbers,
              style: ViewDecoration.textStyleRegular(
                  Colors.black, scaler.getTextSize(11)),
            ),
          ),
          SizedBox(height: scaler.getHeight(1),),
          Row(
            children: [

              Icon(Icons.email),
              SizedBox(width: scaler.getHeight(.5),),
              Text(
                "Support Email",
                style: ViewDecoration.textStyleBold(
                    Colors.black, scaler.getTextSize(10)),
              ),
            ],
          ),
          SizedBox(height: scaler.getHeight(.2),),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              StringConstants.supportEmail,
              style: ViewDecoration.textStyleRegular(
                  Colors.black, scaler.getTextSize(11)),
            ),
          ),
        ],),
      ),
    );
  }
}