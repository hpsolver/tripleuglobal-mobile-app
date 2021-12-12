import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/SharedPref.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/models/post_list_response.dart';
import 'package:tripleuglobal/provider/base_provider.dart';
import 'package:tripleuglobal/services/FetchDataException.dart';

class HomeProvider extends BaseProvider {

  List<Datum>?  jobList=[];

  Future<bool> getJobPost(
    BuildContext context,
  ) async {
    setState(ViewState.Busy);
    var userId = await SharedPref.getStringFromSF(SharedPref.USER_ID);
    try {
      var model = await api.getPost(context, userId!);
      setState(ViewState.Idle);
      jobList=model.response!.data;
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
