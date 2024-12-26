import 'package:flutter/material.dart';
import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:smart_pen/core/constants.dart';
import 'package:smart_pen/features/comparison/comparison_screen.dart';


class OldExpectations extends StatelessWidget {
  const OldExpectations({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendarConfig.language = 'ar';
    var hijriDate = HijriCalendarConfig.now();
    print('Formatted: ${hijriDate.toFormat("DDDD, MMMM dd, yyyy")}');

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("التوقعات السابقة"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                        blurRadius: 10, // Spread of the blur
                        offset: const Offset(0, 4), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hijriDate.toFormat("MMMM dd, yyyy"),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Text(
                          'التوقع صحيح',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const ComparisonScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                          blurRadius: 10, // Spread of the blur
                          offset: const Offset(0, 4), // Position of the shadow (x, y)
                        ),
                      ],
                    ),
                    child:   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                      hijriDate.toFormat("MMMM dd, yyyy"),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const Text(
                            'الشعور غير صحيح',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                        blurRadius: 10, // Spread of the blur
                        offset: const Offset(0, 4), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child:   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                    hijriDate.toFormat("MMMM dd, yyyy"),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Text(
                          'في الانتظار...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),),
    );
  }
}

