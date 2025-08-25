import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uposlenik Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uposlenik Dashboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DashboardButton(title: 'Uposlenici', onPressed: () => _navigateToEmployees(context)),
                DashboardButton(title: 'Meni', onPressed: () => _navigateToMenu(context)),
                DashboardButton(title: 'Narudžbe', onPressed: () => _navigateToOrders(context)),
                DashboardButton(title: 'Izvještaji', onPressed: () => _navigateToReports(context)),
                DashboardButton(title: 'Obavijesti', onPressed: () => _navigateToNotifications(context)),
                DashboardButton(title: 'Dojmovi', onPressed: () => _navigateToFeedback(context)),
                DashboardButton(title: 'Podaci', onPressed: () => _navigateToData(context)),
                DashboardButton(title: 'Odjava', onPressed: () => _logout(context)),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Your Dashboard Content Goes Here'),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEmployees(BuildContext context) {
  }

  void _navigateToMenu(BuildContext context) {
  }

  void _navigateToOrders(BuildContext context) {
  }

  void _navigateToReports(BuildContext context) {
  }

  void _navigateToNotifications(BuildContext context) {
  }

  void _navigateToFeedback(BuildContext context) {
  }

  void _navigateToData(BuildContext context) {
  }

  void _logout(BuildContext context) {
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const DashboardButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.blue,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
