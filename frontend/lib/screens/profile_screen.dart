import 'package:flutter/material.dart';
import 'dart:convert';
import '../../services/graphql_service.dart';
import '../../utils/secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:frontend/utils/styles.dart';
import '../token.dart';


class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

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
    result = await GraphQLService().getQueryResult(GraphQLService().getIdQuery, {});
    //print(result);
    setState(() {
      num++;
    });
  }

  void makeInvitation() async {
    result = await GraphQLService().getQueryResult(GraphQLService().invitationQuery, {});
    //print(result);
    setState(() {
      num ++;
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
      result = await GraphQLService().getQueryResult(GraphQLService().invitationQuery, {});
      Map<String, dynamic>? invite = result?['invite'];
      if (invite != null && invite.containsKey('imageB64') && invite.containsKey('raw')) {
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
    return Container(
      decoration: scaffoldBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            const Icon(
              Icons.account_circle_rounded,
              size: 64,
              semanticLabel: 'Profile picture',
            ),
            ListTile(
              title: Center(
                child: Text(
                  username,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
                ),
              ),
              //HERE WE WANT TO QUERY THE USER EMAIL FROM VAULT
              subtitle: const Center(child: Text("pisshead@gmail.com")),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    if (isLoading)
                      const CircularProgressIndicator()
                    else
                      Column(
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(text: stringForConnection),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Invitation link',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: stringForConnection ?? 'Could not find the invitation link'));
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (imageBytes != null) Image.memory(imageBytes!),
                        ],
                      ),
                    ElevatedButton(
                      onPressed: decodeImage,
                      child: const Text('Regenerate'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}