import 'package:songguessgame/models/entities/game.dart';
import 'package:songguessgame/models/entities/game_login.dart';
import 'package:songguessgame/models/entities/game_round.dart';

class GetCurrentGameStateResponse {
  final List<GameLogin> gameLogins;
  final Game game;
  final GameRound? gameRound;

  GetCurrentGameStateResponse({
    required this.gameLogins,
    required this.game,
    required this.gameRound,
  });

  factory GetCurrentGameStateResponse.fromJson(Map<String, dynamic> json) {
    return GetCurrentGameStateResponse(
      gameLogins: (json['gameLogins'] as List<dynamic>)
          .map((e) => GameLogin.fromJson(e as Map<String, dynamic>))
          .toList(),
      game: Game.fromJson(json['game'] as Map<String, dynamic>),
      gameRound: json['gameRound'] != null
          ? GameRound.fromJson(json['gameRound'] as Map<String, dynamic>)
          : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameLogins': gameLogins.map((e) => e.toJson()).toList(),
      'game': game.toJson(),
      'gameRound': gameRound?.toJson(),
    };
  }
}