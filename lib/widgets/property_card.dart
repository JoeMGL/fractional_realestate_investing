import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final String price;
  final String details;

  PropertyCard({required this.price, required this.details});

  void _trackButtonClick() {
    FirebaseAnalytics.instance.logEvent(
      name: 'view_property_button_click',
      parameters: {
        'price': price,
        'details': details,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            price,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(details, style: TextStyle(fontSize: 14)),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _trackButtonClick();
              Navigator.pushNamed(context, '/property-details');
            },
            child: Text('View Property'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
