class GameLogin {
  final int id;
  final int gameId;
  final int loginId;
  final int points;
  final int loginIndex;
  final bool gameMaster;
  final bool currentTurn;

  GameLogin({
    required this.id,
    required this.gameId,
    required this.loginId,
    required this.points,
    required this.loginIndex,
    required this.gameMaster,
    required this.currentTurn
  });

  factory GameLogin.fromJson(Map<String, dynamic> json) {
    return GameLogin(
      id: json['id'] as int,
      gameId: json['gameId'] as int,
      loginId: json['loginId'] as int,
      points: json['points'] as int,
      loginIndex: json['loginIndex'] as int,
      gameMaster: json['gameMaster'] as bool,
      currentTurn: json['currentTurn'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameId': gameId,
      'loginId': loginId,
      'points': points,
      'loginIndex': loginIndex,
      'gameMaster': gameMaster,
      'currentTurn': currentTurn,
    };
  }
}