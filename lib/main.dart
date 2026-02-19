import 'package:flutter/material.dart';
import 'package:vida/constants.dart';
import 'package:vida/time_stream.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0D1117),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    Text(
                      '"Make Today Count!"',
                      style: TextStyle(
                        color: Color(0xff8B949E),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Divider(height: 35, color: kPrimaryBlue),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xff161B22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 10,
                  children: TimeStream()
                      .currentWeek()
                      .map(
                        (d) => Container(
                          padding: d.weekday == DateTime.now().weekday
                              ? EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                )
                              : null,
                          decoration: d.weekday == DateTime.now().weekday
                              ? BoxDecoration(
                                  color: kPrimaryBlue,
                                  borderRadius: BorderRadius.circular(8),
                                )
                              : null,
                          child: Column(
                            spacing: 4,
                            children: [
                              Text(
                                weekdays[d.weekday - 1],
                                style: TextStyle(
                                  color: d.weekday == DateTime.now().weekday
                                      ? Colors.white
                                      : Color(0xff8B949E),
                                ),
                              ),

                              Text(
                                '${d.day}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 30),

              Center(
                child: Column(
                  children: [
                    Text(
                      DateFormat('HH:mm:ss').format(DateTime.now()),
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    Text(
                      DateFormat(
                        DateFormat.YEAR_MONTH_DAY,
                      ).format(DateTime.now()),
                      style: TextStyle(color: Color(0xff8B949E)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                spacing: 20,
                children: [
                  TextCard(title: 'days passed', count: 100),
                  TextCard(title: 'remaining', count: 265),
                ],
              ),
              SizedBox(height: 30),

              Text(
                'YEARLY PROGRESS',
                style: TextStyle(
                  color: Color(0xff8B949E),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 365,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 30,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (context, i) => Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: i < 130 ? kPrimaryBlue : null,
                      border: i < 130
                          ? null
                          : Border.all(color: Color(0xff30363D)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  final String title;
  final int count;
  const TextCard({required this.count, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xff161B22),
          border: Border.all(color: Color(0xff30363D)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(color: Color(0xff8B949E)),
            ),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
