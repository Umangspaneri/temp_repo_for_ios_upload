// import 'package:eqb_ltd/about.dart';
// import 'package:eqb_ltd/cont.dart';
// import 'package:eqb_ltd/home.dart';
// import 'package:eqb_ltd/port.dart';
// import 'package:eqb_ltd/rental.dart';
// import 'package:eqb_ltd/tenant.dart';
// import 'package:flutter/material.dart';
// //import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
//
//
// class BottomNavBar extends StatefulWidget {
//   final String userName; // Accept user's name as a parameter
//
//   const BottomNavBar({Key? key, required this.userName,}) : super(key: key);
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int _page = 0; // Tracks the currently selected page
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       bottomNavigationBar: CurvedNavigationBar(
//         key: _bottomNavigationKey,
//         index: 0, // Start with the first tab (Home)
//         items: [
//           CurvedNavigationBarItem(
//             child: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           CurvedNavigationBarItem(
//             child: Icon(Icons.add_business_outlined),
//             label: 'Tenant',
//           ),
//           CurvedNavigationBarItem(
//             child: Icon(Icons.people),
//             label: 'About',
//           ),
//           CurvedNavigationBarItem(
//             child: Icon(Icons.file_copy),
//             label: 'Portfolio',
//           ),
//           CurvedNavigationBarItem(
//             child: Icon(Icons.call),
//             label: 'Contact',
//           ),
//         ],
//         color: Colors.white,
//         buttonBackgroundColor: Colors.grey[100],
//         backgroundColor: Colors.blueAccent,
//         animationCurve: Curves.easeInOut,
//         animationDuration: Duration(milliseconds: 500),
//         onTap: (index) {
//           setState(() {
//             _page = index; // Update the page index when a bottom nav item is tapped
//           });
//         },
//         letIndexChange: (index) => true,
//       ),
//       body: _page == 0 ? WebViewPage(userName: widget.userName,) // Show WebView when Home tab is selected
//           : _page == 1 ? ServiceRequestForm() // Show WebView for Tenant
//               : _page == 2 ? about() // Show WebView for About tab
//                   : _page == 3 ? portfolio() // Show WebView for Portfolio tab
//                       : cont(), // Show WebView for Contact tab
//     );
//   }
// }

// //workable code
// import 'package:eqb_ltd/about.dart';
// import 'package:eqb_ltd/cont.dart';
// import 'package:eqb_ltd/home.dart';
// import 'package:eqb_ltd/port.dart';
// import 'package:eqb_ltd/rental.dart';
// import 'package:eqb_ltd/tenant.dart';
// import 'package:flutter/material.dart';
// //import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
//
// class BottomNavBar extends StatefulWidget {
//   final String userName; // Accept user's name as a parameter
//   const BottomNavBar({Key? key, required this.userName,}) : super(key: key);
//
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int _page = 0; // Tracks the currently selected page
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: false, // Prevents body from extending behind nav bar
//
//       bottomNavigationBar: SafeArea(
//         child: CurvedNavigationBar(
//           key: _bottomNavigationKey,
//           index: 0, // Start with the first tab (Home)
//           items: [
//             CurvedNavigationBarItem(
//               child: Icon(Icons.home_outlined),
//               label: 'Home',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.add_business_outlined),
//               label: 'Tenant',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.people),
//               label: 'About',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.file_copy),
//               label: 'Portfolio',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.call),
//               label: 'Contact',
//             ),
//           ],
//           backgroundColor: Color(0xFF2E7D32), // Deep green
//           color: Color(0xFFE8F5E8), // Very light green
//           buttonBackgroundColor: Color(0xFF81C784), // M
//
//           animationCurve: Curves.easeInOut,
//           animationDuration: Duration(milliseconds: 500),
//           onTap: (index) {
//             setState(() {
//               _page = index; // Update the page index when a bottom nav item is tapped
//             });
//           },
//           letIndexChange: (index) => true,
//         ),
//       ),
//
//       body: SafeArea(
//         child: _page == 0
//             ? WebViewPage() // Show WebView when Home tab is selected
//             : _page == 1 ? ServiceRequestForm() // Show WebView for Tenant
//             : _page == 2 ? about() // Show WebView for About tab
//             : _page == 3 ? portfolio() // Show WebView for Portfolio tab
//             : cont(), // Show WebView for Contact tab
//       ),
//     );
//   }
// }
//

//merge drawer in this
//
// import 'package:eqb_ltd/about.dart';
// import 'package:eqb_ltd/cont.dart';
// import 'package:eqb_ltd/home.dart';
// import 'package:eqb_ltd/port.dart';
// import 'package:eqb_ltd/tenant.dart';
// import 'package:flutter/material.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
//
// class BottomNavBar extends StatefulWidget {
//   final String userName; // Accept user's name as a parameter
//   const BottomNavBar({
//     Key? key,
//     required this.userName,
//   }) : super(key: key);
//
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int _page = 0; // Tracks the currently selected page
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//
//   Widget _buildDrawer() {
//     return Drawer(
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFC8E6C9), Color(0xFFF1F8E9)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   child: Image.asset(
//                     'images/logo.jpg',
//                     fit: BoxFit.contain,
//                     height: 100,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text('Home'),
//               onTap: () {
//                 setState(() {
//                   _page = 0;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.add_business),
//               title: Text('Tenant'),
//               onTap: () {
//                 setState(() {
//                   _page = 1;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.people),
//               title: Text('About'),
//               onTap: () {
//                 setState(() {
//                   _page = 2;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.file_copy),
//               title: Text('Portfolio'),
//               onTap: () {
//                 setState(() {
//                   _page = 3;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.call),
//               title: Text('Contact'),
//               onTap: () {
//                 setState(() {
//                   _page = 4;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//       ),
//
//       drawer: _buildDrawer(),
//       extendBody: false,
//       // Prevents body from extending behind nav bar
//
//       bottomNavigationBar: SafeArea(
//         child: CurvedNavigationBar(
//           key: _bottomNavigationKey,
//           index: 0,
//           // Start with the first tab (Home)
//           items: [
//             CurvedNavigationBarItem(
//               child: Icon(Icons.home_outlined),
//               label: 'Home',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.add_business_outlined),
//               label: 'Tenant',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.people),
//               label: 'About',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.file_copy),
//               label: 'Portfolio',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.call),
//               label: 'Contact',
//             ),
//           ],
//           backgroundColor: Color(0xFF2E7D32),
//           // Deep green
//           color: Color(0xFFE8F5E8),
//           // Very light green
//           buttonBackgroundColor: Color(0xFF81C784),
//           // M
//
//           animationCurve: Curves.easeInOut,
//           animationDuration: Duration(milliseconds: 500),
//           onTap: (index) {
//             setState(() {
//               _page =
//                   index; // Update the page index when a bottom nav item is tapped
//             });
//           },
//           letIndexChange: (index) => true,
//         ),
//       ),
//
//       body: SafeArea(
//         child: _page == 0
//             ? WebViewPage() // Show WebView when Home tab is selected
//             : _page == 1
//                 ? ServiceRequestForm() // Show WebView for Tenant
//                 : _page == 2
//                     ? about() // Show WebView for About tab
//                     : _page == 3
//                         ? portfolio() // Show WebView for Portfolio tab
//                         : cont(), // Show WebView for Contact tab
//       ),
//     );
//   }
// }

//test

import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:eqb_ltd/about.dart';
import 'package:eqb_ltd/cont.dart';
import 'package:eqb_ltd/home.dart';
import 'package:eqb_ltd/port.dart';
import 'package:eqb_ltd/tenant.dart';

class BottomNavBar extends StatefulWidget {
  final String userName;
  const BottomNavBar({super.key, required this.userName});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  String currentUser = '';
  bool _isDrawerOpen = false;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  String _getTitle() {
    switch (_page) {
      case 0: return 'Rentpedia';
      case 1: return currentUser.isEmpty ? 'Login' : 'Welcome, $currentUser';
      case 2: return 'About us';
      case 3: return 'Portfolio';
      case 4: return 'Contact us';
      default: return '';
    }
  }
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC8E6C9), Color(0xFFF1F8E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.contain,
                    height: 100,
                  ),
                ),
              ),
            ),
            ...[
              {'icon': Icons.home, 'label': 'Home', 'index': 0},
              {'icon': Icons.add_business, 'label': 'Tenant', 'index': 1},
              {'icon': Icons.people, 'label': 'About', 'index': 2},
              {'icon': Icons.file_copy, 'label': 'Portfolio', 'index': 3},
              {'icon': Icons.call, 'label': 'Contact', 'index': 4},
            ].map((item) => ListTile(
                  leading: Icon(item['icon'] as IconData),
                  title: Text(item['label'] as String),
                  onTap: () {
                    setState(() {
                      _page = item['index'] as int;
                    });
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _page == 0, // Allow pop only on home page
      onPopInvoked: (didPop) {
        if (!didPop && _page != 0) {
          setState(() {
            _page = 0; // Navigate to home tab/page instead of exiting
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [

                if (_page != 1)
                  AppBar(
                    title: Text(_getTitle(), style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                    leading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => setState(() => _isDrawerOpen = !_isDrawerOpen),
                    ),
                  ),

                // Expanded(
                //   child: SafeArea(
                //     top: false,
                //     child: IndexedStack(
                //       index: _page,
                //       children: [
                //         WebViewPage(),
                //         ServiceRequestForm(
                //           onLogin: (name) => setState(() => currentUser = name),
                //         ),
                //         about(),
                //         portfolio(),
                //         cont(),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
  child: SafeArea(
    top: false,
    child: IndexedStack(
      index: _page,
      children: [
        WebViewPage(),
        ServiceRequestForm(
          onLogin: (name) => setState(() => currentUser = name),
        ),
        about(),
        portfolio(),
        cont(),
      ],
    ),
  ),
),


              ],
            ),

            // Compact drawer below AppBar with original styling
            if (_isDrawerOpen)
              Positioned(
                // top: kToolbarHeight + 28,
                top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,

                left: 0,
                width: 250,
                bottom: 0,
                child: Material(
                  elevation: 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFC8E6C9), Color(0xFFF1F8E9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Image.asset(
                                'images/logo.png',
                                fit: BoxFit.contain,
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                        ...[
                          //drawer's
                          {'icon': Icons.home, 'label': 'Home', 'index': 0},
                          { 'icon': Icons.add_business, 'label': 'Tenant', 'index': 1},
                          {'icon': Icons.people, 'label': 'About', 'index': 2},
                          {'icon': Icons.file_copy, 'label': 'Portfolio', 'index': 3},
                          {'icon': Icons.call, 'label': 'Contact', 'index': 4},
                        ].map((item) => ListTile(
                              leading: Icon(item['icon'] as IconData),
                              title: Text(item['label'] as String),
                              onTap: () {
                                setState(() {
                                  _page = item['index'] as int;
                                  _isDrawerOpen = false;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom + 0
          ),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _page,
            items: [
              CurvedNavigationBarItem( child: Icon(Icons.home_outlined), label: 'Home'),
              CurvedNavigationBarItem( child: Icon(Icons.add_business_outlined), label: 'Tenant'),
              CurvedNavigationBarItem( child: Icon(Icons.people), label: 'About'),
              CurvedNavigationBarItem( child: Icon(Icons.file_copy), label: 'Portfolio'),
              CurvedNavigationBarItem( child: Icon(Icons.call), label: 'Contact'),
            ],
            backgroundColor: Color(0xFF2E7D32),
            color: Color(0xFFE8F5E8),
            buttonBackgroundColor: Color(0xFF81C784),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 500),
            onTap: (index) => setState(() => _page = index),
            letIndexChange: (index) => true,
          ),
        ),
      ),
    );
  }
}
