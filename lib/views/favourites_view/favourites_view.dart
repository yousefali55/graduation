import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/apartments_details_view/apartment_details.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetApartmentsCubit, GetApartmentsState>(
      builder: (context, state) {
        if (state is GetApartmentsSuccess) {
          final favoritesList = state.favorites;
          if (favoritesList.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          return ListView.builder(
            itemCount: favoritesList.length,
            itemBuilder: (BuildContext context, int index) {
              final apartment = favoritesList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ApartmentDetailsView()));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: ListTile(
                    title: Text(apartment.title),
                    subtitle: Text('L.E ${apartment.price}/mo'),
                    // trailing: IconButton(
                    //   icon: Icon(
                    //       apartment.isFavorite
                    //           ? Icons.favorite
                    //           : Icons.favorite_border,
                    //       color: apartment.isFavorite ? Colors.red : null),
                    //   onPressed: () async {
                    //     final cubit = context.read<GetApartmentsCubit>();
                    //     SharedPreferences prefs =
                    //         await SharedPreferences.getInstance();
                    //     String? token =
                    //         prefs.getString('auth_token'); // Retrieve token
                    //     if (token == null) {
                    //       // Handle token not found error (e.g., show a message to the user)
                    //       return;
                    //     }
                    //     cubit.toggleFavorite(apartment);
                    //   },
                    // ),
                  ),
                ),
              );
            },
          );
        } else if (state is GetApartmentsLoading) {
          return const Center(
              child: CircularProgressIndicator(color: ColorsManager.mainGreen));
        } else if (state is GetApartmentsFailure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const Center(child: Text('No favorites yet'));
        }
      },
    );
  }
}
