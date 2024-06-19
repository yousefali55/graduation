import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/apartments_details_view/apartment_details.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';

class ListApartment extends StatelessWidget {
  const ListApartment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetApartmentsCubit, GetApartmentsState>(
      builder: (context, state) {
        if (state is GetApartmentsSuccess) {
          return ListView.builder(
            itemCount: state.apartments.length,
            itemBuilder: (context, index) {
              final apartment = state.apartments[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ApartmentDetailsView(apartment: apartment),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
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
                              child: CachedNetworkImage(
                                imageUrl: apartment.photos.isNotEmpty
                                    ? apartment.photos[0].photo
                                    : 'https://i0.wp.com/sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png?ssl=1',
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                        color: ColorsManager.mainGreen)),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
                                heightSpace(10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.bed,
                                      size: 30,
                                      color: ColorsManager.mainGreen,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      '${apartment.beds}',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                    const SizedBox(width: 12.0),
                                    const Icon(
                                      Icons.bathtub,
                                      size: 27,
                                      color: ColorsManager.mainGreen,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      '${apartment.bathrooms}',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Icon(
                                      Icons.bedroom_parent,
                                      size: 30,
                                      color: ColorsManager.mainGreen,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      '${apartment.rooms}',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                heightSpace(16),
                                Text(
                                  apartment.title,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  apartment.address,
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'L.E ${apartment.price}/mo',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          heightSpace(10),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 260.0,
                      right: 20.0,
                      child: IconButton(
                        icon: Icon(
                          apartment.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: apartment.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          final cubit = context.read<GetApartmentsCubit>();
                          cubit.toggleFavorite(apartment);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is GetApartmentsFailure) {
          return Center(
              child: Text('Failed to load apartments: ${state.errorMessage}'));
        } else if (state is GetApartmentsLoading) {
          return const Center(
              child: CircularProgressIndicator(color: ColorsManager.mainGreen));
        } else {
          return const Center(child: Text('No apartments available'));
        }
      },
    );
  }
}
