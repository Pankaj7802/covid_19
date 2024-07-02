import 'package:covid_19/View/world_states.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                    ),
                    ReusableRow(
                        title: 'Cases', value: widget.totalCases.toString()),
                    ReusableRow(
                        title: 'Recovered',
                        value: widget.todayRecovered.toString()),
                    ReusableRow(
                        title: 'Death', value: widget.totalDeaths.toString()),
                    ReusableRow(
                        title: 'Critical', value: widget.critical.toString()),
                    ReusableRow(
                        title: 'Total Recovered',
                        value: widget.todayRecovered.toString())
                  ],
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
