import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class PropertyListItem extends StatelessWidget {
  final String name;
  final String location;

  PropertyListItem({required this.name, required this.location});

  // Function to track button clicks
  void _trackBuySharesClick() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'buy_shares_click',
      parameters: {
        'property_name': name,
        'property_location': location,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(location),
      trailing: ElevatedButton(
        onPressed: () {
          _trackBuySharesClick();
          // Add your navigation or purchase logic here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Buy Shares clicked for $name')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
        ),
        child: const Text('Buy Shares'),
      ),
    );
  }
}
