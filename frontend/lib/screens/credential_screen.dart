import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:frontend/providers/providers.dart';
import 'package:frontend/widgets/credential_card.dart';
import 'package:frontend/widgets/credential_card_info.dart';
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
    final credentialsFuture = ref.watch(credentialsFutureProvider);
    final height = MediaQuery.of(context).size.height;

    if (credentialsFuture.isLoading) {
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
      body: credentialsFuture.when(
        loading: () => const Text(
          "Loading...",
        ),
        error: (err, stack) => const Text(
          "Error loading venues",
        ),
        data: (credentials) => CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: DesignColors.cpCardColor,
              pinned: true,
              floating: true,
              title: TextField(
                keyboardType: TextInputType.multiline,
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search credential',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() => filterValue = value.toLowerCase());
                },
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
                                c.name.toLowerCase().contains(filterValue))
                            .map<ExpansionPanel>(
                              (c) => ExpansionPanel(
                                backgroundColor: DesignColors.cpCardColor,
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return CredentialCard(name: c.name);
                                },
                                body: CredentialCardInfo(name: c.name),
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
    );
  }
}
