class RoundStartedNotification {
  final int gameRoundId;
  final int roundNumber;
  final String songUrl;

  RoundStartedNotification({
    required this.gameRoundId,
    required this.roundNumber,
    required this.songUrl,
  });

  factory RoundStartedNotification.fromJson(Map<String, dynamic> json) {
    return RoundStartedNotification(
      gameRoundId: json['gameRoundId'] as int,
      roundNumber: json['roundNumber'] as int,
      songUrl: json['songUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameRoundId': gameRoundId,
      'roundNumber': roundNumber,
      'songUrl': songUrl
    };
  }
}