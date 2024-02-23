import 'package:flutter/material.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              double width = MediaQuery.of(context).size.width;
              return Container(
                height: 200,
                color: Colors.white,
                child: Center(
                  child: SizedBox(
                    width: width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: double
                              .infinity, // Ensure the button takes full width
                          child: ElevatedButton(
                            child: const Text('Request proof'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(
                          width: double
                              .infinity, // Ensure the button takes full width
                          child: ElevatedButton(
                            child: const Text('Send a Proof'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
