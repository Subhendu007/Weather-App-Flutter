import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/Models/forcast.dart';
import 'package:weather_app_flutter/detailspage.dart';
import 'package:weather_app_flutter/widgets/constants.dart';
import 'package:weather_app_flutter/Models/responcehandeller.dart';
import 'package:weather_app_flutter/widgets/customsearchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cityTextController = TextEditingController();
  final _responceHandeller = ResponceHandeller();
  late var _responce;
  late Forecast _forecast;
  bool pressed = false;
  late Position _position;

  void _getWeatherByCity() async {
    final result =
        await _responceHandeller.getWeatherByCity(_cityTextController.text);
    final forecast = await _responceHandeller.getWeatherForecast(
        result.lat.toString(), result.lon.toString());
    setState(() {
      _forecast = forecast;
      _responce = result;
      pressed = true;
    });
  }

  void _getWeatherByLoc(String latitude, String longitude) async {
    final result =
        await _responceHandeller.getWeatherByCordination(latitude, longitude);
    final forecast =
        await _responceHandeller.getWeatherForecast(latitude, longitude);
    setState(() {
      _forecast = forecast;
      _responce = result;
      pressed = true;
    });
  }

//Fetching user location
  Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = position;
    });
    return _position;
  }

  void clearText() {
    _cityTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //city name
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            pressed ? _responce.cityName : 'City Name',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          Text(
                            pressed ? _responce.country : "",
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.white),
                          )
                        ],
                      ),
                    ),

                    // status tamplate
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 35, right: 35, top: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: kboxShadow,
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 20),
                                    margin: EdgeInsets.only(left: 40),
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          pressed
                                              ? '${_responce.temp.toInt().toString()}°C'
                                              : '0°c',
                                          style: TextStyle(
                                            fontFamily: 'Poppins Light',
                                            fontSize: 60,
                                          ),
                                        ),
                                        Text(
                                          pressed
                                              ? 'Feels like ${_responce.feelsLike.toInt().toString()}°C'
                                              : 'Feels like demo',
                                          style: TextStyle(
                                            fontFamily: 'Poppins Light',
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 80),
                                  color: Colors.transparent,
                                  height: 160,
                                  width: 140,
                                  child: SizedBox(
                                    height: 140,
                                    width: 140,
                                    child: pressed
                                        ? Image.network(
                                            _responce.icon,
                                            scale: 0.2,
                                          )
                                        : Image.asset(
                                            'images/02d@2x.png',
                                            scale: 0.2,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, right: 35, top: 85),
                              width: 120,
                              height: 170,
                              child: Opacity(
                                opacity: 0.6,
                                child: Text(
                                  pressed ? _responce.description : 'Clear Sky',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 14),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //additional info tamplate
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Container(
                                      child: Text(
                                    "Wind",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white),
                                  )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          pressed ? "${_responce.wind}" : '0',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4, left: 2),
                                          child: Text(
                                            'km/h',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: 2,
                            height: 20,
                            color: Colors.white38,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    "Humidity",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      pressed
                                          ? "${_responce.humidity.toInt()}%"
                                          : '0%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 2,
                            height: 20,
                            color: Colors.white38,
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Container(
                                      child: Text(
                                    "Pressure",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white),
                                  )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          pressed
                                              ? "${_responce.pressure.toInt()}"
                                              : '0.0',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4, left: 2),
                                          child: Text(
                                            'hPa',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    //weather forecast
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0.0),
                      height: 175.0,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 2, top: 0, bottom: 0, right: 8),
                        scrollDirection: Axis.horizontal,
                        itemCount: pressed ? _forecast.daily.length : 12,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 15, bottom: 15, right: 10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    )
                                  ]),
                              child: Column(children: [
                                Text(
                                  pressed
                                      ? "${_forecast.hourly[index].temp}°"
                                      : "0°c",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                pressed
                                    ? Image.network(
                                        _forecast.hourly[index].icon)
                                    : Image.asset('images/02d@2x.png'),
                                Text(
                                  pressed
                                      ? "${getTimeFromTimestamp(_forecast.hourly[index].dt)}"
                                      : 'date',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ]));
                        },
                      ),
                    ),
                    //7days route
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    forecast: _forecast,
                                  ),
                                ),
                              );
                            },
                            child: Text('7 day forcust >>'))
                      ],
                    )
                  ],
                ),
              ),
            ),
            //Location search bar
            Align(
                alignment: Alignment.bottomCenter,
                child: CustomSearchBar(
                    controller: _cityTextController,
                    onLocPressed: () {
                      _getCurrentLocation();
                      _getWeatherByLoc(_position.latitude.toString(),
                          _position.longitude.toString());
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    onSearchPressed: () {
                      _getWeatherByCity();
                      clearText();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    })),
          ],
        ),
      ),
    );
  }
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
