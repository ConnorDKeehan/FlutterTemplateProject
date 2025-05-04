import 'package:flutter/material.dart';
import 'package:songguessgame/models/entities/game_login.dart';

class PlayerCard extends StatelessWidget {
  final GameLogin gameLogin;

  const PlayerCard({
    super.key, required this.gameLogin,
  });

  @override
  Widget build(BuildContext context) {
    final colourScheme = Theme.of(context).colorScheme;

    final shadowDarkness = colourScheme.brightness == Brightness.dark ? 0.9 : 0.3;

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
                  '${gameLogin.loginIndex} - Points: ${gameLogin.points}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}