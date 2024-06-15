import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/favourites_view/favourites_view.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';
import 'package:graduation/views/home_view/widgets/list_apartments.dart';
import 'package:graduation/views/home_view/widgets/floating_button.dart';
import 'package:graduation/views/profile_view/profile_view.dart';
import 'package:flutter/services.dart';
import 'package:graduation/views/search_screen/search_screen.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';

class HomeView extends StatefulWidget {
  final String userType;

  const HomeView({super.key, required this.userType});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  String _searchQuery = '';
  List<ApartmentModel> _allApartments = [];

  @override
  void initState() {
    super.initState();
    context.read<GetApartmentsCubit>().fetchApartments();
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future<void> _refreshApartments() async {
    await context.read<GetApartmentsCubit>().fetchApartments();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      RefreshIndicator(
        color: ColorsManager.mainGreen,
        onRefresh: _refreshApartments,
        child: const ListApartment(),
      ),
      BlocBuilder<GetApartmentsCubit, GetApartmentsState>(
        builder: (context, state) {
          if (state is GetApartmentsSuccess) {
            _allApartments = state.apartments;
            return SearchScreen(
              apartments: _allApartments,
              query: _searchQuery,
              onSearchChanged: _updateSearchQuery,
            );
          } else {
            return Container();
          }
        },
      ),
      const FavoritesView(),
      const ProfileView(),
    ];

    final List<String> titles = [
      'Home',
      'Search',
      'Favorites',
      'Profile',
    ];

    Future<bool> onWillPop() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit the app?'),
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

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Column(
          children: [
            heightSpace(15),
            _currentIndex == 1
                ? _buildSearchField()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widthSpace(48),
                      Center(
                        child: Text(
                          titles[_currentIndex],
                          style: GoogleFonts.sora(
                            fontSize: 20,
                            color: ColorsManager.mainGreen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
                          icon: SvgPicture.asset(
                            'images/svgs/search-normal.svg',
                          ))
                    ],
                  ),
            Expanded(child: screens[_currentIndex]),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
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

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsManager.mainGreen)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: ColorsManager.darkGrey),
                ),
                hintText: 'Search...',
                prefixIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    'images/svgs/search-normal.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                _updateSearchQuery(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _currentIndex = 0;
                _searchQuery = '';
              });
            },
          ),
        ],
      ),
    );
  }
}
