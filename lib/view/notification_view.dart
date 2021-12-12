import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:tripleuglobal/enums/viewstate.dart';
import 'package:tripleuglobal/helper/decoration.dart';
import 'package:tripleuglobal/provider/notification_provider.dart';
import 'package:tripleuglobal/view/base_view.dart';

class NotificationView extends StatefulWidget {
  @override
  NotificationViewState createState() => NotificationViewState();
}

class NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Notification",
          style: ViewDecoration.textStyleBold(
              Colors.white, scaler.getTextSize(10)),
        ),
      ),
      body: BaseView<NotificationProvider>(
        onModelReady: (provider) {
          provider.getNotifications(context);
        },
        builder: (context, provider, _) => Padding(
          padding: scaler.getPaddingAll(6),
          child: provider.state == ViewState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: provider.notificationList!.length == 0
                      ? Center(
                          child: Text(
                            "No Data Found",
                            style: ViewDecoration.textStyleRegular(
                                Colors.black, scaler.getTextSize(11)),
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.notificationList!.length,
                          itemBuilder: (context, index) =>
                              _listItem(context, index,provider)),
                ),
        ),
      ),
    );
  }

  Widget _listItem(BuildContext context, int index, NotificationProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.notificationList![index].title!,
              style: ViewDecoration.textStyleBold(Colors.black, 13),
            ),
            Text(
              provider.notificationList![index].description!,
              style: ViewDecoration.textStyleRegular(Colors.black, 14),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
