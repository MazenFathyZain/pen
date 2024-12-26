import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

import '../../home/ui/widgets/old_expectations.dart';

class AnalysisScreen extends StatelessWidget {
  final String? bpm;
  final String? breathingRate;
  final String? pressure;
  final String? text;

  const AnalysisScreen(
      {super.key, this.bpm, this.breathingRate, this.pressure, this.text});

  @override
  Widget build(BuildContext context) {
    HijriCalendarConfig.language = 'ar';
    var hijriDate = HijriCalendarConfig.now();
    print('Formatted: ${hijriDate.toFormat("DDDD, MMMM dd, yyyy")}');
    final DateTime now = DateTime.now();

    final String formattedGregorianDate =
        DateFormat.yMMMMEEEEd('ar').format(now);
    final String formattedTime = DateFormat.jm('ar').format(now);
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("التحليل"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildContainer(
                  'التاريخ بالهجري', hijriDate.toFormat("DDDD, MMMM dd, yyyy")),
              _buildContainer(
                  'التاريخ بالميلادي', formattedGregorianDate.toString()),
              _buildContainer('الساعة', formattedTime),
              _buildContainer('الاحداثيات', '30.062, 31.344'),
              _buildContainer('الشعور', text ?? ""),
              _buildContainer('عدد الكلمات في المذكرة',
                  text!.isNotEmpty ? text!.split(" ").length.toString() : "0"),
              // _______________________________________________________________________________________
              const SizedBox(height: 10),
              Table(
                border: TableBorder(
                  borderRadius: BorderRadius.circular(15),
                  horizontalInside: const BorderSide(
                    color: secondColor,
                    width: 1,
                  ),
                  verticalInside: const BorderSide(
                    color: secondColor,
                    width: 1,
                  ),
                  top: const BorderSide(
                    color: secondColor,
                    width: 1,
                  ),
                  bottom: const BorderSide(
                    color: secondColor,
                    width: 1,
                  ),
                  left: const BorderSide(
                    color: secondColor,
                    width: 1,
                  ),
                  right: const BorderSide(
                    color: secondColor,
                    width: 1,
                  ),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(1.5), // Adjust column widths
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(1.2),
                  5: FlexColumnWidth(1.2),
                },
                children: [
                  // Header Row
                  TableRow(
                    children: [
                      _buildTableCell('الكلمة', isHeader: true),
                      _buildTableCell('عدم تكرار الكلمة', isHeader: true),
                      _buildTableCell('التصنيف', isHeader: true),
                      _buildTableCell('نبضات القلب', isHeader: true),
                      _buildTableCell('التنفس', isHeader: true),
                      _buildTableCell('الضغط', isHeader: true),
                    ],
                  ),
                  // Empty Rows
                  for (int i = 0; i < 3; i++)
                    TableRow(
                      children: [
                        _buildTableCell(''),
                        _buildTableCell(''),
                        _buildTableCell(''),
                        _buildTableCell(bpm ?? ""),
                        _buildTableCell(breathingRate ?? ""),
                        _buildTableCell(pressure ?? ""),
                      ],
                    ),
                ],
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                height: 430,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: secondColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildPenDataRow('عدد ضربات القلب بشكل عام', bpm!),
                    _buildPenDataRow('معدل التنفس بشكل عام', breathingRate!),
                    _buildPenDataRow('معدل قوة الضغط بشكل عام', pressure!),
                    _buildPenDataRow('أعلى نبضات القلب', '130'),
                    _buildPenDataRow('أعلى درجة تنفس', '30'),
                    _buildPenDataRow('أعلى قوة ضغط', '98'),
                    _buildPenDataRow('أكثر كلمة تم تكرارها', '-'),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OldExpectations(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondColor,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black45,
                  elevation: 10,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('حفظ'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerRight,
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPenDataRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 150, child: Text(title)),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 110,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: secondColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                  ),
                ]),
            child: Text(value ?? 'null', textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.black : Colors.black87,
        ),
      ),
    );
  }
}
