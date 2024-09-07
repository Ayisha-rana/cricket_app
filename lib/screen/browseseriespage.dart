import 'dart:convert';
import 'package:cricket_app/screen/classmodel/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BrowseSeriesPage extends StatefulWidget {
  const BrowseSeriesPage({super.key});

  @override
  _BrowseSeriesPageState createState() => _BrowseSeriesPageState();
}

class _BrowseSeriesPageState extends State<BrowseSeriesPage> {
  List<Series> seriesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSeriesData();
  }

  Future<void> fetchSeriesData() async {
    const String apiUrl =
        'https://cricbuzz-cricket.p.rapidapi.com/series/v1/international';

    final headers = {
      'X-RapidAPI-Key': '9af4284c3cmshd23f13b75b24bd6p1788b2jsnb00341e62d58',
      'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Debugging: Print the API response to check the structure
        print(data);

        setState(() {
          if (data.containsKey('seriesMapProto')) {
            var seriesListData = data['seriesMapProto'] as List;
            seriesList = seriesListData.map((item) => Series.fromJson(item)).toList();
          } else {
            seriesList = [];
            print('Error: seriesMapProto not found in response');
          }
          isLoading = false;
        });
      } else {
        print('Failed to load series data: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching series data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('International Series'),
        backgroundColor: const Color.fromARGB(255, 85, 147, 88),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : seriesList.isEmpty
              ? const Center(child: Text('No series data available'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: seriesList.length,
                  itemBuilder: (context, index) {
                    final seriesItem = seriesList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seriesItem.date,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        ...seriesItem.series.map<Widget>((item) {
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text(
                              'Start Date: ${item.startDate}',
                            ),
                            trailing: Text(
                              'End Date: ${item.endDate}',
                            ),
                          );
                        }).toList(),
                        const Divider(),
                      ],
                    );
                  },
                ),
    );
  }
}
