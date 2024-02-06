import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../token.dart';
import '../utils/secure_storage.dart';

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
    // Assume SecureStorageUtil is your utility class for secure storage
    String? token =
        await SecureStorageUtil().getToken(); // Fetch token asynchronously
    String? usernameFromToken =
        getUsernameJwt(token); // Parse username from token
    setState(() {
      username = usernameFromToken ?? 'Stranger'; // Update state with username
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.purple,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Findy Wallet | $username"),
        backgroundColor: Colors.purple,
        actions: [
          TextButton(
            onPressed: () {
              context.go('/');
            },
            style: style,
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
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'credentials',
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
