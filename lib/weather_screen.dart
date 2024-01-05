import "dart:convert";
import "dart:ui";

import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:weather_app/secrets.dart";

import "additional_info_item.dart";
import "hourly_forecast_item.dart";
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  // For refreshing
  late Future<Map<String, dynamic>> weather;

  // double temp = 0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentWeather();
  // }
  // in JS -
  // async operation - returns the Promise
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Surat';

      final res = await http.get(
          // Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherAPIKey')
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey')

          // print(res.body);
          );

      // if(res.statusCode == 200){};
      //   Alternative way of this\
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred.';
        // throw data['message'];
      }

      // Without setState - the async will set the value after the build function - so won't work properly
      // By using this setState , value is correctly assigned
      // SetState rebuilds the build function
      // setState(() {
      //   // print(data['list'][0]['main']['temp']);
      //   temp = data['list'][0]['main']['temp'];
      // });

      // data['list'][0]['main']['temp'];
      return data;

    } catch (err) {
      throw err.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        actions: [
          // GestureDetector(child: const Icon(Icons.refresh),
          //   onTap: (){
          //     print('refresh');
          //   },
          // ),

          IconButton(
              onPressed: () {
                // NOT RECOMMENEDED -- another way done using variable
                // Thsi rebuilds the entire scaffold & hence gives the updated value on refreshing it
                setState(() {
                  weather = getCurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),

      // If the temp = 0 -- show loading -- else display contents -- using loadingIndicator
      body: FutureBuilder(
        // future: getCurrentWeather(),
        // This line is updated for refreshing
        future: weather,
        builder: (context, snapshot) {
          // Snapshot : A class that handles the state in the app -- Error state -- Loading State -- Data State
          // print(snapshot);
          // print(snapshot.runtimeType);

          // to detect loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            // adaptive -- in ios - indicator is for iod & for android its for android
            return Center(child: const CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //   Main Card
                  //   Placeholder(
                  //     // this is applicable only when there is no child --
                  //     fallbackHeight: 250,
                  //     // child: Text('Main card'),
                  //   ),
              
                  // HINT
                  // for only width : USE SIZEBOX
                  // for color , height , width & many more -- USE CONTAINER
              
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemp K',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
              
                                // Spacing
                                const SizedBox(
                                  height: 16,
                                ),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 70,
                                ),
              
                                // Spacing
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  '$currentSky',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              
                  // for spacing
                  const SizedBox(
                    height: 20,
                  ),
              
                  // Weather Forecast cards
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hourly Forecast',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              
                  const SizedBox(
                    height: 8,
                  ),
              
                  // For web applications in Flutter, the SingleChildScrollView might have issues with scrolling on some platforms, including Chrome. An alternative approach is to use the ListView widget with scrollDirection set to Axis.horizontal for horizontal scrolling.
              
                  // Shift + mouse wheel
                  // SingleChildScrollView(
                  //    scrollDirection: Axis.horizontal,
                  //    child: Row(
                  //     children: [
                  //
                  //       // using this loop -- creates 40 widgets all together -- affects the performance
                  //       // therefore - we want to lazily create the widget only when we scroll - otherwise not
                  //       // Widgets are created on demand - not all at once
                  //       for(int i = 0 ; i<39 ; i++)
                  //         HourlyForecastItem(
                  //           time: data['list'][i+1]['dt_txt'],
                  //           icon:  data['list'][i+1]['weather'][0]['main'] == 'Clouds' || data['list'][i+1]['weather'][0]['main'] == 'Rain' ? Icons.cloud : Icons.sunny,
                  //           temperature : data['list'][i+1]['main']['temp'].toString(),
                  //         ),
                  //
                  //     ],
                  //    ),
                  //  ),
              
                  // The problem with above scroll - it loads the build function as many times as the fro loop - 40 in this case -- therefore load is high on the server
                  // An alternative approach for this -- listViewBuilder -- More OPTIMIZED
                  // MOST IMP -- listViewBuilder
              
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                        //       This helps us to build the contents taht are lazily loaded -- will be loiaded only when you scroll
                        // NEED : ItemCount for this
                        itemCount: 39,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data['list'][index + 1];
                          final hourlySky = hourlyForecast['weather'][0]['main'];
                          final hourlyTemp =
                              hourlyForecast['main']['temp'].toString();
                          // Using a poackage (INTL)to extract the time from teh date time mentioned in string
                          final time = DateTime.parse(hourlyForecast['dt_txt']);
                          return HourlyForecastItem(
                            // Format : 00:00 , 03:00 , 09:00 ---
                            // time: DateFormat.Hm().format(time)
                            time: DateFormat('Hm').format(time),
                            icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                            temperature: hourlyTemp,
                          );
                        }),
                  ),
              
                  // for spacing
                  const SizedBox(
                    height: 20,
                  ),
              
                  // Additional Information Card
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Additional Information',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              
                  const SizedBox(
                    height: 8,
                  ),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '$currentHumidity',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: '$currentWindSpeed',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: '$currentPressure',
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
