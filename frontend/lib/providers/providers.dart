import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter/material.dart';
import 'package:frontend/models/credential.dart';
//import 'package:frontend/screens/loading_screen.dart';
import 'package:frontend/services/connection_service.dart';
import 'package:frontend/services/message_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:frontend/widgets/credential_card_info.dart';

/*
class CredentialsListWidget extends ConsumerWidget {
  final FutureProvider<List<Credential>> credentialsProvider;
  final String filterValue;

  const CredentialsListWidget({super.key, required this.credentialsProvider, required this.filterValue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentialsFuture = ref.watch(credentialsProvider);

    return credentialsFuture.when(
      loading: () => const LoadingScreen(),
      error: (err, stack) => const Text("Error loading credentials"),
      data: (credentials) {
        var filteredCredentials = credentials
            .where((c) =>
                c.issuer.toLowerCase().contains(filterValue) ||
                c.item.toLowerCase().contains(filterValue))
            .toList();

        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: filteredCredentials.length,
            itemBuilder: (context, index) {
              var credential = filteredCredentials[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 152, 226, 226),
                      width: 2.0,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.001, 0.999],
                      colors: [
                        Color.fromARGB(255, 212, 253, 248),
                        Color.fromARGB(255, 228, 255, 252)
                      ],
                    )),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: Text(credential.issuer),
                    subtitle: Text(credential.item),
                    children: [
                      CredentialCardInfo(
                        date: credential.date,
                        holder: credential.holder,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
*/

final connectionServiceProvider = Provider((ref) => ConnectionService());
final messageServiceProvider = Provider((ref) => MessageService());
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
