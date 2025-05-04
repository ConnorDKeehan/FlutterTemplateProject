import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:songguessgame/apis/songguessgame_api.dart';
import 'package:songguessgame/features/game_page/widgets/all_guesses_alert_dialog/all_guesses_alert_dialog.dart';
import 'package:songguessgame/features/game_page/widgets/chat_side_bar/chat_side_bar.dart';
import 'package:songguessgame/features/game_page/widgets/players_side_bar/players_side_bar.dart';
import 'package:songguessgame/main.dart';
import 'package:songguessgame/models/notifications/new_guess_notification.dart';
import 'package:songguessgame/models/notifications/round_ended_notification.dart';
import 'package:songguessgame/models/notifications/round_started_notification.dart';
import 'package:songguessgame/models/requests/end_round_request.dart';
import 'package:songguessgame/models/requests/guess_request.dart';
import 'package:songguessgame/models/responses/get_current_game_state_response.dart';

class GamePage extends StatefulWidget {
  final int gameId;
  const GamePage({super.key, required this.gameId});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GetCurrentGameStateResponse gameState;
  int? currentGameRoundId;
  bool guessingEnabled = false;
  bool nextRoundButtonEnabled = true;
  bool amIGameMaster = false;
  bool isMyTurn = false;
  List<NewGuessNotification> guesses = [];
  TextEditingController guessController = TextEditingController();
  bool isLoading = true;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    getGameState();
    registerReceivers();
    super.initState();
  }

  void registerReceivers(){
    signalR.registerHandler('NewGuess', handleGuessReceived);
    signalR.registerHandler('NextRound', handleNextRoundReceived);
    signalR.registerHandler('EndRound', handleEndRoundReceived);
    signalR.registerHandler('UserJoined', refreshGameState);
  }

  void refreshGameState(List<Object?>? args) async {
    gameState = await getCurrentGameState(widget.gameId);

    setState(() {});
  }

  void handleEndRoundReceived(List<Object?>? args) async {
    if (args == null || args.isEmpty) return;

    final data = args[0] as Map<String, dynamic>;
    final notification = RoundEndedNotification.fromJson(data);

    gameState = await getCurrentGameState(widget.gameId);

    //Need to get user who won on the notification
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Congrats to user for winning")));

    setState(() {
      nextRoundButtonEnabled = true;
    });
  }

  void handleNextRoundReceived(List<Object?>? args) async {
    if (args == null || args.isEmpty) return;

    final data = args[0] as Map<String, dynamic>;
    final notification = RoundStartedNotification.fromJson(data);

    gameState = await getCurrentGameState(widget.gameId);

    setState(() {
      currentGameRoundId = notification.gameRoundId;
    });

    print('received new round message');

    await audioPlayer.setUrl(notification.songUrl);
    await audioPlayer.play();

    setState(() {
      guessingEnabled=true;
    });
  }

  void handleGuessReceived(List<Object?>? args) async{
    if (args == null || args.isEmpty) return;

    final data = args[0] as Map<String, dynamic>;
    final notification = NewGuessNotification.fromJson(data);

    setState(() {
      guesses.add(notification);
    });

    if(notification.guessingClosed){
      await endRound();
    }
  }

  Future<void> pickWinner(int loginId) async {
    await postEndRound(EndRoundRequest(winnerLoginId: loginId, gameRoundId: currentGameRoundId!));
  }

  Future<void> endRound() async {
    await audioPlayer.pause();
    setState(() {
      guessingEnabled = false;
    });

    final allGuesses = await getGameRoundGuesses(currentGameRoundId!);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AllGuessesAlertDialog(gameRoundGuessesResponse: allGuesses, amIGameMaster: amIGameMaster, pickWinner: pickWinner);
      }
    );
  }

  void getGameState() async {
    setState(() {
      isLoading = true;
    });
    gameState = await getCurrentGameState(widget.gameId);

    final myLoginId = await getMyLoginId();
    final gameMasterLoginId = gameState.gameLogins.where((x) => x.gameMaster == true).single.loginId;
    final currentTurnLoginId = gameState.gameLogins.where((x) => x.currentTurn == true).singleOrNull?.loginId;

    if(gameMasterLoginId == myLoginId)
    {
      amIGameMaster = true;
    }

    if(currentTurnLoginId!=null && currentTurnLoginId==myLoginId){
      isMyTurn=true;
    }

    setState(() {
      isLoading = false;
    });
  }

  void onGuess() async {
    setState(() {
      guessingEnabled = false;
    });

    await postGuess(GuessRequest(gameRoundId: gameState.gameRound!.id, guessString: guessController.text.trim()));
  }

  void handleNextRoundButton() async {
    setState(() {
      nextRoundButtonEnabled = false;
    });
    if(gameState.game.status == "New"){
      await startGame(widget.gameId);
      return;
    }

    if(gameState.game.status == "InProgress"){
      await nextRound(widget.gameId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? CircularProgressIndicator() : Row(
        children: [
          PlayersSideBar(gameLogins: gameState.gameLogins),
          Expanded(child:
          Column(children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(9),
              child: Text("Hello")
            )),
            if(amIGameMaster && nextRoundButtonEnabled)
              TextButton(onPressed: handleNextRoundButton, child: Text("Start Round"))
          ])),
          ChatSideBar(guesses: guesses, onGuess: onGuess, guessController: guessController, guessingEnabled: guessingEnabled)
        ],
      ),
    );
  }
}
