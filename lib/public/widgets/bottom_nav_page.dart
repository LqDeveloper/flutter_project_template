import 'package:flutter/material.dart';

class TabItem {
  final String label;
  final Widget normalIcon;
  final Widget selectedIcon;
  final int badge;

  const TabItem(
      {required this.label,
      required this.normalIcon,
      required this.selectedIcon,
      this.badge = 0});
}

class BottomNavPage extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onTap;
  final List<Widget> pages;
  final List<TabItem> items;

  const BottomNavPage(
      {Key? key,
      required this.pages,
      required this.items,
      this.initialIndex = 0,
      this.onTap})
      : super(key: key);

  @override
  State<BottomNavPage> createState() => BottomNavPageState();

  static BottomNavPageState of(BuildContext context) {
    final BottomNavPageState? result =
        context.findAncestorStateOfType<BottomNavPageState>();
    if (result != null) {
      return result;
    }
    throw FlutterError("can not get BottomNavPageState");
  }
}

class BottomNavPageState extends State<BottomNavPage> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (cxt, index) => widget.pages[index],
        controller: _pageController,
        itemCount: widget.items.length,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: List.generate(widget.items.length, (index) {
          return BottomNavigationBarItem(
              icon: Badge(
                  selected: _currentIndex == index,
                  badge: widget.items[index].badge,
                  normalIcon: widget.items[index].normalIcon,
                  selectedIcon: widget.items[index].selectedIcon),
              label: widget.items[index].label);
        }),
        onTap: widget.onTap,
      ),
    );
  }

  void jumpToPage(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }
}

class Badge extends StatelessWidget {
  final int badge;
  final Widget normalIcon;
  final Widget selectedIcon;
  final bool selected;

  const Badge(
      {Key? key,
      required this.selected,
      required this.badge,
      required this.normalIcon,
      required this.selectedIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: selected ? selectedIcon : normalIcon),
        Positioned(
          top: 0,
          right: 0,
          child: Offstage(
            offstage: badge == 0,
            child: Container(
              alignment: Alignment.center,
              height: 20,
              constraints: const BoxConstraints(minWidth: 20, maxWidth: 80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.red),
              child: Text(
                '$badge',
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
