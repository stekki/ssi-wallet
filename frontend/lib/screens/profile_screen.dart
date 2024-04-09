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
import '../widgets/credential_card_info.dart';

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
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: scaffoldBackground,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/icons/profile.png'),
              ),
            ),
            ListTile(
              title: Center(
                child: Text(
                  username,
                  style: TextStyles.profileScreenText,
                ),
              ),
              /*
              subtitle: const Center(
                child: Text(
                  "pisshead@gmail.com",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      color: Colors.white),
                ),
              ),
              */
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 200,
                      ),
                      child: profileCredentialFuture.when(
                        error: (err, stack) =>
                            const Text("Error loading credentials"),
                        loading: () => const Text(""),
                        data: (credential) => Container(
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
                              title: Text(credential[0].issuer),
                              subtitle: Text(credential[0].item),
                              children: [
                                CredentialCardInfo(
                                  date: credential[0].date,
                                  holder: credential[0].holder,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      width: width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        /*
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        */
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 300,
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
                                if (imageBytes != null)
                                  Expanded(child: Image.memory(imageBytes!)),
                                const SizedBox(height: 5),
                                TextButton(
                                  onPressed: decodeImage,
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          DesignColors.buttonColor),
                                  child: const Text('Regenerate',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
