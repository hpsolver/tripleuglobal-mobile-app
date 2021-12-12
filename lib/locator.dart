import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tripleuglobal/provider/home_provider.dart';
import 'package:tripleuglobal/provider/login_provider.dart';
import 'package:tripleuglobal/provider/notification_provider.dart';
import 'package:tripleuglobal/provider/phone_verification_provider.dart';
import 'package:tripleuglobal/provider/post_provider.dart';
import 'package:tripleuglobal/provider/signup_provider.dart';
import 'package:tripleuglobal/provider/update_profile_provider.dart';
import 'package:tripleuglobal/services/Api.dart';
import 'notification/firebase_notification.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => FirebaseNotification());
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => SignUpProvider());
  locator.registerFactory(() => PostProvider());
  locator.registerFactory(() => HomeProvider());
  locator.registerFactory(() => VerificationProvider());
  locator.registerFactory(() => UpdateProfileProvider());
  locator.registerFactory(() => NotificationProvider());


  locator.registerLazySingleton<Dio>(() {
    Dio dio = new Dio();
    //dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });
}
