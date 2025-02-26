import 'package:flutter/material.dart';

class LinePlayerCard extends StatelessWidget {
  const LinePlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Title Text',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Subtitle Text',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.0),
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
          SizedBox(height: 12.0),
        ],
      ),
    );
  }
}