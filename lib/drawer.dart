import 'package:flutter/material.dart';

class ExpansionTIle extends StatefulWidget {
  const ExpansionTIle({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpansionTIle> createState() => _ExpansionTIleState();
}

class _ExpansionTIleState extends State<ExpansionTIle> {
  List<Menu> data = [];

  @override
  void initState() {
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Submenu'),
        ),
        drawer: Drawer(
          child: _buildDrawer(),
        ),
        body: const Center(
          child: Text(
            "Main Screen Contents...",
            style: TextStyle(fontSize: 30),
          ),
        ));
  }

  Widget _buildDrawer() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildDrawerHeader(data[index]);
        }
        return _buildMenuList(data[index]);
      },
    );
  }

  Widget _buildDrawerHeader(Menu headItem) {
    return DrawerHeader(
        margin: const EdgeInsets.only(bottom: 0),
        decoration: const BoxDecoration(
          color: Colors.deepOrange,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              headItem.icon,
              color: Colors.white,
              size: 60,
            ),
            const Spacer(),
            Text(
              headItem.title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ));
  }

  Widget _buildMenuList(Menu menuItem) {
    //build the expansion tile
    double lp = 0; //left padding
    double fontSize = 20;
    if (menuItem.level == 1) {
      lp = 20;
      fontSize = 16;
    }
    if (menuItem.level == 2) {
      lp = 30;
      fontSize = 14;
    }

    if (menuItem.children.isEmpty) {
      return Builder(builder: (
        context,
      ) {
        return InkWell(
          child: Padding(
            padding: EdgeInsets.only(left: lp),
            child: ListTile(
              leading: Icon(menuItem.icon),
              title: Text(
                menuItem.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          onTap: () {
            // Close the drawer
            Navigator.pop(context);

            //Then direct user to dashboard page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(menuItem),
              ),
            );
          },
        );
      });
    }

    return Padding(
      padding: EdgeInsets.only(left: lp),
      child: ExpansionTile(
        leading: Icon(menuItem.icon),
        title: Text(
          menuItem.title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        children: menuItem.children.map(_buildMenuList).toList(),
      ),
    );
  }
}

//The Menu Model
class Menu {
  int level = 0;
  IconData icon = Icons.drive_file_rename_outline;
  String title = "";
  List<Menu> children = [];
  //default constructor
  Menu(this.level, this.icon, this.title, this.children);

  //one method for  Json data
  Menu.fromJson(Map<String, dynamic> json) {
    //level
    if (json["level"] != null) {
      level = json["level"];
    }
    //icon
    if (json["icon"] != null) {
      icon = json["icon"];
    }
    //title
    title = json['title'];
    //children
    if (json['children'] != null) {
      children.clear();
      //for each entry from json children add to the Node children
      json['children'].forEach((v) {
        children.add(Menu.fromJson(v));
      });
    }
  }
}

//menu data list
List dataList = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.account_circle_rounded,
    "title": "@SimpleFlutter: The Best Flutter Channel On YT",
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.payments,
    "title": "Payments",
    "children": [
      {
        "level": 1,
        "icon": Icons.paypal,
        "title": "Paypal",
      },
      {
        "level": 1,
        "icon": Icons.credit_card,
        "title": "Credit Card",
      },
    ]
  },
  {
    "level": 0,
    "icon": Icons.favorite,
    "title": "Favorite",
    "children": [
      {
        "level": 1,
        "icon": Icons.water,
        "title": "Swimming",
      },
      {
        "level": 1,
        "icon": Icons.sports_football,
        "title": "Football",
      },
      {"level": 1, "icon": Icons.movie, "title": "Movie"},
    ]
  },
];

class Dashboard extends StatelessWidget {
  const Dashboard(this.menuItem, {Key? key}) : super(key: key);
  // Declare a field that holds the User
  final Menu menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Are you ready for  ${menuItem.title} ?",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
        ));
  }
}

class DrawerMenu {
  int? level;
  String? title;
  List<Children>? children;

  DrawerMenu({this.level, this.title, this.children});

  DrawerMenu.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    title = json['title'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add( Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['title'] = title;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? level;
  String? title;

  Children({this.level, this.title});

  Children.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['title'] = title;
    return data;
  }
}
