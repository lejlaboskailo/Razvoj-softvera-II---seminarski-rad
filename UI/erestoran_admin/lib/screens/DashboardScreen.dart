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
    // Dodajte navigaciju na ekran za Uposlenike
    // Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeesScreen()));
  }

  void _navigateToMenu(BuildContext context) {
    // Dodajte navigaciju na ekran za Meni
    // Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()));
  }

  void _navigateToOrders(BuildContext context) {
    // Dodajte navigaciju na ekran za Narudžbe
    // Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersScreen()));
  }

  void _navigateToReports(BuildContext context) {
    // Dodajte navigaciju na ekran za Izvještaje
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsScreen()));
  }

  void _navigateToNotifications(BuildContext context) {
    // Dodajte navigaciju na ekran za Obavijesti
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
  }

  void _navigateToFeedback(BuildContext context) {
    // Dodajte navigaciju na ekran za Dojmove
    // Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen()));
  }

  void _navigateToData(BuildContext context) {
    // Dodajte navigaciju na ekran za Podatke
    // Navigator.push(context, MaterialPageRoute(builder: (context) => DataScreen()));
  }

  void _logout(BuildContext context) {
    // Dodajte kod za odjavu
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
