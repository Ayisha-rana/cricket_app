import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cricket_app/screen/classmodel/model.dart';

class BrowseSeriesPage extends StatefulWidget {
  const BrowseSeriesPage({super.key});

  @override
  _BrowseSeriesPageState createState() => _BrowseSeriesPageState();
}

class _BrowseSeriesPageState extends State<BrowseSeriesPage> {
  List<SeriesData> seriesList = [];
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
      'X-RapidAPI-Key': '339ad43730msh1c4e5b0c7a473c7p1fa67cjsnf1b4f78c7de1',
      'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print(data);

        setState(() {
          if (data.containsKey('seriesMapProto')) {
            var seriesListData = data['seriesMapProto'] as List;
            seriesList = seriesListData.map((item) {
              final seriesDate = item['date'];
              final series = (item['series'] as List)
                  .map((seriesItem) => Series.fromJson(seriesItem))
                  .toList();
              return SeriesData(date: seriesDate, series: series);
            }).toList();
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('International Series'),
        centerTitle: true,
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
                    final seriesData = seriesList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seriesData.date,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        ...seriesData.series.map<Widget>((item) {
                          return Card(
                              color: Color.fromARGB(255, 251, 255, 252),

                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(item.name),
                                subtitle: Text(
                                  'Start Date: ${item.startDate}',
                                ),
                                trailing: Text(
                                  'End Date: ${item.endDate}',
                                style: TextStyle(color: Colors.blue),),
                              ),
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
