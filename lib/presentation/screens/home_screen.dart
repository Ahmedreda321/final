// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:sports_2/presentation/screens/countries_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffb26243c),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
            color: Colors.white), // Change drawer icon color to white
      ),
      body: const HomeBody(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: const Color(0xffb26243c),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              'User Name',
              style: TextStyle(color: Colors.white, fontFamily: 'K2D'),
            ),
            accountEmail: Text(
              'user@example.com',
              style: TextStyle(color: Colors.white, fontFamily: 'K2D'),
            ),
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontFamily: 'K2D'),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      content: const Text(
        'Are you sure you want to logout?',
        style: TextStyle(color: Colors.black, fontFamily: 'K2D'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontFamily: 'K2D'),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text(
            'Logout',
            style: TextStyle(fontFamily: 'K2D'),
          ),
        ),
      ],
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          const Text(
            'What sport do you interest?',
            style: TextStyle(
              fontFamily: 'K2D',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 350,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 50,
              crossAxisSpacing: 90,
              children: const <Widget>[
                SportWidget(
                  sportName: 'Football',
                  iconPath: 'assets/images/football.png',
                ),
                SportWidget(
                  sportName: 'Basketball',
                  iconPath: 'assets/images/basketball.png',
                ),
                SportWidget(
                  sportName: 'Cricket',
                  iconPath: 'assets/images/Cricket.png',
                ),
                SportWidget(
                  sportName: 'Tennis',
                  iconPath: 'assets/images/Tennis.png',
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class SportWidget extends StatelessWidget {
  final String sportName;
  final String iconPath;

  const SportWidget(
      {super.key, required this.sportName, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.07,
                  child: Image.asset(fit: BoxFit.scaleDown, iconPath)),
              const SizedBox(height: 10),
              Text(
                sportName,
                style: const TextStyle(
                  fontFamily: 'K2D',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CountriesScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _handleTap(BuildContext context) async {
    if (sportName == 'Football') {
      Navigator.of(context).push(_createRoute());
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text(
            'Coming soon',
            textAlign: TextAlign.center,
          ),
          contentTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'K2D',
          ),
        ),
      );
    }
  }
}
