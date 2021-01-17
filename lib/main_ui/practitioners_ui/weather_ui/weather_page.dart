import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory wf = WeatherFactory('957abb8569058fc7f7c2ccd5175739a5');
  LatLng currentLocation;
  Weather todaysWeather;
  List<Weather> fiveDaysWeather;
  String city = 'unknown';
  String time;
  @override
  initState() {
    super.initState();
    _getLatLong();
  }

  Widget getCity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.location_on),
        Text(
          city,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
      ],
    );
  }

  Widget getTime() {
    var time =
        '${DateTime.now().hour}.${DateTime.now().minute} ${DateTime.now().timeZoneName}';
    return Container(
      margin: EdgeInsets.only(left: 60),
      child: Text(
        time,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  Future<void> _getLatLong() async {
    try {
      Location location = Location();
      PermissionStatus permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus == PermissionStatus.denied) {
          await Future.delayed(
            Duration(seconds: 1),
          );
          await _getLatLong();
        }
      }
      LocationData locationData = await location.getLocation();
      setState(() {
        currentLocation = LatLng(locationData.latitude, locationData.longitude);
      });
      var weather = await wf.currentWeatherByLocation(
          currentLocation.latitude, currentLocation.longitude);

      setState(() {
        todaysWeather = weather;
        city = weather.areaName;
      });
      var weatherList = await wf.fiveDayForecastByLocation(
          currentLocation.latitude, currentLocation.longitude);
      setState(() {
        fiveDaysWeather = weatherList;
      });
    } catch (e) {
      throw Exception('Unable to fetch information');
    }
  }

  Widget fetchCurrentWeather(context) {
    return getWeatherCard(
      context: context,
      cloudyText: todaysWeather != null
          ? todaysWeather.cloudiness > 4
              ? 'Cloudy'
              : 'Clear'
          : '',
      temprature: todaysWeather != null
          ? todaysWeather.temperature.celsius.toStringAsFixed(2).toString()
          : '',
      description:
          todaysWeather != null ? todaysWeather.weatherDescription : '',
      wind: todaysWeather != null
          ? (todaysWeather.windSpeed * 3.6).floor().toString()
          : '',
      humidity: todaysWeather != null ? todaysWeather.humidity.toString() : '',
    );
  }

  Widget getWeatherCard(
      {BuildContext context,
      String cloudyText,
      String temprature,
      String wind,
      String description,
      String humidity}) {
    return Center(
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset(
            'images/weather_bg.jpg',
            width: MediaQuery.of(context).size.width / 1.3,
            height: 250,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 30,
          left: 30,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                cloudyText.isNotEmpty ? cloudyText : '',
                style: TextStyle(
                    color: AppColors.COLOR_BLUEGREY,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
              Text(
                temprature.isNotEmpty ? '$temprature °C' : '',
                style: TextStyle(
                  color: AppColors.COLOR_DIMDARK,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 125,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.only(left: 30),
            height: 125,
            decoration: BoxDecoration(
              color: AppColors.COLOR_BLUEGREY,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description.isNotEmpty ? description : '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  wind.isNotEmpty ? 'Wind $wind km/h' : '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  humidity.isNotEmpty ? 'Humidity $humidity %' : '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget getPerDayWeather(
      Color color, Color textColor, String title, String icon, String degree) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 90,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor),
          ),
          Image.network('http://openweathermap.org/img/wn/$icon@2x.png',
              height: 30, width: 30),
          Text(
            degree,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }

  Widget getWeatherRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getPerDayWeather(
            AppColors.COLOR_BLUEGREY,
            Colors.white,
            fiveDaysWeather != null
                ? '${DateFormat('h:m a').format(fiveDaysWeather[0].date)}'
                : '...',
            fiveDaysWeather != null ? fiveDaysWeather[0].weatherIcon : '03d',
            fiveDaysWeather != null
                ? fiveDaysWeather[0].temperature.celsius.floor().toString()
                : '...'),
        getPerDayWeather(
            Colors.white,
            AppColors.COLOR_DARKGREY,
            fiveDaysWeather != null
                ? '${DateFormat('h:m a').format(fiveDaysWeather[1].date)}'
                : '...',
            fiveDaysWeather != null ? fiveDaysWeather[1].weatherIcon : '03d',
            fiveDaysWeather != null
                ? fiveDaysWeather[1].temperature.celsius.floor().toString()
                : '...'),
        getPerDayWeather(
            Colors.white,
            AppColors.COLOR_DARKGREY,
            fiveDaysWeather != null
                ? '${DateFormat('h:m a').format(fiveDaysWeather[2].date)}'
                : '...',
            fiveDaysWeather != null ? fiveDaysWeather[2].weatherIcon : '03d',
            fiveDaysWeather != null
                ? fiveDaysWeather[2].temperature.celsius.floor().toString()
                : '...'),
        getPerDayWeather(
            Colors.white,
            AppColors.COLOR_DARKGREY,
            fiveDaysWeather != null
                ? '${DateFormat('h:m a').format(fiveDaysWeather[3].date)}'
                : '...',
            fiveDaysWeather != null ? fiveDaysWeather[3].weatherIcon : '03d',
            fiveDaysWeather != null
                ? fiveDaysWeather[3].temperature.celsius.floor().toString()
                : '...'),
      ],
    );
  }

  Widget getListTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Today',
            style: TextStyle(
              color: AppColors.COLOR_DIMDARK,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Spacer(),
          Text(
            todaysWeather != null
                ? '${todaysWeather.tempMin.celsius.floor().toString()} / ${todaysWeather.tempMax.celsius.floor().toString()}'
                : '...',
            style: TextStyle(
              color: AppColors.COLOR_DIMDARK,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget getDayRow(String day, String icon, String degree) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              day,
              style: TextStyle(
                color: AppColors.COLOR_DIMDARK,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.network(
              'http://openweathermap.org/img/wn/$icon@2x.png',
              height: 30,
              width: 30,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              degree,
              style: TextStyle(
                color: AppColors.COLOR_DIMDARK,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listOfNextDays() {
    var list = fiveDaysWeather != null
        ? fiveDaysWeather
            .where((element) => fiveDaysWeather.indexOf(element) % 8 == 0)
            .toList()
        : [];
    return Column(
      children: list
          .map<Widget>(
            (weather) => getDayRow(
              DateFormat('EEEE').format(weather.date),
              weather.weatherIcon,
              '${weather.tempMin.celsius.floor()}° / ${weather.tempMax.celsius.floor()}°',
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCity(),
          getTime(),
          SizedBox(
            height: 20,
          ),
          fetchCurrentWeather(context),
          getListTitle(),
          getWeatherRow(),
          listOfNextDays()
        ],
      ),
    );
  }
}
