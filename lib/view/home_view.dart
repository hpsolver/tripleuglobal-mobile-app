import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tripleuglobal/constants/constant_color.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/SharedPref.dart';
import 'package:tripleuglobal/helper/decoration.dart';
import 'package:tripleuglobal/notification/firebase_notification.dart';
import 'package:tripleuglobal/provider/home_provider.dart';
import 'package:tripleuglobal/routes.dart';
import 'package:tripleuglobal/view/base_view.dart';

import '../locator.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  HomeProvider? _provider;
  FirebaseNotification firebaseNotification = locator<FirebaseNotification>();
  var userType;

  BannerAd? banner;

  void createBannerAd() {
    banner = BannerAd(
      adUnitId: 'ca-app-pub-6347758864052505/3388488899',
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

  void handleClick(String value) {
    switch (value) {
      case 'About Us':
        Navigator.pushNamed(context, MyRoutes.aboutUs);
        break;
      case 'Contact Us':
        Navigator.pushNamed(context, MyRoutes.contactUs);
        break;
      case 'Edit Profile':
        Navigator.pushNamed(context, MyRoutes.editProfile);
        break;
      case 'Notification':
        Navigator.pushNamed(context, MyRoutes.notification);
        break;
      case 'Logout':
        showLogoutDialog();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    createBannerAd();
    firebaseNotification.configureFireBase(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    loadPrefrences();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text("Post List",
            style: ViewDecoration.textStyleBold(
                Colors.white, scaler.getTextSize(10))),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'About Us',
                'Contact Us',
                'Notification',
                'Edit Profile',
                'Logout'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: BaseView<HomeProvider>(
        onModelReady: (provider) {
          _provider = provider;
          provider.getJobPost(context);
        },
        builder: (context, provider, _) => provider.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  provider.jobList!.length == 0
                      ? Center(
                          child: Text("No Data Found"),
                        )
                      : ListView.builder(
                          itemCount: provider.jobList!.length,
                          itemBuilder: (context, index) {
                            return _listViewItem(context, index, provider);
                          },
                        ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: scaler.getHeight(8),
                          child: banner == null
                              ? Container()
                              : AdWidget(
                                  ad: banner!,
                                ),
                        )),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          if (userType == '0') {
            Navigator.pushNamed(context, MyRoutes.employeeJobPost)
                .then((value) {
              _provider!.getJobPost(context);
            });
          } else {
            Navigator.pushNamed(context, MyRoutes.employerJobPost)
                .then((value) {
              _provider!.getJobPost(context);
            });
          }
        },
      ),
    );
  }

  void showLogoutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext contect) {
          return new AlertDialog(
            title: new Text(
              "Logout",
              style: ViewDecoration.textStyleBold(Colors.black, 18),
            ),
            content: new Text(
              "Do you want to logout ?",
              style: ViewDecoration.textStyleRegular(Colors.black, 16),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  SharedPref.clearSharePref();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MyRoutes.loginRoute, (Route<dynamic> route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Yes",
                    style: ViewDecoration.textStyleBold(Colors.black, 16),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "No",
                    style: ViewDecoration.textStyleBold(Colors.black, 16),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _listViewItem(BuildContext context, int index, HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "#" + provider.jobList![index].id!,
                style: ViewDecoration.textStyleBold(Colors.black, 16),
              ),
              Row(
                children: [
                  Text("Experience (in years) : ",
                      style: ViewDecoration.textStyleBold(Colors.black, 14)),
                  SizedBox(
                    width: 4,
                  ),
                  Text(provider.jobList![index].experience!,
                      style: ViewDecoration.textStyleRegular(Colors.black, 14)),
                ],
              ),
              Row(
                children: [
                  Text("Email : ",
                      style: ViewDecoration.textStyleBold(Colors.black, 14)),
                  SizedBox(
                    width: 4,
                  ),
                  Text(provider.jobList![index].email!,
                      style: ViewDecoration.textStyleRegular(Colors.black, 14)),
                ],
              ),
              Row(
                children: [
                  Text("Contact : ",
                      style: ViewDecoration.textStyleBold(Colors.black, 14)),
                  SizedBox(
                    width: 4,
                  ),
                  Text(provider.jobList![index].phone!,
                      style: ViewDecoration.textStyleRegular(Colors.black, 14)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void loadPrefrences() async {
    userType = await SharedPref.getStringFromSF(SharedPref.USER_TYPE);
  }
}
