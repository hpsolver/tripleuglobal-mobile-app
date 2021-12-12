import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:tripleuglobal/components/already_have_an_account_acheck.dart';
import 'package:tripleuglobal/components/rounded_button.dart';
import 'package:tripleuglobal/components/rounded_input_field.dart';
import 'package:tripleuglobal/components/text_field_container.dart';
import 'package:tripleuglobal/constants/constant_color.dart';
import 'package:tripleuglobal/constants/validations.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/decoration.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/notification/firebase_notification.dart';
import 'package:tripleuglobal/provider/signup_provider.dart';
import '../../locator.dart';
import '../../routes.dart';
import '../base_view.dart';
import 'component/background.dart';

class SignUpScreen extends StatefulWidget {


  final String? phoneNumber;

  SignUpScreen(this.phoneNumber);


  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  FirebaseNotification firebaseNotification = locator<FirebaseNotification>();
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  String? _fcmToken;
  var phoneController = TextEditingController();

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
    ScreenScaler scaler = ScreenScaler()..init(context);
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
       appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          title: Text(
            "Sign Up",
            style: ViewDecoration.textStyleBold(
                Colors.white, scaler.getTextSize(10)),
          ),
        ),
      body: BaseView<SignUpProvider>(
        onModelReady: (provider) {
          phoneController.text = widget.phoneNumber!;
        },
        builder: (context, provider, _) =>
            SingleChildScrollView(
              child: Column
                (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "First Name",
                    onChanged: (value) {
                      firstName = value;
                    },
                    icon: Icons.person,
                  ),
                  RoundedInputField(
                    hintText: "Last Name",
                    onChanged: (value) {
                      lastName = value;
                    },
                    icon: Icons.person,
                  ),
                  RoundedInputField(
                    hintText: "Your Email",
                    onChanged: (value) {
                      email = value;
                    },
                    icon: Icons.email,
                  ),



                  TextFieldContainer(
                    child: TextField(
                      controller:phoneController,
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.phone,
                      enabled: false,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: kPrimaryColor,
                        ),
                        hintText: "Phone Number",
                        border: InputBorder.none,
                      ),
                    ),
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
                          onTap: () {
                            provider.changePassword(
                                !provider.isPasswordVisible);
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
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(42, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select User Type',
                          style: ViewDecoration.textStyleBold(
                              Colors.black, 16),
                        ),
                        RadioListTile(
                          groupValue: provider.selectedUserType,
                          title: Text(
                            'Employee',
                            style:
                            ViewDecoration.textStyleRegular(
                                Colors.black, 16),
                          ),
                          value: '0',
                          onChanged: (val) {
                            provider.onUserTypeChanged(val.toString());
                          },
                        ),
                        RadioListTile(
                          groupValue: provider.selectedUserType,
                          title: Text(
                            'Employer',
                            style:
                            ViewDecoration.textStyleRegular(
                                Colors.black, 16),
                          ),
                          value: '1',
                          onChanged: (val) {
                            provider.onUserTypeChanged(val.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  provider.state == ViewState.Busy
                      ? CircularProgressIndicator()
                      : RoundedButton(
                    text: "SIGNUP",
                    press: () {
                      if (firstName.isEmpty) {
                        DialogHelper.showMessage(
                            context, 'Empty First Name');
                      } else if (lastName.isEmpty) {
                        DialogHelper.showMessage(
                            context, 'Empty Last Name');
                      } else if (email.isEmpty) {
                        DialogHelper.showMessage(context, 'Empty Email');
                      } else if (!Validations.emailValidation(email)) {
                        DialogHelper.showMessage(context, 'Invalid Email');
                      } else if (password.isEmpty) {
                        DialogHelper.showMessage(context, 'Empty Password');
                      } else if (password.length < 8) {
                        DialogHelper.showMessage(context,
                            'Password should be at least eight characters');
                      } else {
                        provider.signUp(
                            context,
                            firstName,
                            lastName,
                            email,
                            password,
                            phoneNumber,
                            _fcmToken);
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                          MyRoutes.loginRoute,
                              (Route<dynamic> route) => false);
                    },
                  ),

                  SizedBox(height: scaler.getHeight(4),)

                ],
              ),
            ),
      ),
    );
  }
}
