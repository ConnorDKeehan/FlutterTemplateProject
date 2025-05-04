import 'package:flutter/material.dart';
import 'package:songguessgame/features/game_page/widgets/players_side_bar/player_card.dart';
import 'package:songguessgame/models/entities/game_login.dart';

class PlayersSideBar extends StatelessWidget {
  final List<GameLogin> gameLogins;
  const PlayersSideBar({super.key, required this.gameLogins});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ListView.builder(
          itemCount: gameLogins.length,
          itemBuilder: (context, index) {
            var item = gameLogins[index];
            return PlayerCard(gameLogin: item);
          }
      )
    );
  }
}
