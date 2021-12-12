import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/SharedPref.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/provider/base_provider.dart';
import 'package:tripleuglobal/routes.dart';
import 'package:tripleuglobal/services/FetchDataException.dart';

class SignUpProvider extends BaseProvider{

  String _selectedUserType = '0';

  bool _isPasswordVisible = false;


  String get selectedUserType => _selectedUserType;

  bool get isPasswordVisible => _isPasswordVisible;

  void changePassword(bool hidePassword) {
    _isPasswordVisible = hidePassword;
    notifyListeners();
  }

  void onUserTypeChanged(String val) {
    _selectedUserType=val;
    notifyListeners();
  }

  Future<bool> signUp(
      BuildContext context,String firstName, String lastName, String email, String password, String phonrNumber,String? fcmToken) async {
    setState(ViewState.Busy);
    try {
      var model = await api.signUp(context, firstName,lastName,email, password,phonrNumber,selectedUserType,fcmToken);
      setState(ViewState.Idle);
      if(model.response!.status=="0"){
        DialogHelper.showMessage(context, model.response!.message!);
      }else{
        SharedPref.addStringToSF(SharedPref.USER_ID, model.response!.data!.userId!);
        SharedPref.addStringToSF(SharedPref.USER_TYPE, model.response!.data!.userType!);
        SharedPref.addStringToSF(SharedPref.FIRST_NAME, firstName);
        SharedPref.addStringToSF(SharedPref.LAST_NAME, lastName);
        SharedPref.addStringToSF(SharedPref.EMAIL, email);
        SharedPref.addStringToSF(SharedPref.PHONE_NUMBER, phonrNumber);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(
            MyRoutes.home,
                (Route<dynamic> route) => false);
      }

      return true;
    } on FetchDataException catch (c) {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, c.toString());
      return false;
    } on SocketException {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, 'internet_connection');
      return false;
    }
  }


}