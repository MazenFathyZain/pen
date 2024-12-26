import 'package:flutter/material.dart';

import '../../core/constants.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  Widget buildContainer(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: label == "المقال" ? 100 : 40,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.centerRight,
          child: const Text(
            " ",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("هل وقع الحدث أو لم يقع"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildContainer("الموقع"),
              buildContainer("تاريخ"),
              buildContainer("المقال"),
              buildContainer("الكلمات المتشابهة والمرادفة"),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              buildContainer("الموقع"),
              buildContainer("تاريخ"),
              buildContainer("المقال"),
              buildContainer("الكلمات المتشابهة والمرادفة"),
            ],
          ),
        ),
      ),
    );
  }
}
