import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/credential.dart';
import 'package:shared_preferences/shared_preferences.dart';

final credentialsFutureProvider = FutureProvider<List<Credential>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              Credential(
                  issuer: "Verkkokauppa",
                  item: "Playstation 5",
                  date: "20.05.2023",
                  holder: "Matti Meikäläinen",
                  status: "valid"),
              Credential(
                  issuer: "Aalto University",
                  item: "Aalto hoodie",
                  date: "01.02.2024",
                  holder: "Matti Meikäläinen",
                  status: "valid"),
              Credential(
                  issuer: "Tector",
                  item: "MacBook Pro",
                  date: "25.12.2023",
                  holder: "Matti Meikäläinen",
                  status: "invalid"),
            ]);
  },
);

final profileCredentialProvider = FutureProvider<List<Credential>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              Credential(
                  issuer: "Finnish government",
                  item: "SSN",
                  date: "20.05.2000",
                  holder: "Testi Terttu",
                  status: "valid"),
            ]);
  },
);

// Provider for storing chat states
class ChatIdsNotifier extends StateNotifier<List<String>> {
  final SharedPreferences prefs;
  ChatIdsNotifier(this.prefs) : super([]);

  _initialize() async {
    if (prefs.containsKey("chats")) {
      state = prefs.getStringList("chats")!;
    }
  }

  updateChatStatus(String id) async {
    //final chats = state;
    state = [id, ...state];
    /*
    if (!state.contains(id)) {
      state = [id, ...state];
    } else {
      chats.removeWhere((venueId) => venueId == id);
      state = [...chats];
    }
    */
    prefs.setStringList("chats", state);
  }
}

final chatStatusProvider =
    StateNotifierProvider<ChatIdsNotifier, List<String>>((ref) {
  final ids = ChatIdsNotifier(ref.watch(sharedPreferencesProvider));
  ids._initialize();
  return ids;
});

// Provider for sharedPreferences
final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
