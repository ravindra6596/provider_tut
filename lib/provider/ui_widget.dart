import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tut/drawer.dart';
import 'package:provider_tut/provider/color_model.dart';
import 'package:provider_tut/submenu.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpansionTIle(),
                  ),
                );
              },
              child: const Text('Expansion Deawer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Submenu(),
                  ),
                );
              },
              child: const Text('Submenu'),
            ),
            Consumer<ColorStatusState>(
              builder: (context, state, _) => GestureDetector(
                onTap: () {
                  state.changeColor();
                },
                child: Container(
                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(20),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: state.buttonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'Press me',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
