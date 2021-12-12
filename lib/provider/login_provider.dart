import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/SharedPref.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/provider/base_provider.dart';
import 'package:tripleuglobal/routes.dart';
import 'package:tripleuglobal/services/FetchDataException.dart';

class LoginProvider extends BaseProvider{

  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void changePassword(bool hidePassword) {
    _isPasswordVisible = hidePassword;
    notifyListeners();
  }

  Future<bool> login(
      BuildContext context, String email, String password, String? fcmToken) async {
    setState(ViewState.Busy);
    try {
      var model = await api.login(context, email, password,fcmToken);
      setState(ViewState.Idle);
      if(model.response!.status=="0"){
        DialogHelper.showMessage(context, model.response!.message.toString());
      }else{
        SharedPref.addStringToSF(SharedPref.USER_ID, model.response!.data!.userId!);
        SharedPref.addStringToSF(SharedPref.USER_TYPE, model.response!.data!.userType!);
        SharedPref.addStringToSF(SharedPref.FIRST_NAME, model.response!.data!.firstName!);
        SharedPref.addStringToSF(SharedPref.LAST_NAME, model.response!.data!.lastName!);
        SharedPref.addStringToSF(SharedPref.EMAIL, model.response!.data!.email!);
        SharedPref.addStringToSF(SharedPref.PHONE_NUMBER, model.response!.data!.contact!);
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