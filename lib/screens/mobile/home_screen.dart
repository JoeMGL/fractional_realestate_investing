import 'package:flutter/material.dart';
import 'package:fractional_realestate_investing/widgets/property_card.dart';
import 'package:fractional_realestate_investing/widgets/property_list_item.dart';

import '../../utils/analytics_helper.dart';

class RealEstateScreen extends StatefulWidget {
  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen> {
  @override
  void initState() {
    super.initState();
      AnalyticsHelper.logScreenView('PropertyDetailScreen');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invest in Real Estate',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for a property',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PropertyCard(
                      price: '\$1,000,000', details: '4 bed 3 bath'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: PropertyCard(
                      price: '\$2,000,000', details: '5 bed 4 bath'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Popular Properties',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            PropertyListItem(
                name: 'Hollywood Hills Home', location: 'Los Angeles, CA'),
            PropertyListItem(
                name: 'Mission Bay Condo', location: 'San Francisco, CA'),
            PropertyListItem(name: 'Downtown Loft', location: 'New York, NY'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart), label: 'Portfolio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}
