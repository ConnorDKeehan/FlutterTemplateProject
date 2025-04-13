import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertemplateproj/features/auth/login_page/login_page.dart';
import 'package:fluttertemplateproj/features/main_page/main_page.dart';
import 'package:fluttertemplateproj/services/push_notification_service.dart';
import 'package:fluttertemplateproj/utils/storage_util.dart';
import 'apis/common_api.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  _initializePushNotifications();

  runApp(SafeArea(
      child: MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: navigatorKey,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blue, brightness: Brightness.dark),
              dividerColor: Colors.transparent,
              useMaterial3: true,
              appBarTheme:
                  const AppBarTheme(elevation: 2.0, shadowColor: Colors.grey)),
          home: FutureBuilder<bool>(
            future: _checkUserIsLoggedInAndRefreshTokens(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while checking the token
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else {
                if (snapshot.data == true) {
                  // Token is valid, proceed to MapView
                  return const MainPage();
                } else {
                  // No valid token, show LoginPage
                  return const LoginPage();
                }
              }
            },
          ))));
}

void _initializePushNotifications() async {
  await Firebase.initializeApp();
  // Initialize Push Notification Service
  PushNotificationService notificationService = PushNotificationService();
  await notificationService.initialize();
}

Future<bool> _checkUserIsLoggedInAndRefreshTokens() async {
  try {
    final newTokens = await refreshTokens();
    await setTokens(newTokens);
    return true;
  } catch (e) {
    return false;
  }
}




