import 'package:signalr_netcore/signalr_client.dart';
import 'package:songguessgame/models/notifications/new_guess_notification.dart';
import 'package:songguessgame/models/notifications/round_ended_notification.dart';
import 'package:songguessgame/models/notifications/round_started_notification.dart';
import 'package:songguessgame/utils/storage_util.dart';

class SignalRService {
  late HubConnection _connection;

  Future<void> start(String token) async {
    final accessToken = await getAccessToken();

    _connection = HubConnectionBuilder()
        .withUrl(
      '$configApiBaseUrl/gamehub',
      options: HttpConnectionOptions(
        accessTokenFactory: () async => accessToken!,
      ),
    )
        .build();

    _registerHandlers();

    await _connection.start();
    print('SignalR connected');
  }

  void _registerHandlers() {
    _connection.on('GameCreated', (args) {
      print('Game created');
    });




  }

  void registerHandler(String methodName, Function(List<Object?>? args) handler){
    _connection.on(methodName, handler);
  }

  void removeHandler(String methodName){
    _connection.off(methodName);
  }

  Future<void> joinGame(int gameId) async {
    await _connection.invoke("JoinGame", args: [gameId]);
  }

  Future<void> createGame(int totalRoundNumber) async {
    await _connection.invoke("CreateGame", args: [totalRoundNumber]);
  }

  Future<void> stop() async {
    await _connection.stop();
  }
}
