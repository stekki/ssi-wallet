import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/event_notification.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/connection_service.dart';
import '../screens/loading_screen.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../utils/styles.dart';
import '../widgets/connection_card.dart';
import 'package:frontend/utils/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  // final subscription = EventNotification().subscription;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _connectionController = TextEditingController();
  late TabController _tabController;
  String filterValue = "";
  late StreamSubscription<QueryResult<Object?>> subscription;
  late StreamProvider<List<Connection>> connectionStreamProvider;

  @override
  void initState() {
    super.initState();
    subscription = EventNotification().subscription();
    connectionStreamProvider = ConnectionService().connectionStreamProvider();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _connectionController.dispose();
    super.dispose();
  }

  void showErrorSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Connection>> connectionsAsyncValue =
        ref.watch(connectionStreamProvider);
    final Map<String, ConnectionStatus> chatStateList = ref.watch(chatStatusProvider);

    return Scaffold(
      body: connectionsAsyncValue.when(
        loading: () => const LoadingScreen(),
        error: (error, stack) => Text("Error: $error"),
        data: (connections) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search chat',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: DesignColors.extraColorGray,
                  ),
                  onChanged: (value) {
                    setState(() => filterValue = value.toLowerCase());
                  },
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  const Tab(text: 'Open chats'),
                  Tab(
                      text:
                          'Chat requests (${connections.where((connection) => !chatStateList.containsKey(connection.id)).length})'), // Update dynamically if needed
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildConnectionListViewOpen(
                        context, connections, chatStateList),
                    _buildConnectionListViewRequest(
                        context, connections, chatStateList),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /*
          FloatingActionButton(
            onPressed: () => ref.refresh(connectionsFutureProvider),
            backgroundColor: Colors.green,
            heroTag: 'refreshButton',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          */
          FloatingActionButton(
            onPressed: () => _showTokenInputDialog(context),
            backgroundColor: DesignColors.mainColor,
            heroTag: 'addButton',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showTokenInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add via invitation link',
              style: TextStyles.floatingButtonText),
          content: TextField(
            controller: _connectionController,
            decoration: const InputDecoration(
              hintText: 'Invitation link',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final String messageText = _connectionController.text.trim();
                  if (messageText
                      .startsWith('didcomm://aries_connection_invitation')) {
                    final bool connectionMade =
                        await ConnectionService().acceptConnection(messageText);

                    if (!connectionMade) {
                      showErrorSnackbar("Failed to make the connection");
                    }
                    _connectionController.clear();
                  } else {
                    showErrorSnackbar(
                        'Invalid invitation link. Please try again.');
                  }
                } catch (e) {
                  if (e is Error) {
                    showErrorSnackbar('An error occurred: ${e.toString()}');
                  }
                }
                // ignore: unused_result
                // ref.refresh(connectionsFutureProvider);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildConnectionListViewRequest(BuildContext context,
      List<Connection> connections, Map<String, ConnectionStatus> chatStates) {
    var filteredConnections = connections
        .where((connection) =>
            connection.theirLabel.toLowerCase().contains(filterValue) &&
            !chatStates.containsKey(connection.id))
        .toList();

    return ListView.builder(
      itemCount: filteredConnections.length,
      itemBuilder: (context, index) =>
          ConnectionCard(connection: filteredConnections[index]),
      padding: const EdgeInsets.only(top: 8.0),
    );
  }

  Widget _buildConnectionListViewOpen(BuildContext context,
      List<Connection> connections, Map<String, ConnectionStatus> chatStates) {
    var filteredConnections = connections
        .where((connection) =>
            connection.theirLabel.toLowerCase().contains(filterValue) &&
            chatStates.containsKey(connection.id))
        .toList();

    return ListView.builder(
      itemCount: filteredConnections.length,
      itemBuilder: (context, index) =>
          ConnectionCard(connection: filteredConnections[index]),
      padding: const EdgeInsets.only(top: 8.0),
    );
  }
}
