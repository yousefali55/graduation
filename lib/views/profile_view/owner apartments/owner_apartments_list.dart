import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/views/profile_view/owner%20apartments/data/get_owner_apartments_cubit.dart';
import 'package:graduation/views/profile_view/owner%20apartments/data/get_owner_apartments_states.dart';
import 'package:graduation/views/profile_view/owner%20apartments/delete%20apartments/delete_apartment_cubit.dart';
import 'package:graduation/views/profile_view/owner%20apartments/edit%20owner%20apartments/edit_owner_apartments.dart';
import '../../../spacing/spacing.dart';
import '../../../theming/colors_manager.dart';
import '../../home_view/data/apartments_model.dart';
import 'delete apartments/delete_apartment_states.dart';

class OwnerApartmentsList extends StatelessWidget {
  const OwnerApartmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetOwnerApartmentsCubit>().fetchApartments();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Center(
            child: Text(
              'Owner Apartments',
              style: GoogleFonts.sora(
                color: ColorsManager.mainGreen,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          backgroundColor: ColorsManager.white,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Published'),
              Tab(text: 'Pending'),
            ],
            labelColor: ColorsManager.mainGreen,
            indicatorColor: ColorsManager.mainGreen,
          ),
        ),
        body:
            BlocListener<DeleteOwnerApartmentCubit, DeleteOwnerApartmentState>(
          listener: (context, state) {
            if (state is DeleteOwnerApartmentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: ColorsManager.mainGreen,
                  content: Text('Apartment deleted successfully'),
                ),
              );
              context.read<GetOwnerApartmentsCubit>().fetchApartments();
            } else if (state is DeleteOwnerApartmentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: BlocBuilder<GetOwnerApartmentsCubit, GetOwnerApartmentsState>(
            builder: (context, state) {
              if (state is GetOwnerApartmentsSuccess) {
                final publishedApartments = state.apartments
                    .where((apartment) => apartment.status == 'published')
                    .toList();
                final pendingApartments = state.apartments
                    .where((apartment) => apartment.status == 'pending')
                    .toList();

                return TabBarView(
                  children: [
                    _buildApartmentList(context, publishedApartments),
                    _buildApartmentList(context, pendingApartments),
                  ],
                );
              } else if (state is GetOwnerApartmentsFailure) {
                return Center(
                  child:
                      Text('Failed to load apartments: ${state.errorMessage}'),
                );
              } else if (state is GetOwnerApartmentsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.mainGreen,
                  ),
                );
              } else {
                return Center(
                    child: Text(
                  'No apartments available',
                  style: GoogleFonts.sora(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildApartmentList(
      BuildContext context, List<ApartmentModel> apartments) {
    if (apartments.isEmpty) {
      return Center(
          child: Text(
        'No apartments available',
        style: GoogleFonts.sora(
          fontSize: 18,
          color: Colors.grey,
        ),
      ));
    }

    return RefreshIndicator(
      color: ColorsManager.mainGreen,
      onRefresh: () async {
        context.read<GetOwnerApartmentsCubit>().fetchApartments();
      },
      child: ListView.builder(
        itemCount: apartments.length,
        itemBuilder: (context, index) {
          final apartment = apartments[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditOwnerApartmentView(
                    apartment: apartment,
                  ),
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
                          child: CachedNetworkImage(
                            imageUrl: apartment.photos.isNotEmpty
                                ? apartment.photos[0].photo
                                : 'https://i0.wp.com/sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png?ssl=1',
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: ColorsManager.mainGreen,
                              ),
                            ),
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
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  right: 30,
                  top: 240,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Confirm Deletion',
                              style: TextStyle(
                                color: ColorsManager.mainGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              'Are you sure you want to delete this apartment?',
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  'Cancel',
                                  style:
                                      TextStyle(color: ColorsManager.mainGreen),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.red,
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<DeleteOwnerApartmentCubit>()
                                      .deleteApartment(apartment.id);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
