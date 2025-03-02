import 'package:flutter/material.dart';

class LinePlayerCard extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onTap;
  final String title;
  final String subtitle;

  const LinePlayerCard({
    super.key,
    this.isActive = false,
    this.onTap,
    this.title = 'Title Text',
    this.subtitle = 'Subtitle Text',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: double.infinity,
        height: isActive ? 180.0 : 120.0,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surface.withOpacity(0.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isActive ? 18.0 : 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: isActive ? 15.0 : 14.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: isActive ? 8.0 : 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 24.0,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  iconSize: 24.0,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 24.0,
                  onPressed: () {},
                ), 
              ],
            ),
            SizedBox(height: 6.0),
          ],
        ),
      ),
    );
  }
}