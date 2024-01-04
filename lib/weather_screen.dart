import "dart:ui";

import "package:flutter/material.dart";

import "additional_info_item.dart";
import "hourly_forecast_item.dart";

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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


      body: Padding(
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('300K' , style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                          ),),
                    
                          // Spacing
                          SizedBox(height: 16,),
                          Icon(Icons.cloud , size: 70,),
                    
                          // Spacing
                          SizedBox(height: 16,),
                          Text('Rain', style: TextStyle(fontSize: 20),)
                    
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

             // const SingleChildScrollView(
             //   scrollDirection: Axis.horizontal,
             //   child: Row(
             //    children: [
             //
             //      HourlyForecastItem(
             //        time: '00:00',
             //        icon: Icons.cloud,
             //        temperature : '301.22',
             //      ),
             //      HourlyForecastItem(
             //        time: '03:00',
             //        icon: Icons.sunny,
             //        temperature : '300.52',
             //      ),
             //      HourlyForecastItem(
             //        time: '06:00',
             //        icon: Icons.cloud,
             //        temperature : '302.22',),
             //      HourlyForecastItem(
             //        time: '09:00',
             //        icon: Icons.sunny,
             //        temperature : '301.22',),
             //      HourlyForecastItem(
             //        time: '12:00',
             //        icon: Icons.cloud,
             //        temperature : '304.22',),
             //    ],
             //   ),
             // ),

             ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                HourlyForecastItem(
                  time: '00:00',
                  icon: Icons.cloud,
                  temperature: '301.22',
                ),
                HourlyForecastItem(
                  time: '03:00',
                  icon: Icons.sunny,
                  temperature: '300.52',
                ),
                HourlyForecastItem(
                  time: '06:00',
                  icon: Icons.cloud,
                  temperature: '302.22',
                ),
                HourlyForecastItem(
                  time: '09:00',
                  icon: Icons.sunny,
                  temperature: '301.22',
                ),
                HourlyForecastItem(
                  time: '12:00',
                  icon: Icons.cloud,
                  temperature: '304.22',
                ),
              ],
            ),


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


