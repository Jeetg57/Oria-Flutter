import 'package:flutter/material.dart';
import 'package:oria/screens/home/home.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

// class HomeMain extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("First Page"),
//           backgroundColor: Colors.green,
//         ),
//         bottomNavigationBar: BottomNavyBar(
//           selectedIndex: _selectedIndex,
//           showElevation: true, // use this to remove appBar's elevation
//           onItemSelected: (index) => setState(() {
//             _selectedIndex = index;
//             _pageController.animateToPage(index,
//                 duration: Duration(milliseconds: 300), curve: Curves.ease);
//           }),
//           items: [
//             BottomNavyBarItem(
//               icon: Icon(Icons.apps),
//               title: Text('Home'),
//               activeColor: Colors.red,
//             ),
//             BottomNavyBarItem(
//                 icon: Icon(Icons.people),
//                 title: Text('Users'),
//                 activeColor: Colors.purpleAccent),
//             BottomNavyBarItem(
//                 icon: Icon(Icons.message),
//                 title: Text('Messages'),
//                 activeColor: Colors.pink),
//             BottomNavyBarItem(
//                 icon: Icon(Icons.settings),
//                 title: Text('Settings'),
//                 activeColor: Colors.blue),
//           ],
//         ),
//         body: Container(),
//       ),
//     );
//   }
// }

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nav Bar"),
        backgroundColor: Colors.green,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              child: Home(),
            ),
            Container(
              child: Text("Doctors Page"),
            ),
            Container(
              child: Text("Hospitals"),
            ),
            Container(
              child: Text("Covid-19"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
              activeColor: Colors.green),
          BottomNavyBarItem(
              title: Text('Doctors'),
              icon: Icon(Icons.person),
              activeColor: Colors.green),
          BottomNavyBarItem(
              title: Text('Hospitals'),
              icon: Icon(Icons.local_hospital),
              activeColor: Colors.green),
          BottomNavyBarItem(
              title: Text('Settings'),
              icon: Icon(Icons.settings),
              activeColor: Colors.green),
        ],
      ),
    );
  }
}
