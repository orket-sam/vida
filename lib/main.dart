import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vida/time_stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TimeStream timeStream;
  @override
  void initState() {
    timeStream = TimeStream();
    timeStream.timeStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int countDaysCurrentYear = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).difference(DateTime(DateTime.now().year - 1, 12, 31)).inDays;

    int noOfDaysCurrentYear = DateTime(
      DateTime.now().year + 1,
    ).difference(DateTime(DateTime.now().year)).inDays;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          spacing: 10,
          children: [
            Padding(
              padding: .symmetric(horizontal: 40, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: StreamBuilder(
                      stream: timeStream.timeController.stream,
                      initialData: DateTime.now(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CupertinoActivityIndicator(color: Colors.grey);
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            DateFormat('HH:mm:ss').format(snapshot.data!),
                            style: TextStyle(color: Colors.grey, fontSize: 25),
                          );
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${noOfDaysCurrentYear - countDaysCurrentYear} \nDays Remaining',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          text:
                              '${((countDaysCurrentYear / noOfDaysCurrentYear) * 100).toInt()}%',
                          style: TextStyle(
                            color: Color(0xFF22863A),
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: '\n$countDaysCurrentYear Days in',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: .symmetric(horizontal: 80.0),
                child: GridView.builder(
                  padding: .only(bottom: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 13,
                  ),
                  itemCount: DateTime(
                    DateTime.now().year + 1,
                  ).difference(DateTime(DateTime.now().year)).inDays,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: index <= countDaysCurrentYear
                              ? Color(0xFF22863A)
                              : Color(0xFF5A5A5A),
                          // borderRadius: .circular(5),
                        ),
                        width: 10,
                        height: 10,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timeStream.closeStream();
    super.dispose();
  }
}
