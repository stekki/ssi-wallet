import 'package:flutter/material.dart';

import '../services/graphql_service.dart';
import '../character.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  /*
  void popUntilRoot(BuildContext context) {
    while (context.canPop()) {  
      context.pop();
    }
  }
  */

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();

  List<Character>? characters;

  int num = 0;

  void createList(int page, String name) async {
    characters = await GraphQLService().getCharacters(page, name);
    setState(() {
      num++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 0.8 * width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _pageController,
              decoration: const InputDecoration(labelText: 'Page'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Access the values entered in the text fields
                String name = _nameController.text;
                String page = _pageController.text;

                createList(int.parse(page), name);
              },
              child: const Text('Submit'),
            ),
            characters != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 0.6 * height,
                      child: ListView(
                        shrinkWrap: true,
                        children: characters!
                            .map((e) =>
                                SizedBox(height: 50, child: Text(e.name)))
                            .toList(),
                      ),
                    ),
                  )
                : const Text("No characters")
          ],
        ),
      ),
    );
  }
}
