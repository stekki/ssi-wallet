import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import '../providers/providers.dart';
import '../services/graphql_service.dart';
import '../utils/helpers.dart' as helpers;
import '../utils/styles.dart';
import '../utils/secure_storage.dart';
import '../utils/token.dart';
import '../widgets/credential_card.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileScreen(),
    );
  }
}

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends ConsumerState<ProfileScreen> {
  String username = 'Stranger';

  int num = 0;
  Map? result = {};
  Uint8List? imageBytes;
  String? stringForConnection;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    decodeImage();
    _fetchAndSetUsername();
  }

  void makeQuery() async {
    result =
        await GraphQLService().getQueryResult(GraphQLService().getIdQuery, {});
    //print(result);
    setState(() {
      num++;
    });
  }

  void makeInvitation() async {
    result = await GraphQLService()
        .getQueryResult(GraphQLService().invitationQuery, {});
    //print(result);
    setState(() {
      num++;
    });
  }

  Future<void> _fetchAndSetUsername() async {
    String? token = await SecureStorageUtil().getToken();
    String? usernameFromToken = getUsernameJwt(token);
    setState(() {
      username = usernameFromToken ?? 'Stranger';
    });
  }

  Future<List<String>> createQRImageB64() async {
    // Make a check if agent has done login
    String? token = await SecureStorageUtil().getToken();
    if (token != null) {
      result = await GraphQLService()
          .getQueryResult(GraphQLService().invitationQuery, {});
      Map<String, dynamic>? invite = result?['invite'];
      if (invite != null &&
          invite.containsKey('imageB64') &&
          invite.containsKey('raw')) {
        String? raw = invite['raw'];
        String? imageB64 = invite['imageB64'];
        if (imageB64 != null && raw != null) {
          return [imageB64, raw];
        } else {
          return ['Image not available', 'link not available'];
        }
      } else {
        return ['Invite not found', 'Invite not found'];
      }
    } else {
      return ['Login first', 'Login first'];
    }
  }

  Future<void> decodeImage() async {
    setState(() => isLoading = true);

    List<String> actualBase64StringList = await createQRImageB64();
    String actualBase64String = actualBase64StringList[0];
    List<int> bytes = base64Decode(actualBase64String);
    setState(() {
      imageBytes = Uint8List.fromList(bytes);
      stringForConnection = actualBase64StringList[1];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileCredentialFuture = ref.watch(profileCredentialProvider);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          // ------- QR Code section -------
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Stack(
              children: [
                Container(
                  decoration: scaffoldBackground,
                ),
                Center(
                  child: imageBytes != null
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.memory(imageBytes!))
                      : const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
          Column(
            children: [
              // ---- Name section ----
              ListTile(
                title: Text(
                  username,
                  style: TextStyles.profileScreenText,
                ),
              ),

              // ---- Credential card section ----
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: profileCredentialFuture.when(
                  error: (err, stack) =>
                      const Text("Error loading credentials"),
                  loading: () => const Text(""),
                  data: (credential) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 243, 243),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: CredentialCard(
                        credential: credential[0],
                      ),
                    ),
                  ),
                ),
              ),

              // ----- Start of invitation link -----

              Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: isLoading
                    ? const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: width * 0.9,
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: stringForConnection),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Invitation link',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: stringForConnection ??
                                            'Could not find the invitation link'));
                                    helpers.showInfoSnackBar(
                                        context, 'Copied to clipboard');
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: width * 0.6,
                              height: 50,
                              child: TextButton(
                                onPressed: decodeImage,
                                style: TextButton.styleFrom(
                                    backgroundColor: DesignColors.buttonColor),
                                child: const Text('Regenerate',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              // ----- End of Regenerate button -----
            ],
          )
        ]),
      ),
    );
  }
}
