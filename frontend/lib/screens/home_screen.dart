import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/connection_card.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/screens/loading_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectionsFuture = ref.watch(connectionsFutureProvider);

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
              Tab(text: 'Open Chats'),
              Tab(text: 'Chat Requests'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(connectionsFuture),
                _buildTabContent(connectionsFuture),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(AsyncValue<List<String>> connectionsFuture) {
    return connectionsFuture.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
      data: (connections) => ListView.builder(
        padding: const EdgeInsets.only(top: 8.0),
        itemCount: connections.length,
        itemBuilder: (context, index) {
          final connection = connections[index];
          if (connection.toLowerCase().contains(filterValue)) {
            return ConnectionCard(name: connection);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
