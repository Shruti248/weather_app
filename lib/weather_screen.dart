import "dart:ui";

import "package:flutter/material.dart";

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
                          Text('300°F' , style: TextStyle(
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

            // Weather Forecast Height
            const Placeholder(
              fallbackHeight: 150,
            ),

            // for spacing
            const SizedBox(height: 20,),

            // Additional Information Card
            const Placeholder(
              fallbackHeight: 150,
            )



          ],
        ),
      ),
    );
  }
}
