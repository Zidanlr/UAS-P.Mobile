import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StationListPage extends StatefulWidget {
  @override
  _StationListPageState createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
  late Future<List<dynamic>> stations;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    stations = fetchStations();
  }

  Future<List<dynamic>> fetchStations() async {
    final response =
        await http.get(Uri.https('booking.kai.id', '/api/stations2'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load stations');
    }
  }

  List<dynamic> filterStations(List<dynamic> stations, String query) {
    return stations
        .where((station) =>
            station['code'].toLowerCase().contains(query.toLowerCase()) ||
            station['name'].toLowerCase().contains(query.toLowerCase()) ||
            station['city'].toLowerCase().contains(query.toLowerCase()) ||
            station['cityname'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void navigateToStationDetail(dynamic station) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationDetailPage(station: station),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Stasiun'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  stations = fetchStations().then((data) {
                    return filterStations(data, value);
                  });
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: stations,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateToStationDetail(snapshot.data![index]);
                        },
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            title: Text(snapshot.data![index]['name']),
                            subtitle: Text(snapshot.data![index]['city']),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StationDetailPage extends StatelessWidget {
  final dynamic station;

  const StationDetailPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station['name']),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Code:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              station['code'],
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              station['name'],
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'City:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              station['city'],
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'City Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              station['cityname'],
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
