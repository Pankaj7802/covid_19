import 'package:covid_19/View/country_list.dart';
import 'package:covid_19/model/world_states.dart';
import 'package:covid_19/service/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
                // height: 10,
              ),
              FutureBuilder(
                  future: stateServices.fecthWorkdStatesRecords(),
                  builder: (context, AsyncSnapshot<Country> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          ));
                    } else {
                      return Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left),
                              animationDuration:
                                  const Duration(microseconds: 1000),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                      title: " Total Cases",
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Recovered",
                                      value:
                                          snapshot.data!.recovered.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Deaths",
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Active",
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Critical",
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    // ReusableRow(
                                    //   title: "Today Cases",
                                    //   value:
                                    //       snapshot.data!.todayCases.toString(),
                                    // ),
                                    ReusableRow(
                                      title: "Today Deaths",
                                      value:
                                          snapshot.data!.todayDeaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: "Today Recovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CountryListScreen()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text('Tracker Countires'),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
