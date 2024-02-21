import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/connection_card.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/screens/loading_screen.dart';
import '../Models/models.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectionsFuture = ref.watch(connectionsFutureProvider);
    final height = MediaQuery.of(context).size.height;
    if (connectionsFuture.isLoading) {
      return const LoadingScreen();
    }
    return Scaffold(
      body: Container(
        decoration: scaffoldBackground,
        child: connectionsFuture.when(
          loading: () => const Text(
            "Loading...",
          ),
          error: (err, stack) => const Text(
            "Error loading chats",
          ),
          data: (connections) => Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Open chats'),
                  Tab(text: 'chat request (0)'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    CustomScrollView(
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
                            backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
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
                                setState(
                                    () => filterValue = value.toLowerCase());
                              },
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return SizedBox(
                                height: height * 0.75,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: connections
                                            .where((connection) => connection
                                                .theirLabel
                                                .toLowerCase()
                                                .contains(filterValue))
                                            .map((connection) => ConnectionCard(
                                                name: connection.theirLabel))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    ),
                    CustomScrollView(
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
                            backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
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
                                setState(
                                    () => filterValue = value.toLowerCase());
                              },
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return SizedBox(
                                height: height * 0.75,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: connections
                                            .where((connection) => connection
                                                .theirLabel
                                                .toLowerCase()
                                                .contains(filterValue))
                                            .map((c) => ConnectionCard(
                                                name: c.theirLabel))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
