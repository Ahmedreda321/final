// import 'package:flutter/material.dart';
// import 'package:sports/presentation/screens/countries_screen.dart';
// import 'package:sports/presentation/screens/leagued_detail_screen.dart';

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class LeaguesScreen extends StatelessWidget {
//   final Country country;

//   LeaguesScreen({required this.country});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Leagues')),
//       body: FutureBuilder(
//         future: fetchLeagues(country),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<League> leagues = snapshot.data as List<League>;
//             return ListView.builder(
//               itemCount: leagues.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(leagues[index].name),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LeagueDetailScreen(league: leagues[index]),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// Future<List<League>> fetchLeagues(Country country) async {
//   final response = await http.get(Uri.parse('API_URL'));
//   if (response.statusCode == 200) {
//     // Parse response and return list of leagues
//   } else {
//     throw Exception('Failed to load leagues');
//   }
// }

// class League {
//   final String name;

//   League({required this.name});

//   factory League.fromJson(Map<String, dynamic> json) {
//     return League(
//       name: json['name'],
//     );
//   }
// }

// class LeagueDetailScreen extends StatelessWidget {
//   final League league;

//   LeagueDetailScreen({required this.league});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(league.name),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: FutureBuilder(
//           future: fetchLeagueDetails(league),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               var leagueDetails = snapshot.data as LeagueDetails;
//               return SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     PromotionalBanner(
//                       text: "Get the Latest League Updates and Standings!",
//                     ),
//                     SizedBox(height: 16.0),
//                     Text(
//                       'League Name: ${leagueDetails.name}',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Current Season: ${leagueDetails.seasonYear}',
//                       style: TextStyle(fontSize: 18, color: Colors.grey),
//                     ),
//                     SizedBox(height: 16.0),
//                     Text(
//                       'Standings:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     for (var team in leagueDetails.standings)
//                       ListTile(
//                         title: Text(team['team']),
//                         trailing: Text(team['points'].toString()),
//                       ),
//                     SizedBox(height: 16.0),
//                     Text(
//                       'Recent Results:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     for (var result in leagueDetails.recentResults)
//                       ListTile(
//                         title: Text('${result['teamA']} ${result['score']} ${result['teamB']}'),
//                       ),
//                     SizedBox(height: 16.0),
//                     Text(
//                       'Upcoming Matches:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     for (var match in leagueDetails.upcomingMatches)
//                       ListTile(
//                         title: Text('${match['teamA']} vs ${match['teamB']}'),
//                         subtitle: Text(match['date']),
//                       ),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class PromotionalBanner extends StatelessWidget {
//   final String text;

//   PromotionalBanner({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       color: Colors.blue,
//       child: Text(
//         text,
//         style: TextStyle(color: Colors.white, fontSize: 16),
//       ),
//     );
//   }
// }

// Future<LeagueDetails> fetchLeagueDetails(League league) async {
//   final response = await http.get(Uri.parse('API_URL/${league}'));
//   if (response.statusCode == 200) {
//     // Parse response and return league details
//     return LeagueDetails.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to load league details');
//   }
// }

// class LeagueDetails {
//   final String name;
//   final String seasonYear;
//   final List<Map<String, dynamic>> standings;
//   final List<Map<String, dynamic>> recentResults;
//   final List<Map<String, dynamic>> upcomingMatches;

//   LeagueDetails({
//     required this.name,
//     required this.seasonYear,
//     required this.standings,
//     required this.recentResults,
//     required this.upcomingMatches,
//   });

//   factory LeagueDetails.fromJson(Map<String, dynamic> json) {
//     return LeagueDetails(
//       name: json['name'],
//       seasonYear: json['seasonYear'],
//       standings: List<Map<String, dynamic>>.from(json['standings']),
//       recentResults: List<Map<String, dynamic>>.from(json['recentResults']),
//       upcomingMatches: List<Map<String, dynamic>>.from(json['upcomingMatches']),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LeaguesScreen extends StatelessWidget {
  final int countryId;

  const LeaguesScreen({super.key, required this.countryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leagues')),
      body: const Center(child: Text('Leagues')),
    );
  }
}
