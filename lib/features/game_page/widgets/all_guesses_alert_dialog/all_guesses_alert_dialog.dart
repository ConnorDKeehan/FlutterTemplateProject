import 'package:flutter/material.dart';
import 'package:songguessgame/features/game_page/widgets/all_guesses_alert_dialog/guess_card.dart';
import 'package:songguessgame/main.dart';
import 'package:songguessgame/models/responses/get_game_round_guesses_response.dart';

class AllGuessesAlertDialog extends StatelessWidget {
  final GetGameRoundGuessesResponse gameRoundGuessesResponse;
  final bool amIGameMaster;
  final Future<void> Function(int) pickWinner;
  const AllGuessesAlertDialog({super.key, required this.gameRoundGuessesResponse, required this.amIGameMaster, required this.pickWinner});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Song Name: ${gameRoundGuessesResponse.song.name}, Artist: ${gameRoundGuessesResponse.song.artist}"),
            const SizedBox(height: 16),
            SizedBox(
              height: 300, // Dialog scroll area
              child: ListView.builder(
                itemCount: gameRoundGuessesResponse.guesses.length,
                itemBuilder: (context, index) {
                  final guess = gameRoundGuessesResponse.guesses[index];
                  return GuessCard(
                    loginId: guess.loginId,
                    guessString: guess.guessString,
                    amIGameMaster: amIGameMaster,
                    pickWinner: (id) async {
                      Navigator.of(navigatorKey.currentContext!).pop();
                      await pickWinner(id);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
