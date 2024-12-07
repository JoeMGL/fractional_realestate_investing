import 'package:flutter/material.dart';
import './pages/users_view.dart';
import './pages/properties_view.dart';

import './pages/investments_view.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  String _currentView = 'properties'; // Default view

  Widget _buildMainContent() {
    if (_currentView == 'users') {
      return UsersView();
    } else if (_currentView == 'investments') {
      return InvestmentsView();
    } else {
      // Default to properties view
      return PropertiesView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Panel',
          style: TextStyle(color: Colors.white), // Title in white
        ),
        backgroundColor: Colors.black87,
        iconTheme:
            const IconThemeData(color: Colors.white), // Hamburger icon in white
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.people, color: Colors.white),
                title: const Text('Users', style: TextStyle(color: Colors.white)),
                selected: _currentView == 'users',
                selectedTileColor: Colors.grey[800],
                onTap: () {
                  setState(() {
                    _currentView = 'users';
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title:
                    const Text('Properties', style: TextStyle(color: Colors.white)),
                selected: _currentView == 'properties',
                selectedTileColor: Colors.grey[800],
                onTap: () {
                  setState(() {
                    _currentView = 'properties';
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.white),
                title:
                    const Text('Investments', style: TextStyle(color: Colors.white)),
                selected: _currentView == 'investments',
                selectedTileColor: Colors.grey[800],
                onTap: () {
                  setState(() {
                    _currentView = 'investments';
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildMainContent(),
        ),
      ),
    );
  }
}
