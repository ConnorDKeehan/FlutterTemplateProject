class EndRoundRequest {
  final int winnerLoginId;
  final int gameRoundId;

  EndRoundRequest({
    required this.winnerLoginId,
    required this.gameRoundId,
  });

  factory EndRoundRequest.fromJson(Map<String, dynamic> json) {
    return EndRoundRequest(
        winnerLoginId: json['winnerLoginId'] as int,
        gameRoundId: json['gameRoundId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'winnerLoginId': winnerLoginId,
      'gameRoundId': gameRoundId
    };
  }
}