import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/token.dart';
import '../utils/secure_storage.dart';
import '../screens/scan_screen.dart';

class NavigationScreenOutline extends StatefulWidget {
  const NavigationScreenOutline({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<NavigationScreenOutline> createState() =>
      _NavigationScreenOutlineState();
}

class _NavigationScreenOutlineState extends State<NavigationScreenOutline> {
  String username = 'Stranger'; // Default username

  @override
  void initState() {
    super.initState();
    _fetchAndSetUsername();
  }

  Future<void> _fetchAndSetUsername() async {
    String? token = await SecureStorageUtil().getToken();
    String? usernameFromToken = getUsernameJwt(token);
    setState(() {
      username = usernameFromToken ?? 'Stranger';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Credi",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: const Tooltip(
              message: "Log out",
              child: Icon(Icons.logout_rounded),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.child.currentIndex,
        onTap: (index) {
          if (index == 2) {
            cameraController.start();
          } else {
            cameraController.stop();
          }
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'receipts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
