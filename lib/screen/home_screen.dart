import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:resetapp/constants.dart';
import 'package:resetapp/controller/form_controller.dart';
import 'package:resetapp/model/data.dart';

import 'chart.dart';
import 'custom_clip.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 5,
    )..addListener(() {
        setState(() {});
      });
  }

  String? textField;
  bool showAvg = false;
  dynamic _selectedDate;
  double _value = 1;
  double finalValue = 0;
  int currentIndex = 0;

  // List<Data> list = [];

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backwardsCompatibility: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: white),
        backgroundColor: white,
        title: Text(
          "RESET",
          style: themeData.textTheme.headline1,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$_selectedDate",
                      style: themeData.textTheme.headline2,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          width: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: primaryColor,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        SizedBox(
                          height: 25,
                          width: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: primaryColor,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                DatePicker(
                  DateTime.now(),
                  monthTextStyle: TextStyle(fontSize: 0),
                  selectionColor: primaryColor,
                  controller: DatePickerController(),
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    dynamic formattedDate = DateFormat('MM-dd').format(date);
                    setState(() {
                      _selectedDate = formattedDate;
                    });
                  },
                ),

                //Dialy Log

                SizedBox(
                  height: 10,
                ),
                Text(
                  "Dialy Log ",
                  style: themeData.textTheme.headline2,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              height: 400,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xff232d37)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 18.0,
                                          left: 12.0,
                                          top: 24,
                                          bottom: 12),
                                      child: LineChart(
                                        showAvg ? avgData() : mainData(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                    height: 34,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          showAvg = !showAvg;
                                        });
                                      },
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: showAvg
                                                ? Colors.white.withOpacity(0.5)
                                                : Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 160,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Color(0xff232d37),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 18.0,
                                    left: 12.0,
                                    top: 24,
                                    bottom: 12),
                                child: LineChart(
                                  showAvg ? avgData() : mainData(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 8,
                              child: Text(
                                "Water",
                                style: themeData.textTheme.headline4,
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 60,
                              child: Text(
                                "0%",
                                style: themeData.textTheme.headline3,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Icon(
                                Icons.circle,
                                color: white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              modelBottomSheet(context, themeData);
                            },
                            child: Container(
                              height: 160,
                              width: 120,
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 8,
                            child: Text(
                              "Sleep",
                              style: themeData.textTheme.headline4,
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 60,
                            child: Text(
                              "${finalValue.toInt()}:00",
                              style: themeData.textTheme.headline3,
                            ),
                          ),
                          Positioned(
                            left: 5,
                            bottom: 60,
                            child: Text(
                              "hours",
                              style: themeData.textTheme.headline4,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Icon(
                              Icons.circle,
                              color: white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 160,
                            width: 120,
                            decoration: BoxDecoration(
                              gradient: yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 8,
                            child: Text(
                              "Menstrual \nCycle",
                              style: themeData.textTheme.headline4,
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 60,
                            child: Text(
                              "Setup Your \nMonthly Menstrual \nCycle",
                              style: themeData.textTheme.headline4,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Icon(
                              Icons.circle,
                              color: white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //how did you fee today

                Text(
                  "How did you feel today?",
                  style: themeData.textTheme.headline2,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), color: white),
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: primaryColor,
                    controller: tabController,
                    onTap: (index) {
                      currentIndex = index;
                    },
                    tabs: [
                      Tab(
                        icon: Text(
                          '\u{1F629}',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        child: Text(
                          'Tired',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        icon: Text(
                          '\u{2639}',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        child: Text(
                          'Sad',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        icon: Text(
                          '\u{1F60B}',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        child: Text(
                          'Bleh',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        icon: Text(
                          '\u{1F642}',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        child: Text(
                          'Good',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        icon: Text(
                          '\u{1F600}',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        child: Text(
                          'Amazing',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                )

                //
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //Journal
            Text(
              "Journal",
              style: themeData.textTheme.headline2,
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: FormController.textController.text.isNotEmpty
                            ? CustomTriangleClipper()
                            : null,
                        child: FormController.textController.text.isNotEmpty
                            ? Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                          right: 0,
                          child: Icon(
                            FormController.textController.text.isNotEmpty
                                ? Icons.done
                                : null,
                            size: 20,
                            color: white,
                          ))
                    ],
                  ),
                ),
                Form(
                  key: FormController.formKey,
                  child: TextFormField(
                    validator: (_val) {
                      if (_val!.isEmpty) {
                        return "field can't be empty";
                      }
                      return null;
                    },
                    controller: FormController.textController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      focusColor: primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  var texts = FormController.textController.text;
                  if (FormController.formKey.currentState!.validate()) {
                    setState(() {
                      textField = texts;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "Complete Daily Log",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> modelBottomSheet(BuildContext context, ThemeData themeData) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              color: blue,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "SLEEP SCHEDULE",
                        style: themeData.textTheme.headline3,
                      ),
                      Text(
                        "Slide the bar to measure the amount of \nsleep you recieved last night.",
                        style: themeData.textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Hours of Sleep",
                                style: themeData.textTheme.headline4),
                            Text("${_value.toInt()} Hours",
                                style: themeData.textTheme.headline4)
                          ],
                        ),
                      ),
                      Slider(
                        value: this._value.toDouble(),
                        onChanged: (val) {
                          setState(() {
                            this._value = val;
                          });
                        },
                        min: 1,
                        max: 24,
                        label: this._value.round().toString(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: white),
                          onPressed: () {
                            setState(() {
                              this.finalValue = _value;
                            });
                          },
                          child: Text(
                            "Save Sleep Time",
                            style: themeData.textTheme.headline5,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ));
  }
}
