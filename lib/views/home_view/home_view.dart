import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/apartments_details_view/apartment_details.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';
import 'package:graduation/views/home_view/widgets/list_apartments.dart';
import 'package:graduation/views/home_view/widgets/floating_button.dart';
import 'package:graduation/views/profile_view/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const ListApartment(), // Screen for Home icon
      const Center(child: Text('Explore')), // Screen for Explore icon
      _buildFavoritesScreen(context), // Screen for Favorites icon
      const ProfileView(), // Screen for Profile icon
    ];
  }

  Widget _buildFavoritesScreen(BuildContext context) {
    return BlocBuilder<GetApartmentsCubit, GetApartmentsState>(
      builder: (context, state) {
        if (state is GetApartmentsSuccess) {
          final favoritesList = state.favorites;
          return ListView.builder(
            itemCount: favoritesList.length,
            itemBuilder: (BuildContext context, int index) {
              final apartment = favoritesList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ApartmentDetailsView(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(apartment.title),
                    subtitle: Text('L.E ${apartment.price}/mo'),
                    trailing: IconButton(
                      icon: Icon(
                        apartment.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red, // Change color if favorite
                      ),
                      onPressed: () {
                        if (apartment.isFavorite) {
                          context
                              .read<GetApartmentsCubit>()
                              .removeFromFavorites(apartment);
                        } else {
                          context
                              .read<GetApartmentsCubit>()
                              .addToFavorites(apartment);
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('No favorites yet'),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 3
          ? AppBar(
              backgroundColor: Colors.white,
              title: const Text('Profile'),
            )
          : AppBar(
              title: const Text('Home'),
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
      floatingActionButton: const HomeViewFloatingButton(),
    );
  }
}
