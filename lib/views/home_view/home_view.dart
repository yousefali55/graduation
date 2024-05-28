import 'package:flutter/material.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/favourites_view/favourites_view.dart';
import 'package:graduation/views/home_view/widgets/list_apartments.dart';
import 'package:graduation/views/home_view/widgets/floating_button.dart';
import 'package:graduation/views/profile_view/profile_view.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  final String userType;

  const HomeView({super.key, required this.userType});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const ListApartment(), // Screen for Home icon
    const Center(child: Text('Explore')), // Screen for Explore icon
    const FavoritesView(), // Screen for Favorites icon
    const ProfileView(), // Screen for Profile icon
  ];

  final List<String> _titles = [
    'Home',
    'Search',
    'Favorites',
    'Profile',
  ];

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Exit App',
            ),
            content: const Text(
              'Do you want to exit the app?',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No',
                    style: TextStyle(color: ColorsManager.mainGreen)),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes',
                    style: TextStyle(color: ColorsManager.mainGreen)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(_titles[_currentIndex]),
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green, // Adjusted color
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        floatingActionButton:
            widget.userType == 'owner' ? const HomeViewFloatingButton() : null,
      ),
    );
  }
}
