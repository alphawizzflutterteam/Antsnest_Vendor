import 'dart:convert';
/// response_code : "1"
/// msg : "My Bookings"
/// data : [{"email":"shivam15alphawizz@gmail.com","mobile":"8319040004","username":"Shivam 12 Kanathe","id":"277","date":"2022-11-04","slot":"6:02 AM","user_id":"31","res_id":"198","size":"ghh","status":"Confirm","a_status":"2","reason":null,"is_paid":"0","otp":"4125","amount":"20","txn_id":"","p_date":"0000-00-00","address":"G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101","address_id":"33","payment_type":"","created_at":"2022-11-04 05:32:59","subtotal":"20.00","discount":"100.00","addons":"10000.00","addon_service":null,"total":"10020.00","price":"20","res_name":"Service Here","res_desc":"dummy description here"},{"email":"shivam15alphawizz@gmail.com","mobile":"8319040004","username":"Shivam 12 Kanathe","id":"276","date":"2022-11-04","slot":"5:55 AM","user_id":"31","res_id":"197","size":"hhh","status":"Confirm","a_status":"2","reason":null,"is_paid":"0","otp":"4357","amount":"3","txn_id":"","p_date":"0000-00-00","address":"G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101","address_id":"33","payment_type":"","created_at":"2022-11-04 05:25:46","subtotal":"3.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"0.00","price":"3","res_name":"dummy service ","res_desc":"dummy"},{"email":"shivam15alphawizz@gmail.com","mobile":"8319040004","username":"Shivam 12 Kanathe","id":"275","date":"2022-11-04","slot":"5:53 AM","user_id":"31","res_id":"198","size":"gg","status":"Pending","a_status":"1","reason":null,"is_paid":"0","otp":"4117","amount":"20","txn_id":"","p_date":"0000-00-00","address":"G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101","address_id":"33","payment_type":"","created_at":"2022-11-04 05:24:24","subtotal":"20.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"0.00","price":"20","res_name":"Service Here","res_desc":"dummy description here"},{"email":"shivam15alphawizz@gmail.com","mobile":"8319040004","username":"Shivam 12 Kanathe","id":"274","date":"2022-11-04","slot":"5:53 AM","user_id":"31","res_id":"198","size":"gg","status":"Cancelled by vendor","a_status":"4","reason":"no time","is_paid":"0","otp":"1370","amount":"20","txn_id":"","p_date":"0000-00-00","address":"G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101","address_id":"33","payment_type":"","created_at":"2022-11-04 05:24:15","subtotal":"20.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"0.00","price":"20","res_name":"Service Here","res_desc":"dummy description here"},{"email":"shivam15alphawizz@gmail.com","mobile":"8319040004","username":"Shivam 12 Kanathe","id":"233","date":"2022-10-12","slot":"1:33 AM","user_id":"31","res_id":"198","size":"fff","status":"Confirm","a_status":"2","reason":null,"is_paid":"0","otp":"2841","amount":"5000","txn_id":"","p_date":"2022-10-12","address":"G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 201","address_id":"34","payment_type":"","created_at":"2022-10-12 01:03:35","subtotal":"0.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"0.00","price":"20","res_name":"Service Here","res_desc":"dummy description here"},{"email":"shivam15alphawizz@gmail.com","mobile":"8319040004","username":"Shivam 12 Kanathe","id":"232","date":"2022-10-12","slot":"1:19 AM","user_id":"31","res_id":"198","size":"jjjjj","status":"Confirm","a_status":"2","reason":null,"is_paid":"0","otp":"2599","amount":"5000","txn_id":"","p_date":"2022-10-12","address":"G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101","address_id":"33","payment_type":"","created_at":"2022-10-12 00:49:51","subtotal":"0.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"0.00","price":"20","res_name":"Service Here","res_desc":"dummy description here"}]

VendorOrderModel vendorOrderModelFromJson(String str) => VendorOrderModel.fromJson(json.decode(str));
String vendorOrderModelToJson(VendorOrderModel data) => json.encode(data.toJson());
class VendorOrderModel {
  VendorOrderModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  VendorOrderModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
VendorOrderModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => VendorOrderModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// email : "shivam15alphawizz@gmail.com"
/// mobile : "8319040004"
/// username : "Shivam 12 Kanathe"
/// id : "277"
/// date : "2022-11-04"
/// slot : "6:02 AM"
/// user_id : "31"
/// res_id : "198"
/// size : "ghh"
/// status : "Confirm"
/// a_status : "2"
/// reason : null
/// is_paid : "0"
/// otp : "4125"
/// amount : "20"
/// txn_id : ""
/// p_date : "0000-00-00"
/// address : "G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101"
/// address_id : "33"
/// payment_type : ""
/// created_at : "2022-11-04 05:32:59"
/// subtotal : "20.00"
/// discount : "100.00"
/// addons : "10000.00"
/// addon_service : null
/// total : "10020.00"
/// price : "20"
/// res_name : "Service Here"
/// res_desc : "dummy description here"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? email, 
      String? mobile, 
      String? username, 
      String? id, 
      String? date, 
      String? slot, 
      String? userId, 
      String? resId, 
      String? size, 
      String? status, 
      String? aStatus, 
      dynamic reason, 
      String? isPaid, 
      String? otp, 
      String? amount, 
      String? txnId, 
      String? pDate, 
      String? address, 
      String? addressId, 
      String? paymentType, 
      String? createdAt, 
      String? subtotal, 
      String? discount, 
      String? addons, 
      dynamic addonService, 
      String? total, 
      String? price, 
      String? resName, 
      String? resDesc,}){
    _email = email;
    _mobile = mobile;
    _username = username;
    _id = id;
    _date = date;
    _slot = slot;
    _userId = userId;
    _resId = resId;
    _size = size;
    _status = status;
    _aStatus = aStatus;
    _reason = reason;
    _isPaid = isPaid;
    _otp = otp;
    _amount = amount;
    _txnId = txnId;
    _pDate = pDate;
    _address = address;
    _addressId = addressId;
    _paymentType = paymentType;
    _createdAt = createdAt;
    _subtotal = subtotal;
    _discount = discount;
    _addons = addons;
    _addonService = addonService;
    _total = total;
    _price = price;
    _resName = resName;
    _resDesc = resDesc;
}

  Data.fromJson(dynamic json) {
    _email = json['email'];
    _mobile = json['mobile'];
    _username = json['username'];
    _id = json['id'];
    _date = json['date'];
    _slot = json['slot'];
    _userId = json['user_id'];
    _resId = json['res_id'];
    _size = json['size'];
    _status = json['status'];
    _aStatus = json['a_status'];
    _reason = json['reason'];
    _isPaid = json['is_paid'];
    _otp = json['otp'];
    _amount = json['amount'];
    _txnId = json['txn_id'];
    _pDate = json['p_date'];
    _address = json['address'];
    _addressId = json['address_id'];
    _paymentType = json['payment_type'];
    _createdAt = json['created_at'];
    _subtotal = json['subtotal'];
    _discount = json['discount'];
    _addons = json['addons'];
    _addonService = json['addon_service'];
    _total = json['total'];
    _price = json['price'];
    _resName = json['res_name'];
    _resDesc = json['res_desc'];
  }
  String? _email;
  String? _mobile;
  String? _username;
  String? _id;
  String? _date;
  String? _slot;
  String? _userId;
  String? _resId;
  String? _size;
  String? _status;
  String? _aStatus;
  dynamic _reason;
  String? _isPaid;
  String? _otp;
  String? _amount;
  String? _txnId;
  String? _pDate;
  String? _address;
  String? _addressId;
  String? _paymentType;
  String? _createdAt;
  String? _subtotal;
  String? _discount;
  String? _addons;
  dynamic _addonService;
  String? _total;
  String? _price;
  String? _resName;
  String? _resDesc;
Data copyWith({  String? email,
  String? mobile,
  String? username,
  String? id,
  String? date,
  String? slot,
  String? userId,
  String? resId,
  String? size,
  String? status,
  String? aStatus,
  dynamic reason,
  String? isPaid,
  String? otp,
  String? amount,
  String? txnId,
  String? pDate,
  String? address,
  String? addressId,
  String? paymentType,
  String? createdAt,
  String? subtotal,
  String? discount,
  String? addons,
  dynamic addonService,
  String? total,
  String? price,
  String? resName,
  String? resDesc,
}) => Data(  email: email ?? _email,
  mobile: mobile ?? _mobile,
  username: username ?? _username,
  id: id ?? _id,
  date: date ?? _date,
  slot: slot ?? _slot,
  userId: userId ?? _userId,
  resId: resId ?? _resId,
  size: size ?? _size,
  status: status ?? _status,
  aStatus: aStatus ?? _aStatus,
  reason: reason ?? _reason,
  isPaid: isPaid ?? _isPaid,
  otp: otp ?? _otp,
  amount: amount ?? _amount,
  txnId: txnId ?? _txnId,
  pDate: pDate ?? _pDate,
  address: address ?? _address,
  addressId: addressId ?? _addressId,
  paymentType: paymentType ?? _paymentType,
  createdAt: createdAt ?? _createdAt,
  subtotal: subtotal ?? _subtotal,
  discount: discount ?? _discount,
  addons: addons ?? _addons,
  addonService: addonService ?? _addonService,
  total: total ?? _total,
  price: price ?? _price,
  resName: resName ?? _resName,
  resDesc: resDesc ?? _resDesc,
);
  String? get email => _email;
  String? get mobile => _mobile;
  String? get username => _username;
  String? get id => _id;
  String? get date => _date;
  String? get slot => _slot;
  String? get userId => _userId;
  String? get resId => _resId;
  String? get size => _size;
  String? get status => _status;
  String? get aStatus => _aStatus;
  dynamic get reason => _reason;
  String? get isPaid => _isPaid;
  String? get otp => _otp;
  String? get amount => _amount;
  String? get txnId => _txnId;
  String? get pDate => _pDate;
  String? get address => _address;
  String? get addressId => _addressId;
  String? get paymentType => _paymentType;
  String? get createdAt => _createdAt;
  String? get subtotal => _subtotal;
  String? get discount => _discount;
  String? get addons => _addons;
  dynamic get addonService => _addonService;
  String? get total => _total;
  String? get price => _price;
  String? get resName => _resName;
  String? get resDesc => _resDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['username'] = _username;
    map['id'] = _id;
    map['date'] = _date;
    map['slot'] = _slot;
    map['user_id'] = _userId;
    map['res_id'] = _resId;
    map['size'] = _size;
    map['status'] = _status;
    map['a_status'] = _aStatus;
    map['reason'] = _reason;
    map['is_paid'] = _isPaid;
    map['otp'] = _otp;
    map['amount'] = _amount;
    map['txn_id'] = _txnId;
    map['p_date'] = _pDate;
    map['address'] = _address;
    map['address_id'] = _addressId;
    map['payment_type'] = _paymentType;
    map['created_at'] = _createdAt;
    map['subtotal'] = _subtotal;
    map['discount'] = _discount;
    map['addons'] = _addons;
    map['addon_service'] = _addonService;
    map['total'] = _total;
    map['price'] = _price;
    map['res_name'] = _resName;
    map['res_desc'] = _resDesc;
    return map;
  }

}