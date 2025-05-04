class RoundEndedNotification {
  final int gameRoundId;
  final int winningGuessId;

  RoundEndedNotification({
    required this.gameRoundId,
    required this.winningGuessId,
  });

  factory RoundEndedNotification.fromJson(Map<String, dynamic> json) {
    return RoundEndedNotification(
      gameRoundId: json['gameRoundId'] as int,
      winningGuessId: json['winningGuessId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameRoundId': gameRoundId,
      'winningGuessId': winningGuessId
    };
  }
}