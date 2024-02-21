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
    String? token = await SecureStorageUtil().getToken();
    //print(token);
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
        leadingWidth: 100,
        leading: TextButton(
          child: Text(
            username,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          onPressed: () {
            context.go('/profile');
          },
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
