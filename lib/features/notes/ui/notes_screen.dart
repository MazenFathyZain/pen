import 'package:flutter/material.dart';
import 'package:smart_pen/core/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: mainColor,
        items: const <Widget>[
          Icon(Icons.arrow_back_ios, size: 30,color: Color(0xffffb8b8),),
          Icon(Icons.edit_note, size: 30,color: Color(0xffffb8b8),),
          Icon(Icons.bookmark, size: 30,color: Color(0xffffb8b8),),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             Container(
               alignment: Alignment.center,
               height: 130,
               width: 160,
               decoration: BoxDecoration(
                 color: Colors.white,
                 border: Border.all(color: secondColor),
                 borderRadius: BorderRadius.circular(15),
               ),
               child:  const Text(
                 'مذكرات جديدة',
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ),
              Container(
                alignment: Alignment.center,
                height: 130,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: secondColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child:  const Text(
                  'مذكرات سابقة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
