import 'package:flutter/material.dart';
import 'package:songguessgame/features/game_page/game_page.dart';
import 'package:songguessgame/main.dart';
import 'package:songguessgame/models/entities/game.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({
    super.key,
    required this.game
  });

  @override
  Widget build(BuildContext context) {
    final colourScheme = Theme.of(context).colorScheme;

    final shadowDarkness = colourScheme.brightness == Brightness.dark ? 0.9 : 0.3;

    void joinGame() async {
      try {
        await signalR.joinGame(game.id);
      }
      catch(e){
        print("User is likely already in this game, try join anyways");
      }

      Navigator.of(context).push(
       MaterialPageRoute(builder: (context) => GamePage(gameId: game.id)),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: colourScheme.secondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(shadowDarkness),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  game.id.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextButton(onPressed: joinGame, child: Text("Join Game"))
              ],
            )
          ],
        ),
      ),
    );
  }
}