import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../services/graphql_service.dart';

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
  Map? characters;
  int num = 0;
  Map? result = {};

  void makeQuery() async {
    result = await GraphQLService.getQueryResult(GraphQLService.getIdQuery, {});
    //print(result);
    setState(() {
      num++;
    });
  }

  void makeInvitation() async {
    result =
        await GraphQLService.getQueryResult(GraphQLService.invitationQuery, {});
    //print(result);
    setState(() {
      num++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    String s1 =
        "iVBORw0KGgoAAAANSUhEUgAAAQAAAAEAAQMAAABmvDolAAAABlBMVEX///8AAABVwtN+AAAF/klEQVR4nOyZP862rBLGx1BMpxsgYRt0bEk24J8N6Jbo2AYJG8COgnidjN5v3lOcTorzJZ+5C+PzS2Rk5ppreOjf6590MRBz4Xy75qMp1mzUptjWmAag9AFoC";
    String s2 =
        "EDIZ2gDMmA2poXMFbUPNPcBzBXSWvUQaHbkgYPVHnGG5GPrB6ibzI42O1Mcbk4j6zVQX2CvaQIAmoLZgbNic+bqBtAQkq9qY5o5XyHvQZPLZ23D30/9EQCi9v/z9zdhvgHCaB9yYfIxzS4NQS+sgP9O7G+AhNZGbgsDARvrCbiQFofrF+ZngNJC6oq0WOy1TV";
    String s3 =
        "VCm0ltVo/uDbMDMMRGbDYnixmgUJMPbWG12TfO7wCNDojNV3Ow2SgfLt8uH9RmTn0ATlLmNp/QPtLCaQ1mcziBTdSmC6BnwhXUFdQZRW320IZgblY3m9IJ8KENNQ1SoQoBV8TBNNR8Ic1dAJJMuES7NMlLG1k9VD2AyDXqArASPaE2WxyWZsqIBiEXqzZWpQ9";
    String s4 =
        "gisuHTbMVhV/IFDKHNXtoi/up/VeA9FDzHswVzSGCrGebb6sOTkPsBZjb4YxmIxSXRkpTxW1zcQrQ1AXgvEcAeoW6SSGqw6kTbbTahzdhvgNmkydJtLHqtbahal/JV8m6rQ8g7wXSFAyCFOMKmkl2bbPoA5AqpIcoy5A0ZuxRnbGRzWd8JegzwG2FOUM+HG6H";
    String s5 =
        "C7QCJ9QudiWXPoAqnAF1OFpjRgWCJktT1TO/m/UdyFfMezSF9QrxcnJv9fO8F6AKmxP5jLRGGslc4YnaovBPYT4DBmgr8s0QUxrUBezPhwV6AWojU6zc7PGpF7QpaB8T2d9mfQVIXTXf3IZonrfLAjaXC6fR6rkLwHoWW6JnUctcuK3igdMU00LY+gBJPqNTN";
    String s6 =
        "0lQM9MQsUNPoAHvGr4D8upL1tBGMVdtttpXswdTfvrwHWhepg+xQFM1t0tTVEXEWZ5QH0AvlMjRFMS/TUHWQy5NNZ+/8v8MSJ9SV0wTJOSbm6/qrOa2eoivTn4GWIp9Qj6rOau6Ag6nilOHPM99AGpraD7mg1CYZimifIvmJ+K3834HlIyxVl1VFZfLw5MYRb";
    String s7 =
        "FGpQvAkgYIkgabVI34n4PybZuP7wDyGSBxC1cwe8x7FTtNMnKSj/l+a7MDQD7kjdJIenHYQWtNs8s35T2+KfcdaDProbZVfpJpsxgJyPj5a+6fAalNdVtpWNtzqjBEVaw44Y1fhfkOiBsBaHSyjAltIRqkrShUoj4AgLxR3hyuajabJsjbyab117M+A5QLS/k";
    String s8 =
        "PkXxoa81XEPH31RRpZz0Abj6aPaYp6jWmxWkfzW3NYXH9SfvPgCqyX7gdrSERmzOYjcVIlL826RtAbYUeYhoZV9CjDJ7tsUBt/Z0wfAfSaGmhtkiFSk8sJF7xIHXwb/b/CjB5mBNpdHkXR62KzQeZw4ml3/oA+bbJC6Ag09m7cWpzeY/vMPgZIKDK232Qbuir";
    String s9 =
        "OSyNnB/gVfvPgCgJze4NU69Rr0hrpadIdR+A9FRls6aoJxHk54RBGHOFVyc/A6wXS14ctdTmBEk8L06efqdJ3wFq4thdG2VMTtMz2hzcxt9U3gVQh01rxVXVLd08yYAjWS33cxeAta9pRVpEUvTCaXHqtuoE9qo7AYmc2azZaz6r2qEXl/egR6anxXQB9FqTl";
    String s10 =
        "6FM7RJpBvTCUjiH/YX5GTC3/EmK5YrmrHq0NFQxePOfSe0z0KaAvabZ5qvSYtVtIQpj0/w7TfoOiK3Ce0osm6XJAdJ5xWjNXQCSYvcxAwZBrPvB8nlHyhdaJ4Bmpx//kwH1nrkhNHLSaDoBuMSKGERcAYXTAJygxdL6G0C+A4/IcCOmNbQ1iMLMj8WaWVMXgC";
    String s11 =
        "FBkbmdYFNtazTPmUzysXUCaAhp4TSL7JuN9RDM5hI5/DEY3wFzRdyEg3FFKdIVuB1uax6P1wvQI4mCraCptpFotnokPbr3O/cAAi1OD2gjE1lzS57rVR7+zoo/A/SMrnmvzzAbsMmYKS2A7J9/mX0FgKhu1iPr0eGW9FZF0qOJe+wC/Hv9v1z/CQAA///V7lX";
    String s12 = "R9bwWHwAAAABJRU5ErkJggg==";
    String base64String =
        s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8 + s9 + s10 + s11 + s12;

    imageBytes = base64Decode(base64String);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              makeInvitation();
              makeQuery();
            },
            child: const Text('query'),
          ),
          Image.memory(imageBytes),
        ],
      ),
    );
  }
}
