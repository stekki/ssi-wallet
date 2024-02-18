import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/graphql_service.dart';
import '../utils/secure_storage.dart';
import 'package:flutter/services.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int num = 0;

  Map? result = {};

  Uint8List? imageBytes;

  String? stringForConnection;

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
    List<String> actualBase64StringList = await createQRImageB64();
    String actualBase64String = actualBase64StringList[0];
    List<int> bytes = base64Decode(actualBase64String);
    imageBytes = Uint8List.fromList(bytes);
    print(imageBytes);
    if (actualBase64StringList[1] != null) {
      stringForConnection = actualBase64StringList[1];
      print(stringForConnection);
    } else {
      stringForConnection = 'something else';
    }
  }

  @override
  Widget build(BuildContext context) {

return Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 16.0),
      FutureBuilder(
        future: decodeImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
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
                          Clipboard.setData(ClipboardData(text: stringForConnection ?? 'something went wrong'));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
                        },
                      ),
                    ),
                  ),
                ),
                if (imageBytes != null) Image.memory(imageBytes!),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      decodeImage();
                    });
                  },
                  child: const Text('Regenerate'),
                ),
              ],
            );
          }
        },
      ),
    ],
  ),
);
  }
}