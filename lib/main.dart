import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tut/provider/color_model.dart';
import 'package:provider_tut/provider/ui_widget.dart'; 

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => ColorStatusState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:   HomePage(),
      ),
    );
  }
}
