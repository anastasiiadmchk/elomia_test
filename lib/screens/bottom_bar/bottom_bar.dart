import 'package:elomia_test/screens/chat/chat_screen.dart';
import 'package:elomia_test/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElomiaBottomBar extends StatefulWidget {
  /// The tab to display.
  final int? currentIndex;

  /// Returns the index of the tab that was tapped.
  final Function(int)? onTap;

  const ElomiaBottomBar({
    Key? key,
    this.currentIndex,
    this.onTap,
  }) : super(key: key);

  @override
  _ElomiaBottomBarState createState() => _ElomiaBottomBarState();
}

class _ElomiaBottomBarState extends State<ElomiaBottomBar> {
  final chatTab = const ChatScreen();

  @override
  void initState() {
    super.initState();
  }

  Widget _body(int index) {
    switch (index) {
      case 2:
        return chatTab;

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        tabBuilder: (_, index) {
          return _body(index);
        },
        tabBar: CupertinoTabBar(
          currentIndex: 2,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.apps_outlined),
              // activeIcon: Icon(Icons.apps_outlined),
              label: 'Exercises',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph_outlined),
              // activeIcon: Icon(Icons.auto_graph_outlined),
              label: 'Insights',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              // activeIcon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              //activeIcon: Icon(Icons.settin),
              label: 'Settings',
            ),
          ],
          iconSize: 30,
          activeColor: ElomiaTheme.blue,
          backgroundColor: Colors.white,
          border: const Border(top: BorderSide.none),
        ));
  }
}
