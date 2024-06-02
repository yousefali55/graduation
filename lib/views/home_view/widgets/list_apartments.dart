import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListApartment extends StatelessWidget {
  const ListApartment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetApartmentsCubit(),
      child: BlocBuilder<GetApartmentsCubit, GetApartmentsState>(
        builder: (context, state) {
          print("Current state: ${state.runtimeType}");
          if (state is GetApartmentsInitial) {
            return ElevatedButton(
                onPressed: () {
                  context.read<GetApartmentsCubit>().fetchApartments();
                },
                child: Text('elyoo'));
          } else if (state is GetApartmentsSuccess) {
            final apartmentsList =
                context.read<GetApartmentsCubit>().apartments;
            return SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: apartmentsList.length,
                itemBuilder: (BuildContext context, int index) {
                  final apartment = apartmentsList[index];
                  return GestureDetector(
                    onTap: () {},
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.network(
                                    'https://via.placeholder.com/200', // Placeholder image URL
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 8.0,
                                  left: 8.0,
                                  child: Row(
                                    children: [
                                      _buildBullet('Beds', apartment.beds ?? 0),
                                      const SizedBox(width: 8.0),
                                      _buildBullet(
                                          'Baths', apartment.bathrooms ?? 0),
                                      const SizedBox(width: 8.0),
                                      _buildBullet(
                                          'Rooms', apartment.rooms ?? 0),
                                    ],
                                  ),
                                ),
                              ],
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
                                  style: TextStyle(
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
                              '\$${apartment.price}/mo', // Corrected to access price
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
                  );
                },
              ),
            );
          } else if (state is GetApartmentsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetApartmentsFailure) {
            return Center(
              child: Text('${state.errorMessage}'),
            );
          } else {
            return FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Loading state
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Error handling
                } else {
                  final SharedPreferences prefs =
                      snapshot.data as SharedPreferences;
                  final String? token =
                      prefs.getString('auth_token'); // Retrieve token
                  if (token != null) {
                    return Center(
                      child: Text('Token: $token'), // Display the token
                    );
                  } else {
                    return Center(
                      child: Text('Token not found'), // No token available
                    );
                  }
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildBullet(String label, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 2.0),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
