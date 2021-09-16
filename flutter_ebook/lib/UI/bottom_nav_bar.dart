import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ebook/UI/bookshelf/bookshelf_screen.dart';
import 'package:flutter_ebook/UI/home/home_screen.dart';
import 'package:flutter_ebook/UI/profile/profile_screen.dart';
import 'package:flutter_ebook/UI/search/search_screen.dart';
import 'package:flutter_ebook/utils/constant.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late CupertinoTabBar tabBar = CupertinoTabBar(items: tabItems);

  late List<BottomNavigationBarItem> tabItems = [
    buildItem(
        icon: CupertinoIcons.square_list,
        activeIcon: CupertinoIcons.square_list_fill),
    buildItem(icon: CupertinoIcons.search),
    buildItem(icon: CupertinoIcons.book, activeIcon: CupertinoIcons.book_fill),
    buildItem(icon: CupertinoIcons.bars)
  ];
  List<Widget> children = [
    HomeScreen(),
    SearchScreen(),
    BookshelfScreen(),
    ProfileScreen()
  ];

  buildItem({required IconData icon, IconData? activeIcon}) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: kWhiteColor.withOpacity(0.15),
          size: 24,
        ),
        activeIcon: Icon(
          activeIcon ?? icon,
          color: kWhiteColor,
          size: 24,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: tabBar,
      tabBuilder: (context, index) => IndexedStack(
        index: index,
        children: children,
      ),
    );
  }
}
