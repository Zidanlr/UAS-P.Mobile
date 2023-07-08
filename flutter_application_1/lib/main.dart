import 'package:flutter/material.dart';
import 'package:flutter_application_1/station_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KAI Station',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 67, 157, 231),
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 93, 191, 230),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 18, 140, 197),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'KAI Stasiun App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Image.asset(
              'assets/images/logo.png', // Ganti dengan path gambar logo baru
              width: 120,
              height: 120,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StationListPage(),
                  ),
                );
              },
              child: Text('Daftar Stasiun'),
            ),
          ],
        ),
      ),
    );
  }
}
