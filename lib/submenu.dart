import 'package:flutter/material.dart';
import 'package:provider_tut/drawer.dart';

class Submenu extends StatefulWidget {
  @override
  State<Submenu> createState() => _SubmenuState();
}

class _SubmenuState extends State<Submenu> {
  int? selected; //attention

  List dataList = [
    {
      "title": "Payments",
      "icon": Icons.payment,
      "children": [
        {"title": "Paypal"},
        {"title": "Credit Card"},
        {"title": "Debit Card"}
      ]
    },
    {
      "title": "Favorite",
      "icon": Icons.favorite,
      "children": [
        {"title": "Swimming"},
        {"title": "Football"},
        {"title": "Movie"},
        {"title": "Singing"},
        {"title": "Jogging"},
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submenu')),
      body: Center(
          child: ListView.builder(
        key: Key('builder ${selected.toString()}'),
        padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            key: Key(index.toString()), 
            initiallyExpanded: index == selected, 
            trailing: const SizedBox(),
            leading: Icon(
              dataList[index]['icon'],
              color: index == selected ? Colors.black : Colors.grey,
            ),
            title: Text(dataList[index]['title'],
                style: TextStyle(
                    color: index == selected ? Colors.black : Colors.grey,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold)),
            onExpansionChanged: ((newState) {
              if (newState) {
                setState(() {
                  selected = index;
                });
              } else {
                setState(() {
                  selected = -1;
                });
              }
            }),
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  dataList[index]['children'][index]['title'],
                  style: TextStyle(
                    color: index == selected ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          );
        },
      )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExpansionList1 extends StatefulWidget {
  @override
  _ExpansionList1State createState() => _ExpansionList1State();
}

class _ExpansionList1State extends State<ExpansionList1> {
  int? selected;
  Vehicle? vehicle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        key: Key('builder ${selected.toString()}'),
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            key: Key(index.toString()),
            initiallyExpanded: index == selected,
            trailing: const SizedBox(),
            title: Text(
              vehicles[index].title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: index == selected ? Colors.black : Colors.grey,
              ),
            ),
            onExpansionChanged: ((newState) {
              if (newState) {
                setState(() {
                  selected = index;
                });
              } else {
                setState(() {
                  selected = -1;
                });
              }
            }),
            children: <Widget>[
              Column(
                children: _buildExpandableContent(vehicles[index]),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents) {
      columnContent.add(
        ListTile(
          title: Text(
            content,
            style: const TextStyle(fontSize: 18.0),
          ),
          leading: Icon(vehicle.icon),
        ),
      );
    }

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];
  final IconData icon;

  Vehicle(this.title, this.contents, this.icon);
}

List<Vehicle> vehicles = [
  Vehicle(
    'Bike',
    ['Vehicle no. 1', 'Vehicle no. 2', 'Vehicle no. 7', 'Vehicle no. 10'],
    Icons.motorcycle,
  ),
  Vehicle(
    'Cars',
    ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
    Icons.directions_car,
  ),
];
