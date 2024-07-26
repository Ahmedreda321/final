// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_2/data/models/country.dart';
import 'package:sports_2/presentation/cubit/country_cubit.dart';
import 'package:sports_2/presentation/cubit/country_state.dart';
import 'package:sports_2/presentation/cubit/location_cubit/get_location_cubit.dart';

import '../screens/leagues_screen.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  int? selectedCountryId;
  late ScrollController controller;
  @override
  void initState() {
    BlocProvider.of<CountriesCubit>(context).fetchCountries();
    controller = ScrollController();

    super.initState();
  }

  void _animateToItem(int index) {
    final itemSize =
        MediaQuery.of(context).size.width / 3; // Assuming 2 items per row
    final scrollPosition = index * itemSize;
    controller.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToTargetItem(
    int index,
  ) async {
    if (index >= 0 &&
        index < BlocProvider.of<CountriesCubit>(context).countries!.length) {
      double targetOffset = index * 35.0;
      await controller.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      // Handle out-of-bounds index cases (optional)
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetLocationCubitCubit, GetLocationCubitState>(
      listener: (context, state) async {
        if (state is GetLocationCubitSuccess) {
          int index = await getCountryIndex(state.countryName);
          selectedCountryId = index;
          setState(() {});
          scrollToTargetItem(index);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          actions: [
            BlocBuilder<GetLocationCubitCubit, GetLocationCubitState>(
                builder: (context, state) {
              if (state is GetLocationCubitLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return IconButton(
                  onPressed: () async {
                    await BlocProvider.of<GetLocationCubitCubit>(context)
                        .getLocation();
                  },
                  icon: const Icon(Icons.location_on_outlined),
                );
              }
            })
          ],
        ),
        body: BlocBuilder<CountriesCubit, CountriesState>(
          builder: (context, state) {
            if (state is CountriesLoading) {
              return const CountriesShimmer();
            } else if (state is CountriesLoaded) {
              return buildCountriesLoaded(state);
            } else if (state is CountriesError) {
              return const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    'Failed to load countries, check your internet connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'K2D',
                        fontWeight: FontWeight.w900),
                  ),
                ),
              );
            }

            return const Center(
              child: Text('There are no countries available'),
            );
          },
        ),
      ),
    );
  }

  Widget buildCountriesLoaded(CountriesLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildHeaderText(),
          buildCountryGrid(state),
          buildContinueButton(),
        ],
      ),
    );
  }

  Widget buildHeaderText() {
    return const Text(
      'Choose the country of interest:',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'K2D',
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildCountryGrid(CountriesLoaded state) {
    return SizedBox(
      height: 510,
      child: GridView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemCount: state.countries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          final country = state.countries[index];
          final isSelected = selectedCountryId == index;

          return GestureDetector(
            onTap: () => setState(() {
              selectedCountryId = index;
            }),
            child: buildCountryItem(country, isSelected),
          );
        },
      ),
    );
  }

  Widget buildCountryItem(country, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.lightBlueAccent : Colors.grey,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.lightBlueAccent : Colors.grey,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: country.image ??
                  "https://media.wired.com/photos/5b17381815b2c744cb650b5f/master/w_2560%2Cc_limit/GettyImages-134367495.jpg",
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.network(
                "https://media.wired.com/photos/5b17381815b2c744cb650b5f/master/w_2560%2Cc_limit/GettyImages-134367495.jpg",
                height: 40,
                width: 500,
              ),
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          country.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'K2D',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildContinueButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          minimumSize: const Size(250, 50),
          backgroundColor: const Color(0xFF26243C),
        ),
        onPressed: handleContinueButtonPress,
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'K2D',
          ),
        ),
      ),
    );
  }

  void handleContinueButtonPress() {
    if (selectedCountryId == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            content: const Text('Please select a country'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LeaguesScreen(
              countryId: BlocProvider.of<CountriesCubit>(context)
                  .countries![selectedCountryId!]
                  .id),
        ),
      );
    }
  }

  Future<int> getCountryIndex(String countryName) async {
    List<Country> countries =
        BlocProvider.of<CountriesCubit>(context).countries!;
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].name == countryName) {
        return i;
      }
    }
    return 0;
  }
}

class CountriesShimmer extends StatelessWidget {
  const CountriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: 20.0,
              width: 280.0,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 10.0,
                      width: 60.0,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                height: 50.0,
                width: 250.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
