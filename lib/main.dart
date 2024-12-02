import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/paper_provider.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/details_screen.dart';

void main() {
  runApp(const ResearchHubApp());
}

class ResearchHubApp extends StatelessWidget {
  const ResearchHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PaperProvider(), // Your provider class
        ),
        // Add any other providers here
      ],
      child: MaterialApp(
      title: 'Research Hub',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/detail': (context) => const DetailsScreen(),
      },
      debugShowCheckedModeBanner: false,
    )
    );

  }
}
