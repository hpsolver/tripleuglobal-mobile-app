import 'package:flutter/widgets.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/services/Api.dart';

import '../locator.dart';


class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  Api api = locator<Api>();


  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

}
