
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tripleuglobal/components/roundCornerShape.dart';
import 'package:tripleuglobal/constants/constant_color.dart';
import 'package:tripleuglobal/constants/validations.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/decoration.dart';
import 'package:tripleuglobal/helper/dialog_helper.dart';
import 'package:tripleuglobal/helper/keyboard_helper.dart';
import 'package:tripleuglobal/provider/post_provider.dart';
import 'package:tripleuglobal/view/base_view.dart';

class EmployeeJobPostView extends StatefulWidget {
  @override
  EmployeeJobPostViewState createState() => EmployeeJobPostViewState();
}

class EmployeeJobPostViewState extends State<EmployeeJobPostView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _professionController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  BannerAd? banner;

  void createBannerAd() {
    banner = BannerAd(
      adUnitId: 'ca-app-pub-6347758864052505/8987659307',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('${ad.runtimeType} loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('${ad.runtimeType} opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed');
          ad.dispose();
          createBannerAd();
          print('${ad.runtimeType} reloaded');
        },
      ),
    )..load();
  }


  @override
  void initState() {
    super.initState();
    createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text("Post",style:ViewDecoration.textStyleBold(
            Colors.white, scaler.getTextSize(10))),
        centerTitle: true,
      ),
      body: BaseView<PostProvider>(
        builder: (context, provider, _) => SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: ViewDecoration.textStyleRegular(Colors.black, 13),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: ViewDecoration.textFiledDecoration("Name"),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Age (in years)",
                    style: ViewDecoration.textStyleRegular(Colors.black, 13),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: ViewDecoration.textFiledDecoration("Age"),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Qualification",
                    style: ViewDecoration.textStyleRegular(Colors.black, 13),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _professionController,
                    decoration: ViewDecoration.textFiledDecoration(
                        "Qualification"),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Yrs of Experience (in years)",
                    style: ViewDecoration.textStyleRegular(Colors.black, 13),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _experienceController,
                    decoration:
                        ViewDecoration.textFiledDecoration("Yrs of Experience"),
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
                    controller: _phoneNumberController,
                    decoration:
                        ViewDecoration.textFiledDecoration("Phone Number"),
                  ),
                  SizedBox(
                    height: 4,
                  ),


                  Text(
                    "Preferred Area",
                    style: ViewDecoration.textStyleRegular(Colors.black, 13),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  RoundCornerShape(
                    strokeColor: Colors.black,
                    bgColor: Colors.white,
                    radius: 8,
                    child: Padding(
                      padding: scaler.getPaddingLTRB(2, 0, 2, 0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: provider.selectedArea,
                        hint: Text(
                          provider.selectedArea ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: scaler.getTextSize(10)),
                        ),
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: Colors.black,
                        elevation: 16,
                        underline: Container(),
                        onChanged: (String? area) {
                          provider.onValueChanged(area!);
                        },
                        items: provider.areaList.map((String area) {
                          return new DropdownMenuItem<String>(
                            value: area,
                            child: new Text(area,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: scaler.getTextSize(10))),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),


                  Text(
                    "Attach Any Document",
                    style: ViewDecoration.textStyleRegular(Colors.black, 13),
                  ),
                  ElevatedButton(
                      child: Text(
                          provider.fileName == null
                              ? "Choose file"
                              : provider.fileName!,
                          style: TextStyle(fontSize: 14)),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      side: BorderSide(color: Colors.grey)))),
                      onPressed: () async {
                        provider.openFilePicker();
                      }),
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
                              child: Text("Upload".toUpperCase(),
                                  style: ViewDecoration.textStyleBold(
                                      Colors.white, scaler.getTextSize(10))),
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
                                if (_nameController.text.isEmpty) {
                                  DialogHelper.showMessage(
                                      context, "Empty name");
                                } else if (_ageController.text.isEmpty) {
                                  DialogHelper.showMessage(
                                      context, "Empty age");
                                } else if (_professionController.text.isEmpty) {
                                  DialogHelper.showMessage(context,
                                      "Empty  qualification");
                                } else if (_experienceController.text.isEmpty) {
                                  DialogHelper.showMessage(
                                      context, "Empty years of experience");
                                } else if (_emailController.text.isEmpty) {
                                  DialogHelper.showMessage(
                                      context, "Empty Email-Id");
                                } else if (!Validations.emailValidation(
                                    _emailController.text)) {
                                  DialogHelper.showMessage(
                                      context, "Invalid  Email-Id");
                                } else if (_phoneNumberController
                                    .text.isEmpty) {
                                  DialogHelper.showMessage(
                                      context, "Empty phone number");
                                } else if (provider.documentFile == null) {
                                  DialogHelper.showMessage(
                                      context, "Please attach your RESUME/CV");
                                } else {
                                  KeyboardHelper.hideKeyboard(context);
                                  var value = await provider.addJobPost(
                                      context,
                                      _experienceController.text,
                                      _phoneNumberController.text,
                                      _ageController.text,
                                      _nameController.text,
                                      _emailController.text,
                                      _professionController.text);
                                  if (value) {
                                    Navigator.pop(context);
                                  }
                                }
                              }),
                    ),
                  ),

              Container(
                height: scaler.getHeight(8),
                child:  banner == null
                    ? Container()
                    : AdWidget(
                  ad: banner!,
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
