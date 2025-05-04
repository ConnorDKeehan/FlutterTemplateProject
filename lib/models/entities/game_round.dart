class GameRound {
  final int id;
  final int gameId;
  final int songId;
  final int loginId;
  final int? winnerLoginId;
  final int roundNumber;
  final String status;

  GameRound({
    required this.id,
    required this.gameId,
    required this.songId,
    required this.loginId,
    required this.winnerLoginId,
    required this.roundNumber,
    required this.status
  });

  factory GameRound.fromJson(Map<String, dynamic> json) {
    return GameRound(
      id: json['id'] as int,
      gameId: json['gameId'] as int,
      songId: json['songId'] as int,
      loginId: json['loginId'] as int,
      winnerLoginId: json['winnerLoginId'] as int?,
      roundNumber: json['roundNumber'] as int,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameId': gameId,
      'songId': songId,
      'loginId': loginId,
      'winnerLoginId': winnerLoginId,
      'roundNumber': roundNumber,
      'status': status,
    };
  }
}