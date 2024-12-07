import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertiesView extends StatefulWidget {
  @override
  _PropertiesViewState createState() => _PropertiesViewState();
}

class _PropertiesViewState extends State<PropertiesView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addProperty() async {
    if (_nameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    try {
      await _firestore.collection('properties').add({
        'name': _nameController.text.trim(),
        'location': _locationController.text.trim(),
        'price': _priceController.text.trim(),
        'created_at': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Property added successfully')),
      );
      _nameController.clear();
      _locationController.clear();
      _priceController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding property: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add Property Form
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Property',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Property Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addProperty,
                child: Text('Add Property'),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey), // Divider between form and list
        SizedBox(height: 8),
        // Properties List
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('properties').orderBy('created_at', descending: true).snapshots(),
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

              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  final propertyData = doc.data() as Map<String, dynamic>;
                  return Card(
                    color: Colors.grey[900],
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: ListTile(
                      title: Text(
                        propertyData['name'] ?? 'No Name',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Location: ${propertyData['location'] ?? 'No Location'} | Price: ${propertyData['price'] ?? 'No Price'}',
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          try {
                            await doc.reference.delete();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Property deleted successfully')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error deleting property: $e')),
                            );
                          }
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
