import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/provider/base_provider.dart';
import 'package:tripleuglobal/routes.dart';

class VerificationProvider extends BaseProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  set auth(FirebaseAuth value) {
    _auth = value;
  }

  Future<void> verifyOtp(BuildContext context, String verificationId,
      String otp, String phoneNumber) async {
    setState(ViewState.Busy);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final User? user = (await _auth.signInWithCredential(credential)).user;
      setState(ViewState.Idle);
      Navigator.of(context).pushNamed(MyRoutes.signUp, arguments: phoneNumber);
    } on FirebaseAuthException catch (e) {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, e.message.toString());
    }
  }
}
