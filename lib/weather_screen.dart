import "dart:convert";
import "dart:ui";

import "package:flutter/material.dart";
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

  double temp = 0;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }
  // in JS -  async operation - returns the Promise
  Future getCurrentWeather() async
  {
    try{
      String cityName = 'London';

      final res = await http.get(
        // Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherAPIKey')
          Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey')

          // print(res.body);
      );

      // if(res.statusCode == 200){};
      //   Alternative way of this\
      final data = jsonDecode(res.body);

      if(data['cod'] != '200'){
        throw 'An unexpected error occurred.';
      }

      // Without setState - the async will set the value after the build function - so won't work properly
      // By using this setState , value is correctly assigned
      // SetState rebuilds the build function
      setState(() {
        // print(data['list'][0]['main']['temp']);
        temp = data['list'][0]['main']['temp'];
      });

    }catch(err){
      throw err.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App' , style: TextStyle(
          fontWeight: FontWeight.bold,
        )
        ),
      centerTitle: true,
        actions: [
          // GestureDetector(child: const Icon(Icons.refresh),
          //   onTap: (){
          //     print('refresh');
          //   },
          // ),

          IconButton(onPressed: (){} , icon: const Icon(Icons.refresh)),
        ],
      ),

      // If the temp = 0 -- show loading -- else display contents -- using loadingIndicator
      body: temp == 0 ? const CircularProgressIndicator() : Padding(
        padding:  const EdgeInsets.all(16.0),
        child:  Column(
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
                    filter: ImageFilter.blur(sigmaX: 5 , sigmaY: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('$temp K' , style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                          ),),

                          // Spacing
                          const SizedBox(height: 16,),
                          const Icon(Icons.cloud , size: 70,),

                          // Spacing
                          const SizedBox(height: 16,),
                          const Text('Rain', style: TextStyle(fontSize: 20),)

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // for spacing
            const SizedBox(height: 20,),

            // Weather Forecast cards
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Weather Forecast' , style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),),
            ),

            const SizedBox(height: 8,),

            // For web applications in Flutter, the SingleChildScrollView might have issues with scrolling on some platforms, including Chrome. An alternative approach is to use the ListView widget with scrollDirection set to Axis.horizontal for horizontal scrolling.

             // Shift + mouse wheel
             const SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                children: [

                  HourlyForecastItem(
                    time: '00:00',
                    icon: Icons.cloud,
                    temperature : '301.22',
                  ),
                  HourlyForecastItem(
                    time: '03:00',
                    icon: Icons.sunny,
                    temperature : '300.52',
                  ),
                  HourlyForecastItem(
                    time: '06:00',
                    icon: Icons.cloud,
                    temperature : '302.22',),
                  HourlyForecastItem(
                    time: '09:00',
                    icon: Icons.sunny,
                    temperature : '301.22',),
                  HourlyForecastItem(
                    time: '12:00',
                    icon: Icons.cloud,
                    temperature : '304.22',),
                ],
               ),
             ),

            //  ListView(
            //   scrollDirection: Axis.horizontal,
            //   physics: const NeverScrollableScrollPhysics(),
            //   children: const [
            //     HourlyForecastItem(
            //       time: '00:00',
            //       icon: Icons.cloud,
            //       temperature: '301.22',
            //     ),
            //     HourlyForecastItem(
            //       time: '03:00',
            //       icon: Icons.sunny,
            //       temperature: '300.52',
            //     ),
            //     HourlyForecastItem(
            //       time: '06:00',
            //       icon: Icons.cloud,
            //       temperature: '302.22',
            //     ),
            //     HourlyForecastItem(
            //       time: '09:00',
            //       icon: Icons.sunny,
            //       temperature: '301.22',
            //     ),
            //     HourlyForecastItem(
            //       time: '12:00',
            //       icon: Icons.cloud,
            //       temperature: '304.22',
            //     ),
            //   ],
            // ),
            //

            // for spacing
            const SizedBox(height: 20,),

            // Additional Information Card
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Additional Information' , style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),),
            ),

            const SizedBox(height: 8,),

        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AdditionalInfoItem(
              icon: Icons.water_drop,
              label: 'Humidity',
              value: '91',
            ),
            AdditionalInfoItem(
              icon: Icons.air,
              label: 'Wind Speed',
              value: '7.5',
            ),
            AdditionalInfoItem(
              icon: Icons.beach_access,
              label: 'Pressure',
              value: '1000',
            ),
          ],
        )


          ],
        ),
      ),
    );
  }
}


