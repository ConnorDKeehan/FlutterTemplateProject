class NewGuessNotification {
  final int loginId;
  final bool guessingClosed;

  NewGuessNotification({
    required this.loginId,
    required this.guessingClosed,
  });

  factory NewGuessNotification.fromJson(Map<String, dynamic> json) {
    return NewGuessNotification(
      loginId: json['loginId'] as int,
      guessingClosed: json['guessingClosed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loginId': loginId,
      'guessingClosed': guessingClosed
    };
  }
}