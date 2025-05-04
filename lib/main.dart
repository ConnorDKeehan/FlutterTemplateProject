import 'package:flutter/material.dart';
import 'package:songguessgame/features/auth/login_page/login_page.dart';
import 'package:songguessgame/features/view_all_new_games_page/view_all_new_games_page.dart';
import 'package:songguessgame/services/signal_r_service.dart';
import 'package:songguessgame/utils/storage_util.dart';
import 'apis/common_api.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final signalR = SignalRService();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
                  return const ViewAllNewGamesPage();
                } else {
                  // No valid token, show LoginPage
                  return const LoginPage();
                }
              }
            },
          ))));
}

Future<bool> _checkUserIsLoggedInAndRefreshTokens() async {
  try {
    final newTokens = await refreshTokens();
    await setTokens(newTokens);
    await signalR.start(newTokens.jwtToken);
    return true;
  } catch (e) {
    return false;
  }
}






