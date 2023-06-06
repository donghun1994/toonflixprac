import 'package:carrot/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottonNavitionBarWidget(),
    );
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return const Home();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return Container();
    }
    return Container();
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/svg/${iconName}_off.svg",
          width: 22,
        ),
        label: label,
        activeIcon: SvgPicture.asset(
          "assets/svg/${iconName}_on.svg",
          width: 22,
        ));
  }

  Widget _bottonNavitionBarWidget() {
    return BottomNavigationBar(
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.black,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          _bottomNavigationBarItem('home', '홈'),
          _bottomNavigationBarItem('notes', '동네 생활'),
          _bottomNavigationBarItem('location', '내 근처'),
          _bottomNavigationBarItem('chat', '채팅'),
          _bottomNavigationBarItem('user', '나의 당근'),
        ]);
  }
}
