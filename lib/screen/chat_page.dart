import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixerking/screen/TicketPage.dart';
import 'package:fixerking/screen/openImage.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

import '../api/api_path.dart';
import '../modal/New models/GetChatModel.dart';

class ChatPage extends StatefulWidget {
  // final SharedPreferences prefs;
  String? bookingId;
  // final String? title;
  bool? fromPost;
  String? userid;

  final providerName;
  ChatPage({this.providerName,this.bookingId,this.fromPost=false,this.userid});
  @override
  ChatPageState createState() {
    return new ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  StreamController<GetChatModel>? _postsController;

  final db = FirebaseFirestore.instance;
  CollectionReference? chatReference;
  bool _isWritting = false;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    _postsController = new StreamController();
    loadMessage();
    super.initState();
    // chatReference =
    //     db.collection("chats").doc(userID).collection('messages');
  }
  String textValue = "";
  File? imageFiles;

  Future getMessage() async {
    var userId = await MyToken.getUserID();
    var headers = {
      'Cookie': 'ci_session=132b223a903b145b8f1056a17a0c9ef325151d5f'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_chat'));
    request.fields.addAll({
      'booking_id': '${widget.bookingId}'
    });

    if(widget.fromPost == true) {
      request.fields.addAll({
        "type": "2",
        "vendor_id": "${userId}",
        "user_id": "${widget.userid}"
      });
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      // final jsonResponse = GetChatModel.fromJson(json.decode(finalResult));
      // setState(() {
      //   getChatModel = jsonResponse;
      // });
      //return json.decode(finalResult);

      return GetChatModel.fromJson(json.decode(finalResult));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  loadMessage() async {
    getMessage().then((res) async {
      _postsController!.add(res);
      return res;
    });
  }

  sendChatMessage(String type) async {
    var userId = await MyToken.getUserID();
    var headers = {
      'Cookie': 'ci_session=cb5fe5415a2e7a3e28f499c842c30404bfbc8a99'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}send_message'));
    request.fields.addAll({
      'sender_id': '${userId}',
      'sender_type': 'vendor',
      'message': '${textController.text}',
      'message_type': '${type}',
      'booking_id': '${widget.bookingId}',
    });
    if(widget.fromPost == true) {
      request.fields.addAll({
        "type": "2",
        "vendor_id": "${userId}",
        "user_id": "${widget.userid}"
      });
    }
    imageFiles == null ? null : request.files.add(
        await http.MultipartFile.fromPath(
            'chat', '${imageFiles!.path.toString()}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getMessage().then(( res)async{
        _postsController!.add(res);
        return res;
      });
      setState(() {
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text("Karan",
                // documentSnapshot.data['sender_name'],
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            // new Container(
            //   margin: const EdgeInsets.only(top: 5.0),
            //   child: documentSnapshot.data['image_url'] != ''
            //       ? InkWell(
            //     child: new Container(
            //       child: Image.network(
            //         documentSnapshot.data['image_url'],
            //         fit: BoxFit.fitWidth,
            //       ),
            //       height: 150,
            //       width: 150.0,
            //       color: Color.fromRGBO(0, 0, 0, 0.2),
            //       padding: EdgeInsets.all(5),
            //     ),
            //     onTap: () {
            //       // Navigator.of(context).push(
            //       //   MaterialPageRoute(
            //       //     builder: (context) => GalleryPage(
            //       //       imagePath: documentSnapshot.data['image_url'],
            //       //     ),
            //       //   ),
            //       // );
            //     },
            //   )
            //       : new Text(documentSnapshot.data['text']),
            // ),
          ],
        ),
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // new Container(
          //     margin: const EdgeInsets.only(left: 8.0),
          //     child: new CircleAvatar(
          //       backgroundImage:
          //       new NetworkImage(documentSnapshot.data['profile_photo']),
          //     )),
        ],
      ),
    ];
  }
  List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // new Container(
          //     margin: const EdgeInsets.only(right: 8.0),
          //     child: new CircleAvatar(
          //       backgroundImage:
          //       new NetworkImage(documentSnapshot.data['profile_photo']),
          //     )),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Karan",
                //documentSnapshot.data['sender_name'],
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            // new Container(
            //   margin: const EdgeInsets.only(top: 5.0),
            //   child: documentSnapshot.data['image_url'] != ''
            //       ? InkWell(
            //     child: new Container(
            //       child: Image.network(
            //         documentSnapshot.data['image_url'],
            //         fit: BoxFit.fitWidth,
            //       ),
            //       height: 150,
            //       width: 150.0,
            //       color: Color.fromRGBO(0, 0, 0, 0.2),
            //       padding: EdgeInsets.all(5),
            //     ),
            //     onTap: () {
            //       // Navigator.of(context).push(
            //       //   MaterialPageRoute(
            //       //     builder: (context) => GalleryPage(
            //       //       imagePath: documentSnapshot.data['image_url'],
            //       //     ),
            //       //   ),
            //       // );
            //     },
            //   )
            //       : new Text(documentSnapshot.data['text']),
            // ),
          ],
        ),
      ),
    ];
  }

  generateMessages(AsyncSnapshot<GetChatModel> snapshot) {
    return snapshot.data!.data!
        .map<Widget>((doc) {
      print("check docs here ${doc}");
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
            children: [
              Expanded(
                child: new Column(
                  crossAxisAlignment: doc.senderType == "user"
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: <Widget>[
                    // doc['sender_id'] != "1"?
                    // generateReceiverLayout(doc)
                    // Text("receiver end ")
                    //     :
                    // widget.providerId == doc['id']
                    //     ?
                    //doc.senderType == "user" ?
                    doc.message == "" || doc.message == null
                        ? SizedBox.shrink()
                        : doc.messageType == "image" ? InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OpenImagePage(image: '${doc.message}',)));
                        setState(() {
                        });
                         Container(
                           height:200,
                           width: 200,
                           child: PhotoView(
                            imageProvider: NetworkImage("${doc.message}"),
                        ),
                         );
                      },
                          child: Container(
                      height: 90,
                      width: 100,
                      child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              "${doc.message}", fit: BoxFit.fill,)
                      ),
                    ),
                        ) : Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: AppColor.PrimaryDark,
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: Text("${doc.message}",
                          // widget.user!.name.toString(),
                          //documentSnapshot.data['sender_name'],
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                        //: SizedBox(height: 0,),

                  ],
                ),
              ),
            ]
          //doc.data['sender_id']
          //     "1" != "1"
          // ? generateReceiverLayout(doc)
          // : generateSenderLayout(doc),
        ),
      );
    })
        .toList();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              )
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage()));
                  },
                  child: Icon(Icons.report_gmailerrorred,color: Colors.white,)),
            ),
          ],
          backgroundColor: AppColor.PrimaryDark,
          elevation: 0,
          title: Text(
            '${widget.providerName}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: RawMaterialButton(
              shape: CircleBorder(),
              padding: const EdgeInsets.all(0),
              fillColor: Colors.white,
              splashColor: Colors.grey[400],
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: AppColor.PrimaryDark,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )

      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: new Column(
          children: <Widget>[
            StreamBuilder<GetChatModel>(
              stream: _postsController!.stream,
              builder: (BuildContext context,
                  AsyncSnapshot<GetChatModel> snapshot) {
                if (!snapshot.hasData) return new Text("No Chat");
                return Expanded(
                  child:

                  ListView(
                    reverse: false,
                    children: generateMessages(snapshot),
                  ),
                );
              },
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme
                  .of(context)
                  .cardColor),
              child: _buildTextComposer(),
            ),
            new Builder(builder: (BuildContext context) {
              return new Container(width: 0.0, height: 0.0);
            })
          ],
        ),
      ),
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
        icon: new Icon(Icons.send, color: AppColor.PrimaryDark,),
        onPressed: () {
          if(textController.text.contains(".com")){
            Fluttertoast.showToast(msg: "Email are not allowed");
          }
          else if(textController.text.contains(RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'))){
            Fluttertoast.showToast(msg: "Mobile numbers are not allowed");
          }
          else{
            setState(() {
              sendChatMessage("text");
              getMessage().then((res) async {
                _postsController!.add(res);
                return res;
              });
              // textValue = "";
              // textController.clear();
            });
          }
        }
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isWritting
              ? Theme
              .of(context)
              .accentColor
              : Theme
              .of(context)
              .disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
                      color: AppColor.PrimaryDark,
                    ),
                    onPressed: () async {
                      // var image = await ImagePicker.
                      // pickImage(
                      //     source: ImageSource.gallery);
                      // int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      // StorageReference storageReference = FirebaseStorage
                      //     .instance
                      //     .ref()
                      //     .child('chats/img_' + timestamp.toString() + '.jpg');
                      // StorageUploadTask uploadTask =
                      // storageReference.putFile(image);
                      // await uploadTask.onComplete;
                      // String fileUrl = await storageReference.getDownloadURL();
                      PickedFile? image = await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery);
                      imageFiles = File(image!.path);
                      print("image files here ${imageFiles!.path.toString()}");
                      if (imageFiles != null) {
                        setState(() {
                          sendChatMessage("image");
                          getMessage().then((res) async {
                            _postsController!.add(res);
                            return res;
                          });
                         // textController.clear();
                        });
                      }
                    }),
              ),
              new Flexible(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: textController,
                    validator: (v){
                      if(v!.length >5 && v is int){
                        return "Number can't be send";
                      }

                      // const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                      //     r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                      //     r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                      //     r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                      //     r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                      //     r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                      //     r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                      // final regex = RegExp(pattern);
                      // return v.isNotEmpty && !regex.hasMatch(v)
                      //     ? 'Enter a valid email address'
                      //     : null;
                    },
                    onChanged: (String v){
                      setState(() {
                        textValue = v;
                      });
                      if(v.length >5 && v is int){
                        print("sdfssfs ${v}");
                        //return "Number can't be send";
                      }
                      print("sdsd ${textValue}");
                    },

                    // onChanged: (String messageText){
                    //   setState(() {
                    //     _isWritting = messageText.length >0 ;
                    //   });
                    // },
                    decoration: InputDecoration.collapsed(hintText: "Send a message"),

                  ),
                ),
                // TextFormField(
                //   controller: textController,
                //   onChanged: (String messageText) {
                //     setState(() {
                //       _isWritting = messageText.length > 0;
                //     });
                //     print("prinnnnt ${messageText}");
                //   },
                //
                //   decoration:
                //   new InputDecoration.collapsed(hintText: "Send a message"),
                // ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  // Future<Null> _sendText(String text) async {
  //   _textController.clear();
  //   chatReference!.add({
  //     'text': text,
  //     'receiver_id': "1",
  //     "sender_id" : "1",
  //     //widget.prefs.getString('uid'),
  //     'receiver_name': "Karan",
  //     //widget.prefs.getString('name'),
  //     'profile_photo' : "",
  //   //widget.prefs.getString('profile_photo'),
  //     'image_url': '',
  //     'time': FieldValue.serverTimestamp(),
  //   }).then((documentReference) {
  //     setState(() {
  //       _isWritting = false;
  //     });
  //   }).catchError((e) {});
  // }

  _sendMsg(String text) async {
    var userId = await MyToken.getUserID();
    textController.clear();
    chatReference!.add({
      'text': text,
      'received': true,
      'id': "${1}",
      "sender_id": "${userId}",
      //widget.prefs.getString('uid'),
      'name': "${widget.providerName}",
      //widget.prefs.getString('name'),
      'profile_photo': "",
      //widget.prefs.getString('profile_photo'),
      'image_url': '',
      'time': FieldValue.serverTimestamp(),
    }).then((documentReference) {
      setState(() {
        _isWritting = false;
      });
    }).catchError((e) {});
  }

  void _sendImage({ String? messageText, String? imageUrl}) {
    chatReference!.add({
      'text': messageText,

      // 'sender_id': widget.prefs.getString('uid'),
      // 'sender_name': widget.prefs.getString('name'),
      // 'profile_photo': widget.prefs.getString('profile_photo'),
      'image_url': imageUrl,
      'time': FieldValue.serverTimestamp(),
    });
  }
}
