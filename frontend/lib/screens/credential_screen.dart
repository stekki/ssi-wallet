import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/styles.dart';
import '../providers/providers.dart';
import '../widgets/credential_card.dart';
import '../screens/loading_screen.dart';

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
    final credentialsFuture = ref.watch(credentialsFutureProvider);

    return Scaffold(
      body: credentialsFuture.when(
          loading: () => const LoadingScreen(),
          error: (err, stack) => const Text("Error loading credentials"),
          data: (credentials) {
            var filteredCredentials = credentials
                .where((c) =>
                    c.issuer.toLowerCase().contains(filterValue) ||
                    c.item.toLowerCase().contains(filterValue))
                .toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search receipt',
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
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: filteredCredentials.length,
                      itemBuilder: (context, index) {
                        var credential = filteredCredentials[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 232, 232, 232),
                              width: 2.0,
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.001, 0.999],
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 255, 255, 255)
                              ],
                            ),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: CredentialCard(
                              credential: credential,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
