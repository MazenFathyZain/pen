import 'package:flutter/material.dart';

import '../../core/constants.dart';



class EventResultScreen extends StatelessWidget {
  const EventResultScreen({super.key});

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
        title: const Text("النتيجة"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'التوقع',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: DropdownButton<String>(
                value: 'وقع الحدث',
                onChanged: (String? newValue) {},
                isExpanded: true,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(
                    value: 'وقع الحدث',
                    child: Text('وقع الحدث', textAlign: TextAlign.right),
                  ),
                  DropdownMenuItem(
                    value: 'لم يقع الحدث',
                    child: Text('لم يقع الحدث', textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const CustomContainer(label: 'التاريخ'),
            const SizedBox(height: 16),
            const CustomContainer(label: 'الشعور'),
            const SizedBox(height: 16),
            const CustomContainer(label: 'الفاصل الزمني بين التوقع ووقوع الحدث'),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String label;

  const CustomContainer({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: const Text(
            "",
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
