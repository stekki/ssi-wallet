import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/styles.dart';
import 'package:frontend/widgets/connection_card.dart';
import 'package:frontend/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String filterValue = "";

  @override
  Widget build(BuildContext context) {
    final connectionsFuture = ref.watch(connectionsFutureProvider);
    final height = MediaQuery.of(context).size.height;

    if (connectionsFuture.isLoading) {
      return Scaffold(
        body: Center(
          child: SpinKitFadingCircle(
            size: height * 0.23,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven
                      ? const Color.fromARGB(199, 27, 141, 166)
                      : const Color.fromARGB(198, 42, 143, 166),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: connectionsFuture.when(
        loading: () => const Text(
          "Loading...",
          style: TextStyles.lsText,
        ),
        error: (err, stack) => const Text(
          "Error loading venues",
          style: TextStyles.lsText,
        ),
        data: (connections) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search connection',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() => filterValue = value.toLowerCase());
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: ListView(
                  children: connections
                      .where((c) => c.toLowerCase().contains(filterValue))
                      .map((c) => ConnectionCard(name: c))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
