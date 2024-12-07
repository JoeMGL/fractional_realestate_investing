import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersView extends StatefulWidget {
  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TabController _tabController;

  String _currentStatusFilter = 'all'; // Default filter

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Stream<QuerySnapshot> _getFilteredUsers() {
    if (_currentStatusFilter == 'all') {
      return _firestore.collection('users').snapshots();
    } else {
      return _firestore
          .collection('users')
          .where('status', isEqualTo: _currentStatusFilter)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tabs for filtering users
        TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Pending'),
            Tab(text: 'Suspended'),
          ],
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  _currentStatusFilter = 'all';
                  break;
                case 1:
                  _currentStatusFilter = 'active';
                  break;
                case 2:
                  _currentStatusFilter = 'pending';
                  break;
                case 3:
                  _currentStatusFilter = 'suspended';
                  break;
              }
            });
          },
        ),
        SizedBox(height: 16),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _getFilteredUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final userDocs = snapshot.data!.docs;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  headingRowColor: MaterialStateProperty.all(Colors.grey[800]),
                  columns: [
                    DataColumn(
                      label: Text('Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Phone', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Signup Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Investment Value', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Investment Count', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: userDocs.map((doc) {
                    final userData = doc.data() as Map<String, dynamic>;

                    return DataRow(
                      cells: [
                        DataCell(Text(userData['name'] ?? 'N/A', style: TextStyle(color: Colors.white))),
                        DataCell(Text(userData['email'] ?? 'N/A', style: TextStyle(color: Colors.white))),
                        DataCell(Text(userData['phone'] ?? 'N/A', style: TextStyle(color: Colors.white))),
                        DataCell(Text(userData['signup_date'] ?? 'N/A', style: TextStyle(color: Colors.white))),
                        DataCell(Text(userData['investment_value'] ?? 'N/A', style: TextStyle(color: Colors.white))),
                        DataCell(Text(userData['investment_count']?.toString() ?? '0', style: TextStyle(color: Colors.white))),
                        DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: userData['status'] == 'active'
                                  ? Colors.green
                                  : userData['status'] == 'pending'
                                      ? Colors.orange
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              userData['status']?.toUpperCase() ?? 'N/A',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
