import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tripleuglobal/components/rounded_button.dart';
import 'package:tripleuglobal/components/text_field_container.dart';
import 'package:tripleuglobal/helper/decoration.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/routes.dart';

class PhoneVerification extends StatefulWidget {
  @override
  PhoneVerificationState createState() => PhoneVerificationState();
}

class PhoneVerificationState extends State<PhoneVerification> {
  String countryCode = "+254";
  String number = "";

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
          "Phone Number Verification",
          style: ViewDecoration.textStyleBold(
              Colors.white, scaler.getTextSize(10)),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Container(
                child: TextFieldContainer(
                  child: IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 4.0),
                      labelText: 'Phone Number',
                      border: InputBorder.none,
                    ),
                    initialCountryCode: 'KE',
                    onCountryChanged: (code){
                      countryCode= code.countryCode.toString();
                    },
                    onChanged: (phone) {
                      number = phone.number!;
                    },
                  ),
                ),
              ),

              SizedBox(
                height: 24,
              ),
              RoundedButton(
                text: "NEXT",
                press: () {
                  if (number.isEmpty) {
                    DialogHelper.showMessage(
                        context, "Please enter phone number");
                  } else {
                    Navigator.pushNamed(context, MyRoutes.signUp,
                        arguments: countryCode+number);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
