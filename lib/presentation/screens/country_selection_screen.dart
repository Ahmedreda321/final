import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_2/presentation/cubit/country_cubit.dart';
import 'package:sports_2/presentation/cubit/country_state.dart';

class CountrySelectionScreen extends StatelessWidget {
  const CountrySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country'),
      ),
      body: BlocBuilder<CountriesCubit, CountriesState>(
        builder: (context, state) {
          if (state is CountriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CountriesLoaded) {
            return ListView.builder(
              itemCount: state.countries.length,
              itemBuilder: (context, index) {
                final country = state.countries[index];
                return ListTile(
                  title: Text(country.name),
                  leading: Image.network(
                      country.image ??
                          'https://media.wired.com/photos/5b17381815b2c744cb650b5f/master/w_2560%2Cc_limit/GettyImages-134367495.jpg',
                      height: 50,
                      width: 50),
                  onTap: () {
                    // navigate to next screen
                  },
                );
              },
            );
          } else if (state is CountriesError) {
            return Center(
                child: Text('Failed to load countries: ${state.message}'));
          } else {
            return const Center(child: Text('Press button to load countries'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CountriesCubit>().fetchCountries();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
