import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/utils/styles.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/widgets/credential_card.dart';
import 'package:frontend/widgets/credential_card_info.dart';
import 'package:frontend/screens/loading_screen.dart';

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

    if (credentialsFuture.isLoading) {
      return const LoadingScreen();
    }

    return Scaffold(
      body: Container(
        decoration: scaffoldBackground,
        child: credentialsFuture.when(
          loading: () => const Text(
            "Loading...",
          ),
          error: (err, stack) => const Text(
            "Error loading venues",
          ),
          data: (credentials) => CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                sliver: SliverAppBar(
                  toolbarHeight: 40,
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  backgroundColor: DesignColors.extraColorWhite,
                  pinned: true,
                  floating: true,
                  title: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search connection',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() => filterValue = value.toLowerCase());
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        ExpansionPanelList(
                          expandedHeaderPadding: EdgeInsets.zero,
                          expansionCallback: (int index, bool isExpanded) {
                            setState(
                              () {
                                credentials[index].isExpanded = !isExpanded;
                              },
                            );
                          },
                          children: credentials
                              .where((c) =>
                                  c.issuer
                                      .toLowerCase()
                                      .contains(filterValue) ||
                                  c.item.toLowerCase().contains(filterValue))
                              .map<ExpansionPanel>(
                                (c) => ExpansionPanel(
                                  backgroundColor: DesignColors.extraColorWhite,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return CredentialCard(
                                        issuer: c.issuer, item: c.item);
                                  },
                                  body: CredentialCardInfo(
                                      date: c.date, holder: c.holder),
                                  isExpanded: !c.isExpanded,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
