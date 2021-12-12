import 'package:flutter/material.dart';
import 'package:tripleuglobal/components/already_have_an_account_acheck.dart';
import 'package:tripleuglobal/components/rounded_button.dart';
import 'package:tripleuglobal/components/rounded_input_field.dart';
import 'package:tripleuglobal/components/text_field_container.dart';
import 'package:tripleuglobal/constants/constant_color.dart';
import 'package:tripleuglobal/constants/validations.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/helper/keyboard_helper.dart';
import 'package:tripleuglobal/notification/firebase_notification.dart';
import 'package:tripleuglobal/provider/login_provider.dart';
import 'package:tripleuglobal/view/base_view.dart';

import '../../locator.dart';
import '../../routes.dart';
import 'backdround.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State {
  FirebaseNotification firebaseNotification = locator<FirebaseNotification>();
  String? _fcmToken;
  String? email = "";
  String? password = "";

  @override
  void initState() {
    firebaseNotification.getToken().then((v) async {
      if (v != null) {
        _fcmToken = v;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BaseView<LoginProvider>(
        builder: (context, provider, _) => Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),

                RoundedInputField(
                  textInputType: TextInputType.emailAddress,
                  hintText: "Your Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                TextFieldContainer(
                  child: TextField(
                    obscureText: !provider.isPasswordVisible,
                    onChanged: (value) {
                      password = value;
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          provider.changePassword(!provider.isPasswordVisible);
                        },
                        child: Icon(
                          provider.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: kPrimaryColor,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                provider.state==ViewState.Busy?CircularProgressIndicator():RoundedButton(
                  text: "LOGIN",
                  press: () {
                    if (email!.isEmpty) {
                      DialogHelper.showMessage(context, "Empty Email");
                    } else if (!Validations.emailValidation(email!)) {
                      DialogHelper.showMessage(context, "Invalid Email");
                    } else if (password!.isEmpty) {
                      DialogHelper.showMessage(context, "Empty Password");
                    } else {
                      KeyboardHelper.hideKeyboard(context);
                      provider.login(context, email!, password!, _fcmToken);
                    }
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.pushNamed(context, MyRoutes.phoneVerification);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
