import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/connection_service.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/connection_card.dart';
import 'package:frontend/screens/loading_screen.dart';
import '../models/models.dart';
import '../providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _connectionController = TextEditingController();
  late TabController _tabController;
  String filterValue = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _connectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Connection>> connectionsAsyncValue =
        ref.watch(connectionsFutureProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search connection',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: DesignColors.extraColorWhite,
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
            tabs: const [
              Tab(text: 'Open chats'),
              Tab(text: 'Chat requests (0)'), // Update dynamically if needed
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildConnectionListView(context, connectionsAsyncValue),
                  _buildConnectionListView(context, connectionsAsyncValue),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ref.refresh(connectionsFutureProvider),
            backgroundColor: Colors.green,
            heroTag: 'refreshButton',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _showTokenInputDialog(context),
            backgroundColor: Colors.blue,
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
          title: const Text('Add via invitation link'),
          content: TextField(
            controller: _connectionController,
            decoration: const InputDecoration(hintText: 'Invitation link'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String messageText = _connectionController.text.trim();
                final bool connectionMade = await ref
                    .read(connectionServiceProvider)
                    .acceptConnection(messageText);
                if (connectionMade) {}
                _connectionController.clear();
                // ignore: unused_result
                ref.refresh(connectionsFutureProvider);
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

  Widget _buildConnectionListView(BuildContext context,
      AsyncValue<List<Connection>> connectionsAsyncValue) {
    return connectionsAsyncValue.when(
      loading: () => const LoadingScreen(),
      error: (error, stack) => Text("Error: $error"),
      data: (connections) {
        var filteredConnections = connections
            .where((connection) =>
                connection.theirLabel.toLowerCase().contains(filterValue))
            .toList();
        return ListView.builder(
          itemCount: filteredConnections.length,
          itemBuilder: (context, index) =>
              ConnectionCard(connection: filteredConnections[index]),
          //padding: const EdgeInsets.only(top: 8.0),
        );
      },
    );
  }
}
