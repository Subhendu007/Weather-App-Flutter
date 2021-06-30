import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/Models/forcast.dart';
import 'package:weather_app_flutter/widgets/constants.dart';

class DetailsPage extends StatefulWidget {
  final Forecast forecast;

  const DetailsPage({Key? key, required this.forecast}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              //Header
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        padding: EdgeInsets.only(left: 10),
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                        color: Colors.white),
                    Text(
                      'Today\'s weather',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Opacity(
                      opacity: 0.0,
                      child: IconButton(
                          onPressed: null,
                          icon: Icon(Icons.arrow_back_ios_new_rounded)),
                    ),
                  ],
                ),
              ),
              //todays weather template
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                  boxShadow: kboxShadow,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            widget.forecast.daily[0].icon,
                            scale: 1.1,
                          ),
                          Text(
                            '${widget.forecast.daily[0].description}',
                            style: TextStyle(
                                fontFamily: "Poppins Light",
                                fontSize: 15,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.forecast.daily[0].temp.toInt()}°c',
                            style: TextStyle(
                                fontFamily: "Poppins Regular", fontSize: 45),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Feels like ${widget.forecast.daily[0].feelsLike}°c',
                            style: TextStyle(
                              fontFamily: 'Poppins Light',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //future weather
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: kboxShadow),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: 20, right: 15, left: 15, bottom: 20),
                      child: hourlyDetails(widget.forecast)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget hourlyDetails(Forecast _forecast) {
  return ListView.builder(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
    itemCount: _forecast.daily.length - 1,
    itemBuilder: (BuildContext context, int index) {
      int _index = index + 1;
      return Container(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
        margin: const EdgeInsets.all(5),
        child: Row(children: [
          Expanded(
              child: Text(
            "${getDateFromTimestamp(_forecast.daily[_index].dt)}",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14, color: Colors.black),
          )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_forecast.daily[_index].high.toInt()}°c",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  "${_forecast.daily[_index].low.toInt()}°c",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              height: 50,
              width: 50,
              child: Image.network('${_forecast.daily[index].icon}'),
            ),
          ),
        ]),
      );
    },
  );
}

String getTimeFromTimestamp(int timestamp) {
  var time = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat('h:mm a');
  return formatter.format(time);
}

String getDateFromTimestamp(int timestamp) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat('E');
  return formatter.format(date);
}
