import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/SharedPref.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/provider/base_provider.dart';
import 'package:tripleuglobal/routes.dart';
import 'package:tripleuglobal/services/FetchDataException.dart';

class UpdateProfileProvider extends BaseProvider {
  Future<bool> updateProfile(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String phonrNumber) async {
    setState(ViewState.Busy);
    var userId = await SharedPref.getStringFromSF(SharedPref.USER_ID);
    try {
      var model = await api.updateProfile(
          context, firstName, lastName, email, phonrNumber, userId!);
      setState(ViewState.Idle);
      if (model.response!.status == 0) {
        DialogHelper.showMessage(context, model.response!.message!);
      } else {
        SharedPref.addStringToSF(SharedPref.FIRST_NAME, firstName);
        SharedPref.addStringToSF(SharedPref.LAST_NAME, lastName);
        SharedPref.addStringToSF(SharedPref.EMAIL, email);
        SharedPref.addStringToSF(SharedPref.PHONE_NUMBER, phonrNumber);
        Navigator.of(context).pop();
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
