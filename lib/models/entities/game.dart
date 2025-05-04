class Game {
  final int id;
  final int currentRoundNumber;
  final String status;
  final int totalRoundNumber;

  Game({
    required this.id,
    required this.currentRoundNumber,
    required this.status,
    required this.totalRoundNumber,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as int,
      currentRoundNumber: json['currentRoundNumber'] as int,
      status: json['status'] as String,
      totalRoundNumber: json['totalRoundNumber'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentRoundNumber': currentRoundNumber,
      'status': status,
      'totalRoundNumber': totalRoundNumber
    };
  }
}