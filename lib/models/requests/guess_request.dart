class GuessRequest {
  final int gameRoundId;
  final String guessString;

  GuessRequest({
    required this.gameRoundId,
    required this.guessString,
  });

  factory GuessRequest.fromJson(Map<String, dynamic> json) {
    return GuessRequest(
      gameRoundId: json['gameRoundId'] as int,
      guessString: json['guessString'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameRoundId': gameRoundId,
      'guessString': guessString
    };
  }
}