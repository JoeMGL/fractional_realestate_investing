import 'package:flutter/material.dart';


class PropertyDetailScreen extends StatelessWidget {
  
  const PropertyDetailScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Container(
              height: 250,
              width: double.infinity,
              child: PageView(
                children: [
                  Image.network(
                    'https://via.placeholder.com/600x300', // Replace with the actual image URL
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://via.placeholder.com/600x300',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4 bed, 2.5 bath house',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'San Francisco, CA',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Property Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  PropertyDetailsTable(),
                  SizedBox(height: 16),
                  Text(
                    'Historical Value',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Home Value',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$2,300,000',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Last 10 Years',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[200], // Placeholder for chart
                    child: Center(child: Text('Chart Placeholder')),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Share Purchase Options',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShareOptionButton(label: '\$25'),
                      ShareOptionButton(label: '\$50'),
                      ShareOptionButton(label: '\$100'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Investment Calculator',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      items: ['Option 1', 'Option 2']
                          .map((String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (_) {},
                      hint: Text('Select an option'),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Invest Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyDetailsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          TableCell(child: PropertyDetailCell(title: 'Year Built', value: '1987')),
          TableCell(child: PropertyDetailCell(title: 'Sq Ft', value: '3,000')),
        ]),
        TableRow(children: [
          TableCell(child: PropertyDetailCell(title: 'Lot Size', value: '2,500')),
          TableCell(child: PropertyDetailCell(title: 'Bedrooms', value: '4')),
        ]),
        TableRow(children: [
          TableCell(child: PropertyDetailCell(title: 'Bathrooms', value: '2.5')),
          TableCell(child: PropertyDetailCell(title: 'Parking', value: '2')),
        ]),
      ],
    );
  }
}

class PropertyDetailCell extends StatelessWidget {
  final String title;
  final String value;

  PropertyDetailCell({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class ShareOptionButton extends StatelessWidget {
  final String label;

  ShareOptionButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}