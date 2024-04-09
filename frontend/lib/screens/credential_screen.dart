import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/widgets/credential_card_info.dart';
import 'package:frontend/screens/loading_screen.dart';

class CredentialScreen extends ConsumerStatefulWidget {
  const CredentialScreen({super.key});

  @override
  ConsumerState<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends ConsumerState<CredentialScreen> {
  bool _detailsOpen = false;
  final TextEditingController _searchController = TextEditingController();
  String filterValue = "";

  @override
  Widget build(BuildContext context) {
    final credentialsFuture = ref.watch(credentialsFutureProvider);
    return Scaffold(
      body: credentialsFuture.when(
          loading: () => const LoadingScreen(),
          error: (err, stack) => SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [const Text("Error loading credentials"),
            const SizedBox(height: 20),
            if (_detailsOpen && (err is Exception || err is Error))
                Text('Details: ${err.toString()}')
            ,
            if (!_detailsOpen)
              ElevatedButton(
                child: const Text("Show details"),
                onPressed: () {
                  setState((){_detailsOpen = true;});
                }
              )
            ]),
            )
          ),
          data: (credentials) {// data: (credentials) {
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
                      hintText: 'Search credential',
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
                            ),
                          ),
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
                  ),
                ),
              ],
            );
          }),
    );
  }
}
