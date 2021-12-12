import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:tripleuglobal/constants/constant_color.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/SharedPref.dart';
import 'package:tripleuglobal/helper/decoration.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/helper/keyboard_helper.dart';
import 'package:tripleuglobal/provider/update_profile_provider.dart';
import 'package:tripleuglobal/view/base_view.dart';

class EditProfileView extends StatefulWidget {
  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState extends State<EditProfileView> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return BaseView<UpdateProfileProvider>(
        onModelReady: (provider) async {
          _firstNameController.text =
              (await SharedPref.getStringFromSF(SharedPref.FIRST_NAME))!;
          _lastNameController.text =
              (await SharedPref.getStringFromSF(SharedPref.LAST_NAME))!;
          _emailController.text =
              (await SharedPref.getStringFromSF(SharedPref.EMAIL))!;
          _phoneController.text =
              (await SharedPref.getStringFromSF(SharedPref.PHONE_NUMBER))??'';
        },
        builder: (context, provider, _) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                centerTitle: true,
                title: Text(
                  "Edit Profile",
                  style: ViewDecoration.textStyleBold(
                      Colors.white, scaler.getTextSize(10)),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: scaler.getPaddingAll(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "First Name",
                        style: ViewDecoration.textStyleRegular(Colors.black, 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextField(
                        keyboardType: TextInputType.name,
                        controller: _firstNameController,
                        decoration:
                            ViewDecoration.textFiledDecoration("First Name"),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Last Name",
                        style: ViewDecoration.textStyleRegular(Colors.black, 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextField(
                        keyboardType: TextInputType.name,
                        controller: _lastNameController,
                        decoration:
                            ViewDecoration.textFiledDecoration("Last Name"),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Email",
                        style: ViewDecoration.textStyleRegular(Colors.black, 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: ViewDecoration.textFiledDecoration("Email"),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Phone Number",
                        style: ViewDecoration.textStyleRegular(Colors.black, 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration:
                            ViewDecoration.textFiledDecoration("Phone Number"),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 42,
                          width: 180,
                          child: provider.state == ViewState.Busy
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  child: Text("Update".toUpperCase(),
                                      style: TextStyle(color:Colors.white,fontSize: 14)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kPrimaryColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0)),
                                              side: BorderSide(
                                                  color: kPrimaryColor)))),
                                  onPressed: () async {
                                    if (_firstNameController.text.isEmpty) {
                                      DialogHelper.showMessage(
                                          context, "Empty First Name");
                                    } else if (_lastNameController.text.isEmpty) {
                                      DialogHelper.showMessage(
                                          context, "Empty Last Name");
                                    } else if (_emailController.text.isEmpty) {
                                      DialogHelper.showMessage(
                                          context, "Empty Email");
                                    } else if (_phoneController.text.isEmpty) {
                                      DialogHelper.showMessage(
                                          context, "Empty Phone Number");
                                    } else {
                                      KeyboardHelper.hideKeyboard(context);
                                      var value = await provider.updateProfile(
                                          context,
                                          _firstNameController.text,
                                          _lastNameController.text,
                                          _emailController.text,
                                          _phoneController.text);
                                      if (value) {
                                        //Navigator.pop(context);
                                      }
                                    }
                                  }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
