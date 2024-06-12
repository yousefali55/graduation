import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/profile_view/owner%20apartments/data/get_owner_apartments_cubit.dart';
import 'package:graduation/views/profile_view/owner%20apartments/data/get_owner_apartments_states.dart';
import 'edit_owner_apartments.dart';

class OwnerApartmentsView extends StatelessWidget {
  const OwnerApartmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Apartments'),
      ),
      body: BlocBuilder<GetOwnerApartmentsCubit, GetOwnerApartmentsState>(
        builder: (context, state) {
          if (state is GetOwnerApartmentsLoading) {
            return const Center(
                child:
                    CircularProgressIndicator(color: ColorsManager.mainGreen));
          } else if (state is GetOwnerApartmentsSuccess) {
            return ListView.builder(
              itemCount: state.apartments.length,
              itemBuilder: (context, index) {
                final apartment = state.apartments[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: apartment.photos.isNotEmpty
                        ? apartment.photos[0].photo
                        : 'https://i0.wp.com/sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png?ssl=1', // Placeholder image
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(apartment.title),
                  subtitle: Text('L.E ${apartment.price}/mo'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditApartmentView(apartment: apartment),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<GetOwnerApartmentsCubit>()
                              .deleteApartment(apartment.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is GetOwnerApartmentsFailure) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text("No apartments yet"));
          }
        },
      ),
    );
  }
}
