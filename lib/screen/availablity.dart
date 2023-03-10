import 'dart:convert';

import 'package:fixerking/api/api_helper/ApiList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../token/app_token_data.dart';
import '../utils/colors.dart';

class Availability extends StatefulWidget {
  const Availability({Key? key}) : super(key: key);

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  List selectedIndex = [];
  List<String> fromTimelist = [];
  List<String> toTimeList = [];

  String currentIndex = 'all';
  String currentIndex1 = "Monday";
  String currentIndex2 = "Tuesday";
  String currentIndex3 = 'Wednesday';
  String currentIndex4 = 'Thursday';
  String currentIndex5 = 'Friday';
  String currentIndex6 = 'Saturday';
  String currentIndex7 = 'Sunday';

  String? selectedValue,
        selectedValue1,
        selectedMondayValue,
        selectedMondayValue1,
        selectedTuesdayvalue,
        selectedTuesdayValue1,
        selectedWednesdayValue,
        selectedWednesdayValue1,
        selectedThursdayValue,
        selectedThursdayValue1,
        selectedFridayValue,
        selectedFridayValue1,
        selectedSatauradayvalue,
        selectedSatuardayValue1,
        selectedSundayValue,
        selectedSundayValue1;

  String? _selectedTime;

  String userid = '';
  getUserId()async{
     userid = await MyToken.getUserID();
  }

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      return getUserId();
    });
  }

  addAvailability()async{
    var headers = {
      'Cookie': 'ci_session=5f90b3d93165f3d9681737ef19bc9c9b6503e7f2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${BaseUrl}add_availability'));
    //var fromTime; var toTime; var sDay;
    // for(var i=0;i<fromTimelist.length;i++){
    //   fromTime = fromTimelist[i];
    // }
    // for(var i=0;i<toTimeList.length;i++){
    //   toTime = toTimeList[i];
    // }
    // for(var i=0;i<selectedIndex.length;i++){
    //   sDay = selectedIndex[i];
    // }
    String fromTime = fromTimelist.join(",");
    String toTimee  = toTimeList.join(",");
    String sDay = selectedIndex.join(",");
    request.fields.addAll({
      'user_id': '${userid}',
      'from_time':'${fromTime}',
      'to_time': '${toTimee}',
      'day': '${sDay}'
    });
    print("checking params ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("checking response here ${jsonResponse.toString()}");
      setState(() {
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      });
      Navigator.pop(context);
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Availability",
        ),
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (selectedIndex.contains(currentIndex)) {
                      selectedIndex.remove(currentIndex);

                    } else {
                      selectedIndex.add(currentIndex);

                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          // padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: selectedIndex.contains(currentIndex)
                              ? Center(
                                  child: Icon(
                                  Icons.check,
                                  size: 16,
                                ))
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "All Days",
                          style:
                              TextStyle(color: AppColor().colorTextPrimary()),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {

                                    selectedValue = result.format(context).toString();
                                    fromTimelist.add(selectedValue.toString());
                                    print(selectedValue.toString());
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                //   width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)),
                                child: selectedValue == null
                                    ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                    : Text("${selectedValue}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedValue1 = result.format(context);
                                    print(selectedValue1.toString());
                                    toTimeList.add(selectedValue1.toString());
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                //  width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)),
                                child: selectedValue1 == null
                                    ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                    : Text("${selectedValue1}"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap:  () {
                    if(selectedIndex.contains(currentIndex)){
                    }
                    else{
                      if (selectedIndex.contains(currentIndex1)) {
                        selectedIndex.remove(currentIndex1);
                      } else {
                        selectedIndex.add(currentIndex1);
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          // padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: selectedIndex.contains(currentIndex1)
                              ? Center(
                                  child: Icon(
                                  Icons.check,
                                  size: 16,
                                ))
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Monday",
                          style:
                              TextStyle(color: AppColor().colorTextPrimary()),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedMondayValue =
                                        result.format(context);
                                    print(selectedMondayValue.toString());
                                    fromTimelist.add(selectedMondayValue.toString());
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  height: 40,
                                  width: 80,
                                  alignment: Alignment.center,
                                  //   width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.black)),
                                  child: selectedMondayValue == null
                                      ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                      : Text("${selectedMondayValue}")),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedMondayValue1 =
                                        result.format(context);
                                    print(selectedMondayValue1.toString());
                                    toTimeList.add(selectedMondayValue1.toString());
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  height: 40,
                                  width: 80,
                                  alignment: Alignment.center,
                                  //  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.black)),
                                  child: selectedMondayValue1 == null
                                      ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                      : Text("${selectedMondayValue1}")),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if(selectedIndex.contains(currentIndex)){
                    }
                    else {
                      if (selectedIndex.contains(currentIndex2)) {
                        selectedIndex.remove(currentIndex2);
                      } else {
                        selectedIndex.add(currentIndex2);
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          // padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: selectedIndex.contains(currentIndex2)
                              ? Center(
                                  child: Icon(
                                  Icons.check,
                                  size: 16,
                                ))
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Tuesday",
                          style:
                              TextStyle(color: AppColor().colorTextPrimary()),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedTuesdayvalue =
                                        result.format(context);
                                    print(selectedTuesdayvalue.toString());
                                    fromTimelist.add(selectedTuesdayvalue.toString());
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  height: 40,
                                  width: 80,
                                  alignment: Alignment.center,
                                  //   width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.black)),
                                  child: selectedTuesdayvalue == null
                                      ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                      : Text("${selectedTuesdayvalue}")),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedTuesdayValue1 =
                                        result.format(context);
                                    print(selectedTuesdayValue1.toString());
                                    toTimeList.add(selectedTuesdayValue1.toString());
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  height: 40,
                                  width: 80,
                                  alignment: Alignment.center,
                                  //  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.black)),
                                  child: selectedTuesdayValue1 == null
                                      ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                      : Text("${selectedTuesdayValue1}")),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if(selectedIndex.contains(currentIndex)){
                    }
                    else {
                      if (selectedIndex.contains(currentIndex3)) {
                        selectedIndex.remove(currentIndex3);
                      } else {
                        selectedIndex.add(currentIndex3);
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          // padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: selectedIndex.contains(currentIndex3)
                              ? Center(
                                  child: Icon(
                                  Icons.check,
                                  size: 16,
                                ))
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Wednesday",
                          style:
                              TextStyle(color: AppColor().colorTextPrimary()),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedWednesdayValue =
                                        result.format(context);
                                    print(selectedWednesdayValue.toString());
                                    fromTimelist.add(selectedWednesdayValue.toString());
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                //   width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)),
                                child: selectedWednesdayValue == null
                                    ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                    : Text("${selectedWednesdayValue}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedWednesdayValue1 =
                                        result.format(context);
                                    print(selectedWednesdayValue1.toString());
                                    toTimeList.add(selectedWednesdayValue1.toString());
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                //  width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)),
                                child: selectedWednesdayValue1 == null
                                    ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                    : Text("${selectedWednesdayValue1}"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if(selectedIndex.contains(currentIndex)){
                    }
                    else {
                      if (selectedIndex.contains(currentIndex4)){
                        selectedIndex.remove(currentIndex4);
                      } else {
                        selectedIndex.add(currentIndex4);
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          // padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: selectedIndex.contains(currentIndex4)
                              ? Center(
                                  child: Icon(
                                  Icons.check,
                                  size: 16,
                                ))
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Thursday",
                          style:
                              TextStyle(color: AppColor().colorTextPrimary()),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedThursdayValue =
                                        result.format(context);
                                    print(selectedThursdayValue.toString());
                                    fromTimelist.add(selectedThursdayValue.toString());
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 80,
                                  //   width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.black)),
                                  child: selectedThursdayValue == null
                                      ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                      : Text("${selectedThursdayValue}")),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedThursdayValue1 =
                                        result.format(context);
                                    print(selectedThursdayValue1.toString());
                                    toTimeList.add(selectedThursdayValue1.toString());
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  //  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.black)),
                                  child: selectedThursdayValue1 == null
                                      ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                      : Text("${selectedThursdayValue1}")),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if(selectedIndex.contains(currentIndex)){
                    }
                    else {
                      if (selectedIndex.contains(currentIndex5)) {
                        selectedIndex.remove(currentIndex5);
                      } else {
                        selectedIndex.add(currentIndex5);
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          // padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: selectedIndex.contains(currentIndex5)
                              ? Center(
                                  child: Icon(
                                  Icons.check,
                                  size: 16,
                                ))
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Friday",
                          style:
                              TextStyle(color: AppColor().colorTextPrimary()),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedFridayValue =
                                        result.format(context);
                                    print(selectedFridayValue.toString());
                                    fromTimelist.add(selectedFridayValue.toString());
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                //   width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)),
                                child: selectedFridayValue == null
                                    ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                    : Text("${selectedFridayValue}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedFridayValue1 =
                                        result.format(context);
                                    print(selectedFridayValue1.toString());
                                    toTimeList.add(selectedFridayValue1.toString());
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  height: 40,
                                  width: 80,
                                  alignment: Alignment.center,
                                  //  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.black)),
                                  child: selectedFridayValue1 == null
                                      ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                      : Text("${selectedFridayValue1}")),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if(selectedIndex.contains(currentIndex)){
                    }
                    else {
                      if (selectedIndex.contains(currentIndex6)) {
                        selectedIndex.remove(currentIndex6);
                      } else {
                        selectedIndex.add(currentIndex6);
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          // padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: selectedIndex.contains(currentIndex6)
                              ? Center(
                                  child: Icon(
                                  Icons.check,
                                  size: 16,
                                ))
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Saturday",
                          style:
                              TextStyle(color: AppColor().colorTextPrimary()),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedSatauradayvalue =
                                        result.format(context);
                                    print(selectedSatauradayvalue.toString());
                                    fromTimelist.add(selectedSatauradayvalue.toString());
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                //   width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)),
                                child: selectedSatauradayvalue == null
                                    ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                    : Text("${selectedSatauradayvalue}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedSatuardayValue1 =
                                        result.format(context);
                                    print(selectedSatuardayValue1.toString());
                                    toTimeList.add(selectedSatuardayValue1.toString());
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  height: 40,
                                  width: 80,
                                  alignment: Alignment.center,
                                  //  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.black)),
                                  child: selectedSatuardayValue1 == null
                                      ? Text("Select Time",style: TextStyle(fontSize: 13),)
                                      : Text("${selectedSatuardayValue1}")),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if(selectedIndex.contains(currentIndex)){
                    }
                    else {
                      if (selectedIndex.contains(currentIndex7)) {
                        selectedIndex.remove(currentIndex7);
                        print("checking remove ${selectedIndex}");
                      } else {
                        selectedIndex.add(currentIndex7);
                        print("checking add ${selectedIndex}");
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          // padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: selectedIndex.contains(currentIndex7)
                              ? Center(
                                  child: Icon(
                                  Icons.check,
                                  size: 16,
                                ))
                              : SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sunday",
                          style:
                              TextStyle(color: AppColor().colorTextPrimary()),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: ()async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedSundayValue = result.format(context);
                                    print(selectedSundayValue.toString());
                                    fromTimelist.add(selectedSundayValue.toString());
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                height: 40,
                                  width: 80,
                                alignment: Alignment.center,
                                //   width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)),
                                child: selectedSundayValue == null ? Text("Select Time",style: TextStyle(fontSize: 13),) : Text("${selectedSundayValue}")
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Time"),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: ()async {
                                final TimeOfDay? result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.PrimaryDark,
                                          )
                                      ) , child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                              alwaysUse24HourFormat: false),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!));
                                    });
                                if (result != null) {
                                  setState(() {
                                    selectedSundayValue1 = result.format(context);
                                    print(selectedSundayValue1.toString());
                                    toTimeList.add(selectedSundayValue1.toString());
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                height: 40,
                                  width: 80,
                                alignment: Alignment.center,
                                //  width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)),
                                child:selectedSundayValue1 == null ? Text("Select Time",style: TextStyle(fontSize: 13),) : Text("${selectedSundayValue1}")
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                addAvailability();
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  color: AppColor.PrimaryDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500,),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
