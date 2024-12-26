import 'package:flutter/material.dart';
import 'package:smart_pen/core/constants.dart';
import 'package:smart_pen/features/home/ui/widgets/new_expectation.dart';
import 'package:smart_pen/features/home/ui/widgets/old_expectations.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,

      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> NewExpectations()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    decoration: BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                          blurRadius: 10, // Spread of the blur
                          offset: const Offset(0, 4), // Position of the shadow (x, y)
                        ),
                      ],
                    ),
                    child:  const Text(
                      'توقعات جديدة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const OldExpectations()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    decoration: BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                          blurRadius: 10, // Spread of the blur
                          offset: const Offset(0, 4), // Position of the shadow (x, y)
                        ),
                      ],
                    ),
                    child:  const Text(
                      'توقعات سابقة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )),
    );
  }
}
