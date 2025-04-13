import 'dart:convert';
import 'package:fluttertemplateproj/models/responses/token_response.dart';
import 'package:fluttertemplateproj/utils/storage_util.dart';
import 'package:http/http.dart' as http;

Future<TokenResponse> refreshTokens() async {
  final refreshToken = await getRefreshToken();
  final pushNotificationToken = await getPushNotificationToken();

  final url = Uri.parse('$configApiBaseUrl/Auth/RefreshTokens');

  final headers = {'Content-Type': 'application/json'};

  final requestBody = {
    'refreshToken': refreshToken,
    if (pushNotificationToken != null)
      'pushNotificationToken': pushNotificationToken
  };

  final response =
      await http.post(url, body: jsonEncode(requestBody), headers: headers);

  if (configApiSuccessResponses.contains(response.statusCode)) {
    final jsonResponse = jsonDecode(response.body);
    final tokens = TokenResponse.fromJson(jsonResponse);

    return tokens;
  } else {
    throw Exception('Failed to add route: ${response.reasonPhrase}');
  }
}




