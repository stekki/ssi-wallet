import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/connection_service.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Connection>> connectionsAsyncValue =
        ref.watch(connectionsFutureProvider);

    return Scaffold(
      body: Container(
        child: connectionsAsyncValue.when(
          loading: () => const LoadingScreen(),
          error: (error, stackTrace) => Text("Error: $error"),
          data: (connections) => Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Open chats'),
                  Tab(text: 'Chat requests (0)'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildConnectionListView(context, connections),
                    _buildConnectionListView(context, connections),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Trigger a refresh on the connectionsFutureProvider to update the connection list
              // ignore: unused_result
              ref.refresh(connectionsFutureProvider);
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10), // Spacing between the buttons
          FloatingActionButton(
            onPressed: () {
              _showTokenInputDialog(context);
            },
            backgroundColor: Colors.blue,
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
            controller: _connectionController, // Use your own controller
            decoration: const InputDecoration(hintText: 'Invitation link'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String messageText = _connectionController.text.trim();
                await ref
                    .read(connectionServiceProvider)
                    .acceptConnection(messageText);
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

  Widget _buildConnectionListView(
      BuildContext context, List<Connection> connections) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          sliver: SliverAppBar(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            pinned: true,
            floating: true,
            title: TextField(
              keyboardType: TextInputType.multiline,
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search connection',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() => filterValue = value.toLowerCase());
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  // Trigger a refresh on the connectionsFutureProvider to update the connection list
                  // ignore: unused_result
                  ref.refresh(connectionsFutureProvider);
                },
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView(
                  children: connections
                      .where((connection) => connection.theirLabel
                          .toLowerCase()
                          .contains(filterValue))
                      .map((c) => ConnectionCard(connection: c))
                      .toList(),
                ),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
