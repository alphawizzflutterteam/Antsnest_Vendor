import 'dart:async';
import 'dart:convert';
import 'package:fixerking/api/api_helper/ApiList.dart';
import 'package:fixerking/api/api_helper/home_api_helper.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/New%20models/LatestPostModel.dart';
import 'package:fixerking/modal/New%20models/PostStatusModel.dart';
import 'package:fixerking/modal/VendorOrderModel.dart';
import 'package:fixerking/modal/request/accept_reject_request.dart';
import 'package:fixerking/modal/request/get_new_order_request.dart';
import 'package:fixerking/modal/request/i_am_online_request.dart';
import 'package:fixerking/modal/response/accept_reject_response.dart';
import 'package:fixerking/modal/response/get_new_order_response.dart';
import 'package:fixerking/modal/response/i_am_online_response.dart';
import 'package:fixerking/screen/service_details_screen.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utility_widget/shimmer_loding_view/loding_home_page.dart';
import 'package:fixerking/utils/app_strings.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/custom_switch.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/utils/showDialog.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController<VendorOrderModel> getNewOrderStream = StreamController();
  TextEditingController reasonController = TextEditingController();
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    // getNewOders();
  }

  @override
  void dispose() {
    super.dispose();
    getNewOrderStream.close();
  }
  int? currentValue;


  LatestPostModel? latestPostModel;

  getLatestPost() async {
    var vendorId = await MyToken.getUserID();
    print("vendor id ${vendorId}");
    var headers = {'Cookie': 'ci_session=2gkq6rsuscin03924605v1edhahcke0t'};
    var request =
        http.MultipartRequest('POST', Uri.parse(BaseUrl + 'view_latest_post'));
    request.fields.addAll({'user_id': '${vendorId.toString()}'});
    print("ok ${vendorId.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = LatestPostModel.fromJson(json.decode(finalResponse));
      print("now here response ${jsonResponse.msg}");
      setState(() {
        latestPostModel = LatestPostModel.fromJson(json.decode(finalResponse));
        print("latest post model ${latestPostModel!.data![0].note}");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  bool isStatus = false;
  updateRequestFunction(String id, String value) async {
    var vendorId = await MyToken.getUserID();
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjU3NDI0MjgsImlhdCI6MTY2NTc0MjEyOCwiaXNzIjoiZXNob3AifQ.W1CPYxzUdedOnqF_9RCnXzxfXsrgXjD6afFscII8Ijc',
      'Cookie': 'ci_session=pkgacirfg4clhtgbfsecc4g4sg48jfnk'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(BaseUrl + 'accept_reject'));
    request.fields.addAll({
      'user_id': ' ${vendorId.toString()}',
      'id': '${id}',
      'status': '${value}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = PostStatusModel.fromJson(json.decode(finalResult));
      print("final result here ${jsonResponse.msg}");
      if (jsonResponse.responseCode == "1") {
        Fluttertoast.showToast(msg: "${jsonResponse.msg}");
        isStatus = true;
        // updateRequestFunction('${id}', '${value}');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

 String? selectedStatus;
  List<String> statusList = [
    "Pending",
    "Confirm",
    "Completed",
    "Cancelled by vendor",
    "Cancelled by user"
  ];

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorBg2());
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(
                "Home",
              ),
              centerTitle: true,
              backgroundColor: AppColor.PrimaryDark,
            ),
            body: RefreshIndicator(
              onRefresh: () {
                setState(() {
                  getVendorBooking("");
                });
                return getVendorBooking("");
              },
              child: SingleChildScrollView(
                child: Container(
                  // decoration: BoxDecoration(
                  //   gradient: RadialGradient(
                  //     center: Alignment(0.0, -0.1),
                  //     colors: [
                  //       AppColor().colorBg2(),
                  //       AppColor().colorBg2(),
                  //     ],
                  //     radius: 0.8,
                  //   ),
                  // ),
                  //  padding: EdgeInsets.symmetric(horizontal: ),
                  child: Column(
                    children: [
                      Container(
                        height: 11.40.h,
                        margin: EdgeInsets.only(
                          left: 8.33.w,
                        ),
                        padding: EdgeInsets.only(bottom: 1.87.h, right: 8.33.w),
                        width: 100.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(homeFg),
                          fit: BoxFit.fill,
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  currentIndex = 0;
                                });
                              },
                              child: Container(
                                height: 45,
                                alignment: Alignment.center,
                                child: text(
                                  "Bookings",
                                  textColor: currentIndex == 0
                                      ? AppColor.PrimaryDark
                                      : Colors.grey,
                                  fontSize: 14.sp,
                                  fontFamily: fontBold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  currentIndex = 1;
                                  getLatestPost();
                                });
                              },
                              child: Container(
                                height: 45,
                                alignment: Alignment.center,
                                child: text(
                                  "Latest Post",
                                  textColor: currentIndex == 1
                                      ? AppColor.PrimaryDark
                                      : Colors.grey,
                                  fontSize: 14.sp,
                                  fontFamily: fontBold,
                                ),
                              ),
                            ),
                            /*Container(
                      child: Row(
                        children: [
                          text(
                            "Online Mode",
                            textColor: Color(0xff0D7ACF),
                            fontSize: 10.sp,
                            fontFamily: fontRegular,
                          ),
                          SizedBox(
                            width: 3.05.w,
                          ),
                          CustomSwitch(
                            value: isIamOnline,
                            activeColor: Color(0xff5DD782),
                            onChanged: (value) {
                              print("VALUE : $value");
                              setState(() {
                                isIamOnline = value;
                              });
                              iamOnline();
                            },
                          ),
                        ],
                      ),
                    ),*/
                          ],
                        ),
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 20,bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColor.PrimaryDark)
                          ),
                          child:   DropdownButton(
                            value: selectedStatus,
                            underline: Container(),
                            hint: Text("Select Status"),
                            icon: Icon(Icons.keyboard_arrow_down,color: AppColor.PrimaryDark,),
                            items: statusList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedStatus = newValue!;
                                getVendorBooking(selectedStatus.toString());
                              });
                            },
                          ),
                        ),
                      ),

                      currentIndex == 0
                          ? FutureBuilder(
                              future: getVendorBooking(selectedStatus.toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                VendorOrderModel? model = snapshot.data;
                                print(model.toString());
                                if (snapshot.hasData) {
                                  return model!.responseCode == "1"
                                      ? Container(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: ClampingScrollPhysics(),
                                              itemCount: model.data!.length,
                                              itemBuilder: (context, i) {
                                                return InkWell(
                                                  // onTap: model.data![i].acceptReject ==
                                                  //         ToastString.responseCode
                                                  //     ? () {
                                                  //         // gotOderInfo(model.data!, i);
                                                  //         getNewOders(model.data![i].vId);
                                                  //       }
                                                  //     : () {
                                                  //         UtilityHlepar.getToast(
                                                  //             ToastString.pleaseAccept);
                                                  //       },
                                                  child:
                                                  Container(
                                                    width: 83.33.w,
                                                    height: 37.20.h,
                                                    margin: EdgeInsets.only(
                                                        left: 8.33.w,
                                                        right: 8.33.w,
                                                        bottom: 1.87.h),
                                                    decoration: boxDecoration(
                                                        radius: 32.0,
                                                        bgColor: AppColor()
                                                            .colorBg1()),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.44.w,
                                                                  vertical:
                                                                      3.90.h),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              // Container(
                                                              //   height: 8.81.h,
                                                              //   width: 8.81.h,
                                                              //   margin: EdgeInsets.only(right: 5),
                                                              //   child: ClipOval(
                                                              //     child: UtilityHlepar.convertetIMG(
                                                              //         snapshot.data!.booking![i]
                                                              //             .service!.serviceImage,
                                                              //         fit: BoxFit.cover),
                                                              //   ),
                                                              // ),
                                                              Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                text(
                                                                                  "${model.data![i].username}",
                                                                                  textColor: Color(0xff191919),
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: fontBold,
                                                                                ),
                                                                                // RatingBar.builder(
                                                                                //   initialRating: 4,
                                                                                //   minRating: 1,
                                                                                //   tapOnlyMode: true,
                                                                                //   direction:
                                                                                //       Axis.horizontal,
                                                                                //   allowHalfRating:
                                                                                //       true,
                                                                                //   itemCount: 5,
                                                                                //   itemSize: 1.18.h,
                                                                                //   itemPadding: EdgeInsets
                                                                                //       .symmetric(
                                                                                //           horizontal:
                                                                                //               1.0),
                                                                                //   itemBuilder:
                                                                                //       (context, _) =>
                                                                                //           Icon(
                                                                                //     Icons.star,
                                                                                //     color:
                                                                                //         Colors.amber,
                                                                                //   ),
                                                                                //   onRatingUpdate:
                                                                                //       (rating) {
                                                                                //     print(rating);
                                                                                //   },
                                                                                // ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                12.34.w,
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                    height: 1.40.h,
                                                                                    width: 1.40.h,
                                                                                    child: Image(
                                                                                      image: AssetImage(calender),
                                                                                      fit: BoxFit.fill,
                                                                                    )),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                text(
                                                                                  "${model.data![i].date}",
                                                                                  textColor: Color(0xff191919),
                                                                                  fontSize: 7.sp,
                                                                                  fontFamily: fontRegular,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          2.04.h,
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                text(
                                                                                  "Service Type",
                                                                                  textColor: Color(0xff191919),
                                                                                  fontSize: 7.sp,
                                                                                  fontFamily: fontRegular,
                                                                                ),
                                                                                text(
                                                                                  model.data![i].resName.toString(),
                                                                                  textColor: Color(0xff191919),
                                                                                  fontSize: 10.sp,
                                                                                  fontFamily: fontMedium,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                6.34.w,
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                text(
                                                                                  AppStrings.currencySymbols + " " + model.data![i].price.toString(),
                                                                                  textColor: AppColor().colorPrimaryDark(),
                                                                                  fontSize: 10.sp,
                                                                                  fontFamily: fontMedium,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15.34.w,
                                                                          ),
                                                                          model.data![i].isPaid == "0"
                                                                              ? Container(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.red),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      text(
                                                                                        "UNPAID",
                                                                                        textColor: AppColor().colorBg1(),
                                                                                        fontSize: 8.sp,
                                                                                        fontFamily: fontMedium,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.green),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      text(
                                                                                        "PAID",
                                                                                        textColor: AppColor().colorBg1(),
                                                                                        fontSize: 8.sp,
                                                                                        fontFamily: fontMedium,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(
                                                          height: 1.0,
                                                          color:
                                                              Color(0xff707070),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.44.w,
                                                                  vertical:
                                                                      2.80.h),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 2.5.h,
                                                                width: 2.5.h,
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      cardLocation),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              ),
                                                              Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          60.w,
                                                                      child:
                                                                          Text(
                                                                        model
                                                                            .data![i]
                                                                            .address
                                                                            .toString(),
                                                                        softWrap:
                                                                            true,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xff191919),
                                                                          fontSize:
                                                                              8.5.sp,
                                                                          fontFamily:
                                                                              fontRegular,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        getAcceptRejectButton(
                                                            model.data![i]
                                                                .aStatus,
                                                            model.data![i].id,
                                                            i),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          child: Center(
                                              child:
                                                  Text("No Booking Found!!")),
                                        );
                                } else if (snapshot.hasError) {
                                  return Icon(Icons.error_outline);
                                } else {
                                  return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      child: Center(
                                          child: Image.asset(
                                              "images/icons/loader.gif")));
                                }
                              })
                          : Container(
                              child:
                                  latestPostModel == null ||
                                          latestPostModel!.data!.isEmpty
                                      ? Container(
                                          child: Center(
                                            child: Text("No data to show"),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount:
                                              latestPostModel!.data!.length,
                                          itemBuilder: (context, i) {
                                            print(
                                                "result here ${latestPostModel!.data![i].note}");
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 5),
                                              child: Container(
                                                child: Card(
                                                  elevation: 1,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "#${latestPostModel!.data![i].id}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              "${latestPostModel!.data![i].date}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Service Name",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              "${latestPostModel!.data![i].note}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Price",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              "\u{20B9} ${latestPostModel!.data![i].budget}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "${latestPostModel!.data![i].location}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      latestPostModel!.data![i]
                                                                  .acceptedBy !=
                                                              null
                                                          ? Container(
                                                              height: 45,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .green,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              7)),
                                                              child: Text(
                                                                "Accepted",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            )
                                                          : latestPostModel!
                                                                      .data![i]
                                                                      .rejectedBy !=
                                                                  null
                                                              ? Container(
                                                                  height: 45,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7)),
                                                                  child: Text(
                                                                    "Rejected",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                )
                                                              : Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          updateRequestFunction(
                                                                              latestPostModel!.data![i].id.toString(),
                                                                              "reject");
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              80,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(7),
                                                                              border: Border.all(color: AppColor.PrimaryDark)),
                                                                          child:
                                                                              Text(
                                                                            "Reject",
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          updateRequestFunction(
                                                                              latestPostModel!.data![i].id.toString(),
                                                                              "accept");
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              80,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(7),
                                                                              color: Colors.green),
                                                                          child:
                                                                              Text(
                                                                            "Accept",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                            //   InkWell(
                                            //   // onTap: model.data![i].acceptReject ==
                                            //   //         ToastString.responseCode
                                            //   //     ? () {
                                            //   //         // gotOderInfo(model.data!, i);
                                            //   //         getNewOders(model.data![i].vId);
                                            //   //       }
                                            //   //     : () {
                                            //   //         UtilityHlepar.getToast(
                                            //   //             ToastString.pleaseAccept);
                                            //   //       },
                                            //   child: Container(
                                            //     width: 83.33.w,
                                            //     height: 37.20.h,
                                            //     margin: EdgeInsets.only(
                                            //         left: 8.33.w,
                                            //         right: 8.33.w,
                                            //         bottom: 1.87.h),
                                            //     decoration: boxDecoration(
                                            //         radius: 32.0,
                                            //         bgColor: AppColor().colorBg1()),
                                            //     child: Column(
                                            //       children: [
                                            //         Container(
                                            //           margin: EdgeInsets.symmetric(
                                            //               horizontal: 4.44.w,
                                            //               vertical: 3.90.h),
                                            //           child: Row(
                                            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //             children: [
                                            //               // Container(
                                            //               //   height: 8.81.h,
                                            //               //   width: 8.81.h,
                                            //               //   margin: EdgeInsets.only(right: 5),
                                            //               //   child: ClipOval(
                                            //               //     child: UtilityHlepar.convertetIMG(
                                            //               //         snapshot.data!.booking![i]
                                            //               //             .service!.serviceImage,
                                            //               //         fit: BoxFit.cover),
                                            //               //   ),
                                            //               // ),
                                            //               Container(
                                            //                 child: Column(
                                            //                   mainAxisAlignment:
                                            //                   MainAxisAlignment.start,
                                            //                   crossAxisAlignment:
                                            //                   CrossAxisAlignment
                                            //                       .start,
                                            //                   children: [
                                            //                     Container(
                                            //                       child: Row(
                                            //                         mainAxisAlignment:
                                            //                         MainAxisAlignment
                                            //                             .spaceBetween,
                                            //                         crossAxisAlignment:
                                            //                         CrossAxisAlignment
                                            //                             .center,
                                            //                         children: [
                                            //                           Container(
                                            //                             child: Column(
                                            //                               mainAxisAlignment:
                                            //                               MainAxisAlignment
                                            //                                   .start,
                                            //                               crossAxisAlignment:
                                            //                               CrossAxisAlignment
                                            //                                   .start,
                                            //                               children: [
                                            //                                 text(
                                            //                                   "${latestPostModel!.data![i].userId}",
                                            //                                   textColor:
                                            //                                   Color(0xff191919),
                                            //                                   fontSize:
                                            //                                   14.sp,
                                            //                                   fontFamily:
                                            //                                   fontBold,
                                            //                                 ),
                                            //                                 // RatingBar.builder(
                                            //                                 //   initialRating: 4,
                                            //                                 //   minRating: 1,
                                            //                                 //   tapOnlyMode: true,
                                            //                                 //   direction:
                                            //                                 //       Axis.horizontal,
                                            //                                 //   allowHalfRating:
                                            //                                 //       true,
                                            //                                 //   itemCount: 5,
                                            //                                 //   itemSize: 1.18.h,
                                            //                                 //   itemPadding: EdgeInsets
                                            //                                 //       .symmetric(
                                            //                                 //           horizontal:
                                            //                                 //               1.0),
                                            //                                 //   itemBuilder:
                                            //                                 //       (context, _) =>
                                            //                                 //           Icon(
                                            //                                 //     Icons.star,
                                            //                                 //     color:
                                            //                                 //         Colors.amber,
                                            //                                 //   ),
                                            //                                 //   onRatingUpdate:
                                            //                                 //       (rating) {
                                            //                                 //     print(rating);
                                            //                                 //   },
                                            //                                 // ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                           SizedBox(
                                            //                             width: 12.34.w,
                                            //                           ),
                                            //                           Container(
                                            //                             child: Row(
                                            //                               children: [
                                            //                                 Container(
                                            //                                     height: 1.40.h,
                                            //                                     width: 1.40.h,
                                            //                                     child:
                                            //                                     Image(
                                            //                                       image: AssetImage(
                                            //                                           calender),
                                            //                                       fit: BoxFit
                                            //                                           .fill,
                                            //                                     )),
                                            //                                 SizedBox(
                                            //                                   width: 5,
                                            //                                 ),
                                            //                                 text(
                                            //                                   latestPostModel!
                                            //                                       .data![
                                            //                                   i]
                                            //                                       .createdAt
                                            //                                       .toString(),
                                            //                                   textColor:
                                            //                                   Color(
                                            //                                       0xff191919),
                                            //                                   fontSize:
                                            //                                   7.sp,
                                            //                                   fontFamily:
                                            //                                   fontRegular,
                                            //                                 ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                         ],
                                            //                       ),
                                            //                     ),
                                            //                     SizedBox(
                                            //                       height: 2.04.h,
                                            //                     ),
                                            //                     Container(
                                            //                       child: Row(
                                            //                         mainAxisAlignment:
                                            //                         MainAxisAlignment
                                            //                             .spaceBetween,
                                            //                         crossAxisAlignment:
                                            //                         CrossAxisAlignment
                                            //                             .start,
                                            //                         children: [
                                            //                           Container(
                                            //                             child: Column(
                                            //                               mainAxisAlignment:
                                            //                               MainAxisAlignment
                                            //                                   .start,
                                            //                               crossAxisAlignment:
                                            //                               CrossAxisAlignment
                                            //                                   .start,
                                            //                               children: [
                                            //                                 text(
                                            //                                   "Service Type",
                                            //                                   textColor:
                                            //                                   Color(
                                            //                                       0xff191919),
                                            //                                   fontSize:
                                            //                                   7.sp,
                                            //                                   fontFamily:
                                            //                                   fontRegular,
                                            //                                 ),
                                            //                                 text(
                                            //                                   latestPostModel!
                                            //                                       .data![i]
                                            //                                       .note
                                            //                                       .toString(),
                                            //                                   textColor:
                                            //                                   Color(
                                            //                                       0xff191919),
                                            //                                   fontSize:
                                            //                                   10.sp,
                                            //                                   fontFamily:
                                            //                                   fontMedium,
                                            //                                 ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                           SizedBox(
                                            //                             width: 6.34.w,
                                            //                           ),
                                            //                           Container(
                                            //                             child: Column(
                                            //                               mainAxisAlignment:
                                            //                               MainAxisAlignment
                                            //                                   .start,
                                            //                               crossAxisAlignment:
                                            //                               CrossAxisAlignment
                                            //                                   .start,
                                            //                               children: [
                                            //                                 text(
                                            //                                   AppStrings.currencySymbols +
                                            //                                       " " +
                                            //                                       latestPostModel!.data![i].budget.toString(),
                                            //                                   textColor: AppColor().colorPrimaryDark(),
                                            //                                   fontSize: 10.sp,
                                            //                                   fontFamily: fontMedium,
                                            //                                 ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                           SizedBox(
                                            //                             width: 20.34.w,
                                            //                           ),
                                            //                           // model.data![i].isPaid == "0"
                                            //                           //     ? Container(
                                            //                           //   padding: EdgeInsets.all(8.0),
                                            //                           //   alignment: Alignment.center,
                                            //                           //   decoration: BoxDecoration(
                                            //                           //       borderRadius: BorderRadius.circular(10.0),
                                            //                           //       color: Colors.red
                                            //                           //   ),
                                            //                           //   child: Column(
                                            //                           //     mainAxisAlignment:
                                            //                           //     MainAxisAlignment
                                            //                           //         .start,
                                            //                           //     crossAxisAlignment:
                                            //                           //     CrossAxisAlignment
                                            //                           //         .start,
                                            //                           //     children: [
                                            //                           //       text("UNPAID",
                                            //                           //         textColor: AppColor().colorBg1(),
                                            //                           //         fontSize: 8.sp,
                                            //                           //         fontFamily: fontMedium,
                                            //                           //       ),
                                            //                           //     ],
                                            //                           //   ),
                                            //                           // )
                                            //                           //     : Container(
                                            //                           //   padding: EdgeInsets.all(8.0),
                                            //                           //   alignment: Alignment.center,
                                            //                           //   decoration: BoxDecoration(
                                            //                           //       borderRadius: BorderRadius.circular(10.0),
                                            //                           //       color: Colors.green
                                            //                           //   ),
                                            //                           //   child: Column(
                                            //                           //     mainAxisAlignment:
                                            //                           //     MainAxisAlignment
                                            //                           //         .start,
                                            //                           //     crossAxisAlignment:
                                            //                           //     CrossAxisAlignment
                                            //                           //         .start,
                                            //                           //     children: [
                                            //                           //       text("PAID",
                                            //                           //         textColor: AppColor().colorBg1(),
                                            //                           //         fontSize: 8.sp,
                                            //                           //         fontFamily: fontMedium,
                                            //                           //       ),
                                            //                           //     ],
                                            //                           //   ),
                                            //                           // ),
                                            //                         ],
                                            //                       ),
                                            //                     ),
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //         Divider(
                                            //           height: 1.0,
                                            //           color: Color(0xff707070),
                                            //         ),
                                            //         Container(
                                            //           margin: EdgeInsets.symmetric(
                                            //               horizontal: 4.44.w,
                                            //               vertical: 2.80.h),
                                            //           child: Row(
                                            //             children: [
                                            //               Container(
                                            //                 height: 2.5.h,
                                            //                 width: 2.5.h,
                                            //                 child: Image(
                                            //                   image: AssetImage(
                                            //                       cardLocation),
                                            //                   fit: BoxFit.fill,
                                            //                 ),
                                            //               ),
                                            //               SizedBox(
                                            //                 width: 1.w,
                                            //               ),
                                            //               Container(
                                            //                 child: Column(
                                            //                   mainAxisAlignment:
                                            //                   MainAxisAlignment.start,
                                            //                   crossAxisAlignment:
                                            //                   CrossAxisAlignment
                                            //                       .start,
                                            //                   children: [
                                            //                     SizedBox(
                                            //                       width: 60.w,
                                            //                       child: Text(
                                            //                         latestPostModel!.data![i].location
                                            //                             .toString(),
                                            //                         softWrap: true,
                                            //                         overflow: TextOverflow.clip,
                                            //                         style: TextStyle(
                                            //                           color: Color(
                                            //                               0xff191919),
                                            //                           fontSize: 8.5.sp,
                                            //                           fontFamily:
                                            //                           fontRegular,
                                            //                         ),
                                            //                       ),
                                            //                     ),
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //         getAcceptRejectButton(
                                            //             latestPostModel!.data![i].status,
                                            //             latestPostModel!.data![i].id, i),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // );
                                          }),
                            ),
                      // FutureBuilder(
                      //     future: getLatestPost(),
                      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //       LatestPostModel? model = snapshot.data;
                      //       if (snapshot.hasData) {
                      //         print("gbjbg");
                      //         return model!.responseCode == "1"
                      //             ? Container(
                      //           child: ListView.builder(
                      //               shrinkWrap: true,
                      //               physics: ClampingScrollPhysics(),
                      //               itemCount: model.data!.length,
                      //               itemBuilder: (context, i) {
                      //                 return InkWell(
                      //                   // onTap: model.data![i].acceptReject ==
                      //                   //         ToastString.responseCode
                      //                   //     ? () {
                      //                   //         // gotOderInfo(model.data!, i);
                      //                   //         getNewOders(model.data![i].vId);
                      //                   //       }
                      //                   //     : () {
                      //                   //         UtilityHlepar.getToast(
                      //                   //             ToastString.pleaseAccept);
                      //                   //       },
                      //                   child: Container(
                      //                     width: 83.33.w,
                      //                     height: 37.20.h,
                      //                     margin: EdgeInsets.only(
                      //                         left: 8.33.w,
                      //                         right: 8.33.w,
                      //                         bottom: 1.87.h),
                      //                     decoration: boxDecoration(
                      //                         radius: 32.0,
                      //                         bgColor: AppColor().colorBg1()),
                      //                     child: Column(
                      //                       children: [
                      //                         Container(
                      //                           margin: EdgeInsets.symmetric(
                      //                               horizontal: 4.44.w,
                      //                               vertical: 3.90.h),
                      //                           child: Row(
                      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                             children: [
                      //                               // Container(
                      //                               //   height: 8.81.h,
                      //                               //   width: 8.81.h,
                      //                               //   margin: EdgeInsets.only(right: 5),
                      //                               //   child: ClipOval(
                      //                               //     child: UtilityHlepar.convertetIMG(
                      //                               //         snapshot.data!.booking![i]
                      //                               //             .service!.serviceImage,
                      //                               //         fit: BoxFit.cover),
                      //                               //   ),
                      //                               // ),
                      //                               Container(
                      //                                 child: Column(
                      //                                   mainAxisAlignment:
                      //                                   MainAxisAlignment.start,
                      //                                   crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                                   children: [
                      //                                     Container(
                      //                                       child: Row(
                      //                                         mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .spaceBetween,
                      //                                         crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .center,
                      //                                         children: [
                      //                                           Container(
                      //                                             child: Column(
                      //                                               mainAxisAlignment:
                      //                                               MainAxisAlignment
                      //                                                   .start,
                      //                                               crossAxisAlignment:
                      //                                               CrossAxisAlignment
                      //                                                   .start,
                      //                                               children: [
                      //                                                 text(
                      //                                                   "${model.data![i].userId}",
                      //                                                   textColor:
                      //                                                   Color(0xff191919),
                      //                                                   fontSize:
                      //                                                   14.sp,
                      //                                                   fontFamily:
                      //                                                   fontBold,
                      //                                                 ),
                      //                                                 // RatingBar.builder(
                      //                                                 //   initialRating: 4,
                      //                                                 //   minRating: 1,
                      //                                                 //   tapOnlyMode: true,
                      //                                                 //   direction:
                      //                                                 //       Axis.horizontal,
                      //                                                 //   allowHalfRating:
                      //                                                 //       true,
                      //                                                 //   itemCount: 5,
                      //                                                 //   itemSize: 1.18.h,
                      //                                                 //   itemPadding: EdgeInsets
                      //                                                 //       .symmetric(
                      //                                                 //           horizontal:
                      //                                                 //               1.0),
                      //                                                 //   itemBuilder:
                      //                                                 //       (context, _) =>
                      //                                                 //           Icon(
                      //                                                 //     Icons.star,
                      //                                                 //     color:
                      //                                                 //         Colors.amber,
                      //                                                 //   ),
                      //                                                 //   onRatingUpdate:
                      //                                                 //       (rating) {
                      //                                                 //     print(rating);
                      //                                                 //   },
                      //                                                 // ),
                      //                                               ],
                      //                                             ),
                      //                                           ),
                      //                                           SizedBox(
                      //                                             width: 12.34.w,
                      //                                           ),
                      //                                           Container(
                      //                                             child: Row(
                      //                                               children: [
                      //                                                 Container(
                      //                                                     height: 1.40.h,
                      //                                                     width: 1.40.h,
                      //                                                     child:
                      //                                                     Image(
                      //                                                       image: AssetImage(
                      //                                                           calender),
                      //                                                       fit: BoxFit
                      //                                                           .fill,
                      //                                                     )),
                      //                                                 SizedBox(
                      //                                                   width: 5,
                      //                                                 ),
                      //                                                 text(
                      //                                                   model
                      //                                                       .data![
                      //                                                   i]
                      //                                                       .createdAt
                      //                                                       .toString(),
                      //                                                   textColor:
                      //                                                   Color(
                      //                                                       0xff191919),
                      //                                                   fontSize:
                      //                                                   7.sp,
                      //                                                   fontFamily:
                      //                                                   fontRegular,
                      //                                                 ),
                      //                                               ],
                      //                                             ),
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                     SizedBox(
                      //                                       height: 2.04.h,
                      //                                     ),
                      //                                     Container(
                      //                                       child: Row(
                      //                                         mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .spaceBetween,
                      //                                         crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .start,
                      //                                         children: [
                      //                                           Container(
                      //                                             child: Column(
                      //                                               mainAxisAlignment:
                      //                                               MainAxisAlignment
                      //                                                   .start,
                      //                                               crossAxisAlignment:
                      //                                               CrossAxisAlignment
                      //                                                   .start,
                      //                                               children: [
                      //                                                 text(
                      //                                                   "Service Type",
                      //                                                   textColor:
                      //                                                   Color(
                      //                                                       0xff191919),
                      //                                                   fontSize:
                      //                                                   7.sp,
                      //                                                   fontFamily:
                      //                                                   fontRegular,
                      //                                                 ),
                      //                                                 text(
                      //                                                   model
                      //                                                       .data![i]
                      //                                                       .note
                      //                                                       .toString(),
                      //                                                   textColor:
                      //                                                   Color(
                      //                                                       0xff191919),
                      //                                                   fontSize:
                      //                                                   10.sp,
                      //                                                   fontFamily:
                      //                                                   fontMedium,
                      //                                                 ),
                      //                                               ],
                      //                                             ),
                      //                                           ),
                      //                                           SizedBox(
                      //                                             width: 6.34.w,
                      //                                           ),
                      //                                           Container(
                      //                                             child: Column(
                      //                                               mainAxisAlignment:
                      //                                               MainAxisAlignment
                      //                                                   .start,
                      //                                               crossAxisAlignment:
                      //                                               CrossAxisAlignment
                      //                                                   .start,
                      //                                               children: [
                      //                                                 text(
                      //                                                   AppStrings.currencySymbols +
                      //                                                       " " +
                      //                                                       model.data![i].budget.toString(),
                      //                                                   textColor: AppColor().colorPrimaryDark(),
                      //                                                   fontSize: 10.sp,
                      //                                                   fontFamily: fontMedium,
                      //                                                 ),
                      //                                               ],
                      //                                             ),
                      //                                           ),
                      //                                           SizedBox(
                      //                                             width: 20.34.w,
                      //                                           ),
                      //                                           // model.data![i].isPaid == "0"
                      //                                           //     ? Container(
                      //                                           //   padding: EdgeInsets.all(8.0),
                      //                                           //   alignment: Alignment.center,
                      //                                           //   decoration: BoxDecoration(
                      //                                           //       borderRadius: BorderRadius.circular(10.0),
                      //                                           //       color: Colors.red
                      //                                           //   ),
                      //                                           //   child: Column(
                      //                                           //     mainAxisAlignment:
                      //                                           //     MainAxisAlignment
                      //                                           //         .start,
                      //                                           //     crossAxisAlignment:
                      //                                           //     CrossAxisAlignment
                      //                                           //         .start,
                      //                                           //     children: [
                      //                                           //       text("UNPAID",
                      //                                           //         textColor: AppColor().colorBg1(),
                      //                                           //         fontSize: 8.sp,
                      //                                           //         fontFamily: fontMedium,
                      //                                           //       ),
                      //                                           //     ],
                      //                                           //   ),
                      //                                           // )
                      //                                           //     : Container(
                      //                                           //   padding: EdgeInsets.all(8.0),
                      //                                           //   alignment: Alignment.center,
                      //                                           //   decoration: BoxDecoration(
                      //                                           //       borderRadius: BorderRadius.circular(10.0),
                      //                                           //       color: Colors.green
                      //                                           //   ),
                      //                                           //   child: Column(
                      //                                           //     mainAxisAlignment:
                      //                                           //     MainAxisAlignment
                      //                                           //         .start,
                      //                                           //     crossAxisAlignment:
                      //                                           //     CrossAxisAlignment
                      //                                           //         .start,
                      //                                           //     children: [
                      //                                           //       text("PAID",
                      //                                           //         textColor: AppColor().colorBg1(),
                      //                                           //         fontSize: 8.sp,
                      //                                           //         fontFamily: fontMedium,
                      //                                           //       ),
                      //                                           //     ],
                      //                                           //   ),
                      //                                           // ),
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           height: 1.0,
                      //                           color: Color(0xff707070),
                      //                         ),
                      //                         Container(
                      //                           margin: EdgeInsets.symmetric(
                      //                               horizontal: 4.44.w,
                      //                               vertical: 2.80.h),
                      //                           child: Row(
                      //                             children: [
                      //                               Container(
                      //                                 height: 2.5.h,
                      //                                 width: 2.5.h,
                      //                                 child: Image(
                      //                                   image: AssetImage(
                      //                                       cardLocation),
                      //                                   fit: BoxFit.fill,
                      //                                 ),
                      //                               ),
                      //                               SizedBox(
                      //                                 width: 1.w,
                      //                               ),
                      //                               Container(
                      //                                 child: Column(
                      //                                   mainAxisAlignment:
                      //                                   MainAxisAlignment.start,
                      //                                   crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                                   children: [
                      //                                     SizedBox(
                      //                                       width: 60.w,
                      //                                       child: Text(
                      //                                         model.data![i].location
                      //                                             .toString(),
                      //                                         softWrap: true,
                      //                                         overflow: TextOverflow.clip,
                      //                                         style: TextStyle(
                      //                                           color: Color(
                      //                                               0xff191919),
                      //                                           fontSize: 8.5.sp,
                      //                                           fontFamily:
                      //                                           fontRegular,
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         getAcceptRejectButton(
                      //                             model.data![i].status,
                      //                             model.data![i].id, i),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 );
                      //               }),
                      //         )
                      //             : Container(
                      //           height: MediaQuery.of(context).size.height/1.5,
                      //           child: Center(child: Text("No Booking Found!!")),
                      //         );
                      //       } else if (snapshot.hasError) {
                      //         return Icon(Icons.error_outline);
                      //       } else {
                      //         return Container(
                      //             height: MediaQuery.of(context).size.height/1.5,
                      //             child: Center(child: Image.asset("images/icons/loader.gif")));
                      //       }
                      //     }),
                    ],
                  ),
                ),
              ),
            )));
  }

  getAcceptRejectButton(value, bookingId, i) {
    print(
        "VALUE ===== $value &&&& BOOKING ID === $bookingId &&&& INDEX === $i");
    switch (value) {
      case "1":
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.44.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: ()async{
                  await _displayTextInputDialog(context, bookingId);
                },
                child: Container(
                  width: 32.77.w,
                  height: 4.92.h,
                  margin: EdgeInsets.only(right: 2.w),
                  decoration: boxDecoration(
                    radius: 6.0,
                    color: AppColor().colorPrimaryDark(),
                  ),
                  child: Center(
                    child: text(
                      "Reject",
                      textColor: AppColor().colorTextFour(),
                      fontSize: 10.sp,
                      fontFamily: fontRegular,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => MYDialog.showAlertDialogWithTwobtn(context,
                    title: ToastString.doYouWantAccept,
                    body: "",
                    funtionName: () =>
                        acceptReject(status: "accept", id: bookingId)),
                child: Container(
                  width: 32.77.w,
                  height: 4.92.h,
                  margin: EdgeInsets.only(right: 2.w),
                  decoration: boxDecoration(
                    radius: 6.0,
                    bgColor: Color(0xff13CE3F),
                  ),
                  child: Center(
                    child: text(
                      "Accept",
                      textColor: AppColor().colorBg1(),
                      fontSize: 10.sp,
                      fontFamily: fontRegular,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case "2":
        return InkWell(
          onTap: () => getNewOders(i),
          child: Container(
            alignment: Alignment.center,
            width: 70.w,
            height: 5.8.h,
            decoration: boxDecoration(
              radius: 6.0,
              bgColor: Color(0xff13CE3F),
            ),
            child: text("view info"),
          ),
        );
      case "3":
        return InkWell(
          onTap: () => getNewOders(i),
          // gotOderInfo(model.data!, i),
          child: Container(
            alignment: Alignment.center,
            width: 70.w,
            height: 5.8.h,
            decoration: boxDecoration(
              radius: 6.0,
              bgColor: Colors.redAccent,
            ),
            child: text("Booking Cancelled by User"),
          ),
        );
      case "4":
        return InkWell(
          onTap: () => getNewOders(i),
          // gotOderInfo(model.data!, i),
          child: Container(
            alignment: Alignment.center,
            width: 70.w,
            height: 5.8.h,
            decoration: boxDecoration(
              radius: 6.0,
              bgColor: Colors.redAccent,
            ),
            child: text("Booking Cancelled by Vendor"),
          ),
        );
      case "5":
        return InkWell(
          onTap: () => getNewOders(i),
          // gotOderInfo(model.data!, i),
          child: Container(
            alignment: Alignment.center,
            width: 70.w,
            height: 5.8.h,
            decoration: boxDecoration(
              radius: 6.0,
              bgColor: Colors.green,
            ),
            child: text("Completed"),
          ),
        );
    }
  }

  _displayTextInputDialog(BuildContext context, bookingId){
    return  showDialog(
      context: context,
      builder: (BuildContext context) {
        return  StatefulBuilder(builder: (BuildContext context,
            StateSetter setState){
          return AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height/2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                        "Booking Cancel Reason",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentValue = 0;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(
                                  100),
                              color: currentValue == 0 ? Colors
                                  .green : Colors.transparent,
                              border: Border
                                  .all(
                                  color: Colors
                                      .grey)
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.8,
                            child: Text(
                              "Unavailable on the requested dates",
                              style: TextStyle(
                                  fontSize: 15),)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentValue = 1;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(
                                  100),
                              color: currentValue ==
                                  1
                                  ? Colors.green
                                  : Colors
                                  .transparent,
                              border: Border
                                  .all(
                                  color: Colors
                                      .grey)
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.8,
                            child: Text(
                              "Incorrect pricing",
                              style: TextStyle(
                                  fontSize: 15),
                              maxLines: 2,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentValue = 2;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(
                                  100),
                              color: currentValue ==
                                  2
                                  ? Colors.green
                                  : Colors
                                  .transparent,
                              border: Border
                                  .all(
                                  color: Colors
                                      .grey)
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.8,
                            child: Text(
                              "Unsuitable location",
                              style: TextStyle(
                                  fontSize: 15),
                              maxLines: 2,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentValue = 3;
                      });
                      print("ssssssssssss");
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(
                                  100),
                              color: currentValue ==
                                  3
                                  ? Colors.green
                                  : Colors
                                  .transparent,
                              border: Border
                                  .all(
                                  color: Colors
                                      .grey)
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.8,
                            child: Text(
                              "Incorrect description",
                              style: TextStyle(
                                  fontSize: 15),
                              maxLines: 2,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentValue = 4;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(
                                  100),
                              color: currentValue ==
                                  4
                                  ? Colors.green
                                  : Colors
                                  .transparent,
                              border: Border
                                  .all(
                                  color: Colors
                                      .grey)
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.8,
                            child: Text(
                              "Lack of communication",
                              style: TextStyle(
                                  fontSize: 15),
                              maxLines: 2,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentValue = 5;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(
                                  100),
                              color: currentValue ==
                                  5
                                  ? Colors.green
                                  : Colors
                                  .transparent,
                              border: Border
                                  .all(
                                  color: Colors
                                      .grey)
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.8,
                            child: Text(
                              "Other (Please Specify)",
                              style: TextStyle(
                                fontSize: 15,),
                              maxLines: 2,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 3,),
                  currentValue == 5 ?    Container(
                    margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                    child: TextField(
                      controller: reasonController,
                      keyboardType: TextInputType.multiline,
                      decoration:
                      InputDecoration(hintText: "Enter Cancel Reason"),
                    ),
                  ) : SizedBox.shrink(),
                  // butn
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 30,
                            width: 60,
                            alignment: Alignment.center,
                            child: Text(
                              "NO",
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        InkWell(
                          onTap: () => acceptReject(
                              status: "reject",
                              id: bookingId,
                              reason: currentValue == 5 ? reasonController.text : currentValue == 0 ? 'Unavailable on the requested dates' : currentValue == 1 ? 'Incorrect pricing' : currentValue == 2 ? 'Unsuitable location' : currentValue == 3 ? 'Incorrect description' :  'Lack of communication'),
                          child: Container(
                            height: 30,
                            width: 60,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "YES",
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  late IamOnlineResponse iamOnlineResponse;

  iamOnline() async {
    String userid = await MyToken.getUserID();
    String status = isIamOnline ? "1" : "0";
    IamOnlineRequest request = IamOnlineRequest(userid: userid, status: status);
    iamOnlineResponse = await HomeApiHelper.iamOnline(request);
    UtilityHlepar.getToast(iamOnlineResponse.message.toString());
    print(request.tojson());
  }

  late VendorOrderModel orderResponse;

  getNewOders(i) async {
    var userid = await MyToken.getUserID();
    GetNewOrderRequest request = GetNewOrderRequest(userId: userid);
    orderResponse = await HomeApiHelper.getNewOrder(request);
    if (orderResponse.responseCode == ToastString.responseCode) {
      getNewOrderStream.sink.add(orderResponse);
      gotOderInfo(orderResponse, i);
    } else {
      getNewOrderStream.sink.addError(orderResponse.msg.toString());
    }
  }

// acceptReject
  acceptReject({required status, required id, reason}) async {
    Navigator.pop(context);
    MYDialog.loadingDialog(context);
    late AcceptRejectResponse response;
    String statusType = status.toString();
    String bookingId = id.toString();
    String cancelReason = "";
    if (statusType == "reject") {
      cancelReason = reason.toString();
    }
    AcceptRejectRequest request = AcceptRejectRequest(
        statusType: statusType, bookingId: bookingId, reason: cancelReason);
    print(request.toString());
    response = await HomeApiHelper.acceptReject(request);
    if (response.responseCode == ToastString.responseCode) {
      // UtilityHlepar.getToast(response.message.toString());
      Navigator.pop(context);
      setState(() {
        getVendorBooking("");
      });
    }
  }

  gotOderInfo(response, i) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ServiceScreenDetails(
                  orderResponse: response,
                  i: i,
                )));
    getVendorBooking("");
  }

  Future<VendorOrderModel?> getVendorBooking(String selectedValue) async {
    print("selected value ${selectedValue}");
    var userId = await MyToken.getUserID();
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_bookings'));
    request.fields.addAll({'user_id': '$userId','status': selectedValue == "Pending" ? "1" : selectedValue == "Confirm" ? "2" : selectedValue == "Cancelled by user"  ? "3" : selectedValue == "Cancelled by vendor" ? "4"  : selectedValue == "Completed" ? "5" : ""});
    print(request);
    print("booking param" + request.fields.toString());
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      return VendorOrderModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
}
