import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              'Recent Books',
              Icons.book,
              Colors.blue,
              () => print('Recent Books tapped'),
            ),
            _buildDashboardCard(
              'Statistics',
              Icons.bar_chart,
              Colors.green,
              () => print('Statistics tapped'),
            ),
            _buildDashboardCard(
              'Favorites',
              Icons.favorite,
              Colors.red,
              () => print('Favorites tapped'),
            ),
            _buildDashboardCard(
              'Settings',
              Icons.settings,
              Colors.orange,
              () => print('Settings tapped'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}