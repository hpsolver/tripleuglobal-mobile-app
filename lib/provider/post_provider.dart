import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/SharedPref.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/provider/base_provider.dart';
import 'package:tripleuglobal/services/FetchDataException.dart';

class PostProvider extends BaseProvider {
  File? documentFile;
  String? fileName;
  String? selectedArea;

  List<String> areaList = ['In kenya', 'Outside Kenya', 'Any'];

  Future<bool> addJobPost(
    BuildContext context,
    String experience,
    String contact,
    String age,
    String fullname,
    String email,
    String qualification,
  ) async {
    setState(ViewState.Busy);
    var userId = await SharedPref.getStringFromSF(SharedPref.USER_ID);
    var userType = await SharedPref.getStringFromSF(SharedPref.USER_TYPE);
    try {
      var model = await api.addJobPost(context, userId!, fullname, email,
          qualification, documentFile!, experience, contact, age, userType!,selectedArea!);
      setState(ViewState.Idle);
      if (model.response!.status == "0") {
        DialogHelper.showMessage(context, model.response!.message.toString());
        return false;
      } else {
        return true;
      }
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

  Future<bool> addEmployerPost(
    BuildContext context,
    String experienceLevel,
    String contact,
    String typeOfEmployer,
    String fullname,
    String email,
  ) async {
    setState(ViewState.Busy);
    var userId = await SharedPref.getStringFromSF(SharedPref.USER_ID);
    var userType = await SharedPref.getStringFromSF(SharedPref.USER_TYPE);
    try {
      var model = await api.addEmployerPost(context, userId!, fullname, email,
          documentFile!, experienceLevel, contact, typeOfEmployer, userType!,selectedArea!);
      setState(ViewState.Idle);
      if (model.response!.status == "0") {
        DialogHelper.showMessage(context, model.response!.message.toString());
        return false;
      } else {
        return true;
      }
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

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      documentFile = File(result.files.single.path!);
      PlatformFile file = result.files.first;
      fileName = file.name;
    } else {
      // User canceled the picker
    }
    notifyListeners();
  }

  void onValueChanged(String area) {
    selectedArea = area;
    notifyListeners();
  }
}
