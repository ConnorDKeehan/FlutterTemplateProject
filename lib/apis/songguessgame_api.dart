import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:songguessgame/models/entities/game.dart';
import 'package:songguessgame/models/requests/end_round_request.dart';
import 'package:songguessgame/models/requests/guess_request.dart';
import 'package:songguessgame/models/responses/get_current_game_state_response.dart';
import 'package:songguessgame/models/responses/get_game_round_guesses_response.dart';
import 'package:songguessgame/utils/storage_util.dart';

Future<void> startGame(int gameId) async {
  final url = Uri.parse('$configApiBaseUrl/SongGuessGame/StartGame');

  final accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.post(
      url,
      body: jsonEncode(gameId),
      headers: headers
  );

  if (configApiSuccessResponses.contains(response.statusCode)) {
    return;
  } else {
    throw Exception('Failed to start game: ${response.reasonPhrase}');
  }
}

Future<void> postGuess(GuessRequest request) async {
  final url = Uri.parse('$configApiBaseUrl/SongGuessGame/Guess');

  final accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.post(
      url,
      body: jsonEncode(request.toJson()),
      headers: headers
  );

  if (configApiSuccessResponses.contains(response.statusCode)) {
    return;
  } else {
    throw Exception('Failed to post guess: ${response.reasonPhrase}');
  }
}

Future<void> postEndRound(EndRoundRequest request) async {
  final url = Uri.parse('$configApiBaseUrl/SongGuessGame/EndRound');

  final accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.post(
      url,
      body: jsonEncode(request.toJson()),
      headers: headers
  );

  if (configApiSuccessResponses.contains(response.statusCode)) {
    return;
  } else {
    throw Exception('Failed to end round: ${response.reasonPhrase}');
  }
}

Future<GetGameRoundGuessesResponse> getGameRoundGuesses(int gameRoundId) async {
  final url = Uri.parse('$configApiBaseUrl/SongGuessGame/GetGameRoundGuesses')
      .replace(queryParameters: {'gameRoundId': gameRoundId.toString()});

  final accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    return GetGameRoundGuessesResponse.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to get game round guesses: ${response.reasonPhrase}');
  }
}

Future<void> nextRound(int gameId) async {
  final url = Uri.parse('$configApiBaseUrl/SongGuessGame/NextRound');

  final accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.post(
      url,
      body: jsonEncode(gameId),
      headers: headers
  );

  if (configApiSuccessResponses.contains(response.statusCode)) {
    return;
  } else {
    throw Exception('Failed to start next round: ${response.reasonPhrase}');
  }
}

Future<GetCurrentGameStateResponse> getCurrentGameState(int gameId) async {
  final url = Uri.parse('$configApiBaseUrl/SongGuessGame/GetCurrentGameState')
      .replace(queryParameters: {'gameId': gameId.toString()});

  final accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    return GetCurrentGameStateResponse.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to get game round guesses: ${response.reasonPhrase}');
  }
}

Future<List<Game>> getAllNewGames() async {
  final url = Uri.parse('$configApiBaseUrl/SongGuessGame/GetAllNewGames');

  final accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse
        .map((item) => Game.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to get game round guesses: ${response.reasonPhrase}');
  }
}

Future<int> getMyLoginId() async {
  final url = Uri.parse('$configApiBaseUrl/SongGuessGame/GetMyLoginId');

  final accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final int jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Failed to get game round guesses: ${response.reasonPhrase}');
  }
}