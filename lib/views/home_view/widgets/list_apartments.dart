import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/apartments_details_view/apartment_details.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';

class ListApartment extends StatelessWidget {
  const ListApartment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetApartmentsCubit, GetApartmentsState>(
      builder: (context, state) {
        if (state is GetApartmentsSuccess) {
          final apartmentsList = state.apartments;
          final favoritesList = context
              .watch<GetApartmentsCubit>()
              .favorites; // Updated to watch favorites

          return SizedBox(
            width: double.infinity,
            child: ListView.builder(
              itemCount: apartmentsList.length,
              itemBuilder: (BuildContext context, int index) {
                final apartment = apartmentsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ApartmentDetailsView(),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  'https://via.placeholder.com/200',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    apartment.title,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  const Text(
                                    'Location not specified',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    apartment.description ??
                                        'No description available',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '\$${apartment.price}/mo',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20.0,
                        right: 20.0,
                        child: IconButton(
                          icon: Icon(
                            favoritesList.contains(apartment)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoritesList.contains(apartment)
                                ? Colors.red // Change color to red if favorite
                                : null, // Use default color if not favorite
                          ),
                          onPressed: () {
                            final cubit = context.read<GetApartmentsCubit>();
                            if (favoritesList.contains(apartment)) {
                              cubit.removeFromFavorites(apartment);
                            } else {
                              cubit.addToFavorites(apartment);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text('Unknown state'),
          );
        }
      },
    );
  }
}
