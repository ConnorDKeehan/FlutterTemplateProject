class Guess {
  final int id;
  final int gameRoundId;
  final int loginId;
  final String guessString;
  final int? correct;

  Guess({
    required this.id,
    required this.gameRoundId,
    required this.loginId,
    required this.guessString,
    required this.correct
  });

  factory Guess.fromJson(Map<String, dynamic> json) {
    return Guess(
      id: json['id'] as int,
      gameRoundId: json['gameRoundId'] as int,
      loginId: json['loginId'] as int,
      guessString: json['guessString'] as String,
      correct: json['correct'] as int?
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameRoundId': gameRoundId,
      'loginId': loginId,
      'guessString': guessString,
      'correct': correct
    };
  }
}