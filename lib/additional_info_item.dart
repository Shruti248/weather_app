import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {

  // Since we want to display different text foe each of the card
  // We take the data from the constructor
  // icon - label - value -- dynamic data with same styles - so using a constructor

  // Steps for creating the constructor
  // Mark every properties as final bcoz of stateless
  final IconData icon;
  final String label;
  final String value;

  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon(Icons.water_drop , size: 32,),
        Icon(icon , size: 32,),

        const SizedBox(height: 8,),
        // Text('Humidity' ,),
        Text(label),

        const SizedBox(height: 8,),
        // Text('91' , style: TextStyle(
        //   fontWeight: FontWeight.bold,
        //   fontSize: 16,
        // ),)
        Text(value ,
          style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),)
      ],
    );
  }
}

