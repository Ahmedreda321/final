import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_2/presentation/cubit/country_cubit.dart';
import 'package:sports_2/presentation/cubit/location_cubit/get_location_cubit.dart';
import 'package:sports_2/presentation/screens/country_selection_screen.dart';

import 'presentation/screens/home_screen.dart';
import 'presentation/screens/leagues_screen.dart';

import 'data/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = Repository();

    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (context) => Repository()),
        BlocProvider(create: (context) => CountriesCubit(repository)),
        BlocProvider(create: (context) => GetLocationCubitCubit(repository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          // '/country-selection': (context) => const CountrySelectionScreen(),
          '/leagues': (context) => LeaguesScreen(
                countryId: ModalRoute.of(context)!.settings.arguments as int,
              ),
        },
      ),
    );
  }
}
