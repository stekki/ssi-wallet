import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:frontend/providers.dart';
import 'package:frontend/widgets/credential_card.dart';
import '../utils/styles.dart';

class CredentialScreen extends ConsumerStatefulWidget {
  const CredentialScreen({super.key});

  @override
  ConsumerState<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends ConsumerState<CredentialScreen> {
  final TextEditingController _searchController = TextEditingController();
  String filterValue = "";

  @override
  Widget build(BuildContext context) {
    final credetialsFuture = ref.watch(credentialsFutureProvider);
    final height = MediaQuery.of(context).size.height;

    if (credetialsFuture.isLoading) {
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
      body: credetialsFuture.when(
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
                  hintText: 'Search credential',
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
                      .map((c) => CredentialCard(name: c))
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
