import 'dart:convert';
/// response_code : "1"
/// message : "Vendor Found"
/// user : {"country":"India","state":"Madhya Pardesh","id":"59","fname":"","lname":"","email":"dummy1@gmail.com","mobile":"3333333333","address":"indores","country_id":"5","state_id":"2","city_id":"2","lat":"0","lang":"0","uname":"","password":"","profile_image":"","device_token":"eaF0dOZDRMqdvdFeanxAPQ:APA91bGRSt7z0OpC_A4wKbrVEzM9aNJJQ1zIcNQgLuhJWPN3vLc8cfKzrj4XfZ3RQn2wBwHAo2_io78_ApOZuqrxPUTDU8ijnuWYIuAYSEz2tl9E4QyUzYaX9NoptgaE5IlAdT-JJjM9","otp":"1235","status":"0","wallet":"0.00","balance":"0.00","json_data":{"can_travel":"Local","service_cities":"[7, 6]","website":"sbsbbzb","t_link":"sbshsjdjfjfllloo","i_link":"lllkllllll","l_link":"iiioooouuy","equipments":"qqaasswwww","birthday":"21/10/2022","provide_services":"eueieiwkwk","join_antsnest":"ssbbsnsnsn","cat":"42","sub_cat":"58","amount":"9497","hrs_day":"Hour","language":"Italian"},"created_at":"2022-10-21 12:07:17","updated_at":"2022-10-21 12:07:35"}
/// status : "success"

GetProfileResponse getProfileResponseFromJson(String str) => GetProfileResponse.fromJson(json.decode(str));
String getProfileResponseToJson(GetProfileResponse data) => json.encode(data.toJson());
class GetProfileResponse {
  GetProfileResponse({
      String? responseCode, 
      String? message,
      String? active_plan,
      User? user, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _active_plan = active_plan;
    _user = user;
    _status = status;
}

  GetProfileResponse.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _active_plan = json['active_plan'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  String? _active_plan;
  User? _user;
  String? _status;
GetProfileResponse copyWith({  String? responseCode,
  String? message,
  User? user,
  String? active_plan,
  String? status,
}) => GetProfileResponse(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  user: user ?? _user,
  active_plan : active_plan ?? _active_plan,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get active_plan => _active_plan;
  User? get user => _user;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['active_plan'] = _active_plan;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['status'] = _status;
    return map;
  }

}

/// country : "India"
/// state : "Madhya Pardesh"
/// id : "59"
/// fname : ""
/// lname : ""
/// email : "dummy1@gmail.com"
/// mobile : "3333333333"
/// address : "indores"
/// country_id : "5"
/// state_id : "2"
/// city_id : "2"
/// lat : "0"
/// lang : "0"
/// uname : ""
/// password : ""
/// profile_image : ""
/// device_token : "eaF0dOZDRMqdvdFeanxAPQ:APA91bGRSt7z0OpC_A4wKbrVEzM9aNJJQ1zIcNQgLuhJWPN3vLc8cfKzrj4XfZ3RQn2wBwHAo2_io78_ApOZuqrxPUTDU8ijnuWYIuAYSEz2tl9E4QyUzYaX9NoptgaE5IlAdT-JJjM9"
/// otp : "1235"
/// status : "0"
/// wallet : "0.00"
/// balance : "0.00"
/// json_data : {"can_travel":"Local","service_cities":"[7, 6]","website":"sbsbbzb","t_link":"sbshsjdjfjfllloo","i_link":"lllkllllll","l_link":"iiioooouuy","equipments":"qqaasswwww","birthday":"21/10/2022","provide_services":"eueieiwkwk","join_antsnest":"ssbbsnsnsn","cat":"42","sub_cat":"58","amount":"9497","hrs_day":"Hour","language":"Italian"}
/// created_at : "2022-10-21 12:07:17"
/// updated_at : "2022-10-21 12:07:35"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? country, 
      String? state, 
      String? id, 
      String? fname, 
      String? lname, 
      String? email, 
      String? mobile, 
      String? address, 
      String? countryId, 
      String? stateId, 
      String? cityId,
      String? country_code,
      String? lat, 
      String? lang, 
      String? uname, 
      String? password, 
      String? profileImage, 
      String? deviceToken, 
      String? otp, 
      String? status, 
      String? wallet, 
      String? balance, 
      JsonData? jsonData, 
      String? createdAt, 
      String? updatedAt,}){
    _country = country;
    _state = state;
    _id = id;
    _fname = fname;
    _lname = lname;
    _email = email;
    _mobile = mobile;
    _address = address;
    _countryId = countryId;
    _stateId = stateId;
    _country_code = country_code;
    _cityId = cityId;
    _lat = lat;
    _lang = lang;
    _uname = uname;
    _password = password;
    _profileImage = profileImage;
    _deviceToken = deviceToken;
    _otp = otp;
    _status = status;
    _wallet = wallet;
    _balance = balance;
    _jsonData = jsonData;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
    _country = json['country'];
    _state = json['state'];
    _id = json['id'];
    _fname = json['fname'];
    _country_code = json['country_code'];
    _lname = json['lname'];
    _email = json['email'];
    _mobile = json['mobile'];
    _address = json['address'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _lat = json['lat'];
    _lang = json['lang'];
    _uname = json['uname'];
    _password = json['password'];
    _profileImage = json['profile_image'];
    _deviceToken = json['device_token'];
    _otp = json['otp'];
    _status = json['status'];
    _wallet = json['wallet'];
    _balance = json['balance'];
    _jsonData = json['json_data'] != null ? JsonData.fromJson(json['json_data']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _country;
  String? _state;
  String? _id;
  String? _fname;
  String? _lname;
  String? _email;
  String? _mobile;
  String? _address;
  String? _countryId;
  String? _stateId;
  String? _cityId;
  String? _country_code;
  String? _lat;
  String? _lang;
  String? _uname;
  String? _password;
  String? _profileImage;
  String? _deviceToken;
  String? _otp;
  String? _status;
  String? _wallet;
  String? _balance;
  JsonData? _jsonData;
  String? _createdAt;
  String? _updatedAt;
User copyWith({  String? country,
  String? state,
  String? id,
  String? fname,
  String? lname,
  String? email,
  String? country_code,
  String? mobile,
  String? address,
  String? countryId,
  String? stateId,
  String? cityId,
  String? lat,
  String? lang,
  String? uname,
  String? password,
  String? profileImage,
  String? deviceToken,
  String? otp,
  String? status,
  String? wallet,
  String? balance,
  JsonData? jsonData,
  String? createdAt,
  String? updatedAt,
}) => User(  country: country ?? _country,
  state: state ?? _state,
  id: id ?? _id,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  email: email ?? _email,
  country_code: country_code ?? _country_code,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  countryId: countryId ?? _countryId,
  stateId: stateId ?? _stateId,
  cityId: cityId ?? _cityId,
  lat: lat ?? _lat,
  lang: lang ?? _lang,
  uname: uname ?? _uname,
  password: password ?? _password,
  profileImage: profileImage ?? _profileImage,
  deviceToken: deviceToken ?? _deviceToken,
  otp: otp ?? _otp,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  balance: balance ?? _balance,
  jsonData: jsonData ?? _jsonData,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get country => _country;
  String? get state => _state;
  String? get id => _id;
  String? get fname => _fname;
  String? get lname => _lname;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get country_code => _country_code;
  String? get countryId => _countryId;
  String? get stateId => _stateId;
  String? get cityId => _cityId;
  String? get lat => _lat;
  String? get lang => _lang;
  String? get uname => _uname;
  String? get password => _password;
  String? get profileImage => _profileImage;
  String? get deviceToken => _deviceToken;
  String? get otp => _otp;
  String? get status => _status;
  String? get wallet => _wallet;
  String? get balance => _balance;
  JsonData? get jsonData => _jsonData;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = _country;
    map['state'] = _state;
    map['id'] = _id;
    map['fname'] = _fname;
    map['country_code'] = _country_code;
    map['lname'] = _lname;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['uname'] = _uname;
    map['password'] = _password;
    map['profile_image'] = _profileImage;
    map['device_token'] = _deviceToken;
    map['otp'] = _otp;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
    if (_jsonData != null) {
      map['json_data'] = _jsonData?.toJson();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// can_travel : "Local"
/// service_cities : "[7, 6]"
/// website : "sbsbbzb"
/// t_link : "sbshsjdjfjfllloo"
/// i_link : "lllkllllll"
/// l_link : "iiioooouuy"
/// equipments : "qqaasswwww"
/// birthday : "21/10/2022"
/// provide_services : "eueieiwkwk"
/// join_antsnest : "ssbbsnsnsn"
/// cat : "42"
/// sub_cat : "58"
/// amount : "9497"
/// hrs_day : "Hour"
/// language : "Italian"

JsonData jsonDataFromJson(String str) => JsonData.fromJson(json.decode(str));
String jsonDataToJson(JsonData data) => json.encode(data.toJson());
class JsonData {
  JsonData({
      String? canTravel, 
      String? serviceCities, 
      String? website, 
      String? tLink, 
      String? iLink, 
      String? lLink, 
      String? equipments, 
      String? birthday, 
      String? provideServices, 
      String? joinAntsnest, 
      String? cat, 
      String? subCat, 
      String? amount, 
      String? hrsDay, 
      String? language,}){
    _canTravel = canTravel;
    _serviceCities = serviceCities;
    _website = website;
    _tLink = tLink;
    _iLink = iLink;
    _lLink = lLink;
    _equipments = equipments;
    _birthday = birthday;
    _provideServices = provideServices;
    _joinAntsnest = joinAntsnest;
    _cat = cat;
    _subCat = subCat;
    _amount = amount;
    _hrsDay = hrsDay;
    _language = language;
}

  JsonData.fromJson(dynamic json) {
    _canTravel = json['can_travel'] ?? "";
    _serviceCities = json['service_cities'];
    _website = json['website'];
    _tLink = json['t_link'];
    _iLink = json['i_link'];
    _lLink = json['l_link'];
    _equipments = json['equipments'];
    _birthday = json['birthday'];
    _provideServices = json['provide_services'];
    _joinAntsnest = json['join_antsnest'];
    _cat = json['cat'];
    _subCat = json['sub_cat'];
    _amount = json['amount'];
    _hrsDay = json['hrs_day'];
    _language = json['language'];
  }
  String? _canTravel;
  String? _serviceCities;
  String? _website;
  String? _tLink;
  String? _iLink;
  String? _lLink;
  String? _equipments;
  String? _birthday;
  String? _provideServices;
  String? _joinAntsnest;
  String? _cat;
  String? _subCat;
  String? _amount;
  String? _hrsDay;
  String? _language;
JsonData copyWith({  String? canTravel,
  String? serviceCities,
  String? website,
  String? tLink,
  String? iLink,
  String? lLink,
  String? equipments,
  String? birthday,
  String? provideServices,
  String? joinAntsnest,
  String? cat,
  String? subCat,
  String? amount,
  String? hrsDay,
  String? language,
}) => JsonData(  canTravel: canTravel ?? _canTravel,
  serviceCities: serviceCities ?? _serviceCities,
  website: website ?? _website,
  tLink: tLink ?? _tLink,
  iLink: iLink ?? _iLink,
  lLink: lLink ?? _lLink,
  equipments: equipments ?? _equipments,
  birthday: birthday ?? _birthday,
  provideServices: provideServices ?? _provideServices,
  joinAntsnest: joinAntsnest ?? _joinAntsnest,
  cat: cat ?? _cat,
  subCat: subCat ?? _subCat,
  amount: amount ?? _amount,
  hrsDay: hrsDay ?? _hrsDay,
  language: language ?? _language,
);
  String? get canTravel => _canTravel;
  String? get serviceCities => _serviceCities;
  String? get website => _website;
  String? get tLink => _tLink;
  String? get iLink => _iLink;
  String? get lLink => _lLink;
  String? get equipments => _equipments;
  String? get birthday => _birthday;
  String? get provideServices => _provideServices;
  String? get joinAntsnest => _joinAntsnest;
  String? get cat => _cat;
  String? get subCat => _subCat;
  String? get amount => _amount;
  String? get hrsDay => _hrsDay;
  String? get language => _language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['can_travel'] = _canTravel;
    map['service_cities'] = _serviceCities;
    map['website'] = _website;
    map['t_link'] = _tLink;
    map['i_link'] = _iLink;
    map['l_link'] = _lLink;
    map['equipments'] = _equipments;
    map['birthday'] = _birthday;
    map['provide_services'] = _provideServices;
    map['join_antsnest'] = _joinAntsnest;
    map['cat'] = _cat;
    map['sub_cat'] = _subCat;
    map['amount'] = _amount;
    map['hrs_day'] = _hrsDay;
    map['language'] = _language;
    return map;
  }

}