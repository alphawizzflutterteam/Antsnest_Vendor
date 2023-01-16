import 'dart:convert';
/// status : 1
/// msg : "Service Found"
/// restaurants : [{"c_name":"PHOTOGRAPHERS","sub_cat":"WEDDING","city_name":"indore","res_id":"198","cat_id":"42","scat_id":"58","res_name":"Service Here","res_name_u":"","res_desc":"dummy description","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://developmentalphawizz.com/antsnest/uploads/"},"logo":["https://developmentalphawizz.com/antsnest/uploads/63467161aeb71.jpg","https://developmentalphawizz.com/antsnest/uploads/63467161afc09.jpg","https://developmentalphawizz.com/antsnest/uploads/63610a5db59bd.jpg"],"res_phone":"","res_address":"","res_isOpen":"open","res_status":"active","res_create_date":"01 Nov 2022","res_ratings":"","status":"1","res_video":"","res_url":"","mfo":null,"lat":null,"lon":null,"vid":"46","country_id":"5","state_id":"7","city_id":"16","structure":"a:1:{i:0;s:10:\"5000,10000\";}","hours":null,"experts":null,"service_offered":"photo\r\n","price":"20000","type":[{"type":"5000","type_name":"","price":"10000"}],"all_image":["https://developmentalphawizz.com/antsnest/uploads/"],"review_count":0,"reviews":[]},{"c_name":"PHOTOGRAPHERS","sub_cat":"WEDDING","city_name":"indore","res_id":"200","cat_id":"42","scat_id":"58","res_name":"sk store","res_name_u":"","res_desc":"dfgbdzfbdfz","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://developmentalphawizz.com/antsnest/uploads/"},"logo":["https://developmentalphawizz.com/antsnest/uploads/636112b1ec571.jpg"],"res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"01 Nov 2022","res_ratings":"","status":"","res_video":"","res_url":"","mfo":null,"lat":null,"lon":null,"vid":"46","country_id":"5","state_id":"7","city_id":"16","structure":"a:1:{i:0;s:8:\"500,1000\";}","hours":null,"experts":null,"service_offered":"dzfgzdsf","price":"1000","type":[{"type":"500","type_name":"","price":"1000"}],"all_image":["https://developmentalphawizz.com/antsnest/uploads/"],"review_count":0,"reviews":[]},{"c_name":"PHOTOGRAPHERS","sub_cat":"WEDDING","city_name":"indore","res_id":"216","cat_id":"42","scat_id":"58","res_name":"test product ","res_name_u":"","res_desc":"dummy description here","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://developmentalphawizz.com/antsnest/uploads/"},"logo":["https://developmentalphawizz.com/antsnest/uploads/6364ebec56a77.jpg"],"res_phone":"","res_address":"","res_isOpen":"open","res_status":"active","res_create_date":"04 Nov 2022","res_ratings":"","status":"1","res_video":"","res_url":"","mfo":null,"lat":null,"lon":null,"vid":"46","country_id":"5","state_id":"16","city_id":"16","structure":null,"hours":null,"experts":null,"service_offered":"test product, work product","price":"800","type":[],"all_image":["https://developmentalphawizz.com/antsnest/uploads/"],"review_count":0,"reviews":[]}]

VendorServiceModel vendorServiceModelFromJson(String str) => VendorServiceModel.fromJson(json.decode(str));
String vendorServiceModelToJson(VendorServiceModel data) => json.encode(data.toJson());
class VendorServiceModel {
  VendorServiceModel({
      num? status, 
      String? msg, 
      List<Restaurants>? restaurants,}){
    _status = status;
    _msg = msg;
    _restaurants = restaurants;
}

  VendorServiceModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['restaurants'] != null) {
      _restaurants = [];
      json['restaurants'].forEach((v) {
        _restaurants?.add(Restaurants.fromJson(v));
      });
    }
  }
  num? _status;
  String? _msg;
  List<Restaurants>? _restaurants;
VendorServiceModel copyWith({  num? status,
  String? msg,
  List<Restaurants>? restaurants,
}) => VendorServiceModel(  status: status ?? _status,
  msg: msg ?? _msg,
  restaurants: restaurants ?? _restaurants,
);
  num? get status => _status;
  String? get msg => _msg;
  List<Restaurants>? get restaurants => _restaurants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_restaurants != null) {
      map['restaurants'] = _restaurants?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// c_name : "PHOTOGRAPHERS"
/// sub_cat : "WEDDING"
/// city_name : "indore"
/// res_id : "198"
/// cat_id : "42"
/// scat_id : "58"
/// res_name : "Service Here"
/// res_name_u : ""
/// res_desc : "dummy description"
/// res_desc_u : ""
/// res_website : ""
/// res_image : {"res_imag0":"https://developmentalphawizz.com/antsnest/uploads/"}
/// logo : ["https://developmentalphawizz.com/antsnest/uploads/63467161aeb71.jpg","https://developmentalphawizz.com/antsnest/uploads/63467161afc09.jpg","https://developmentalphawizz.com/antsnest/uploads/63610a5db59bd.jpg"]
/// res_phone : ""
/// res_address : ""
/// res_isOpen : "open"
/// res_status : "active"
/// res_create_date : "01 Nov 2022"
/// res_ratings : ""
/// status : "1"
/// res_video : ""
/// res_url : ""
/// mfo : null
/// lat : null
/// lon : null
/// vid : "46"
/// country_id : "5"
/// state_id : "7"
/// city_id : "16"
/// structure : "a:1:{i:0;s:10:\"5000,10000\";}"
/// hours : null
/// experts : null
/// service_offered : "photo\r\n"
/// price : "20000"
/// type : [{"type":"5000","type_name":"","price":"10000"}]
/// all_image : ["https://developmentalphawizz.com/antsnest/uploads/"]
/// review_count : 0
/// reviews : []

Restaurants restaurantsFromJson(String str) => Restaurants.fromJson(json.decode(str));
String restaurantsToJson(Restaurants data) => json.encode(data.toJson());
class Restaurants {
  Restaurants({
      String? cName, 
      String? subCat, 
      String? cityName, 
      String? resId, 
      String? catId, 
      String? scatId, 
      String? resName, 
      String? resNameU, 
      String? resDesc, 
      String? resDescU, 
      String? resWebsite, 
      ResImage? resImage, 
      List<String>? logo, 
      String? resPhone, 
      String? resAddress, 
      String? resIsOpen, 
      String? resStatus, 
      String? resCreateDate, 
      String? resRatings, 
      String? status, 
      String? resVideo, 
      String? resUrl, 
      dynamic mfo, 
      dynamic lat, 
      dynamic lon, 
      String? vid, 
      String? countryId, 
      String? stateId, 
      String? cityId, 
      String? structure, 
      dynamic hours, 
      dynamic experts, 
      String? serviceOffered, 
      String? price, 
      List<Type>? type, 
      List<String>? allImage, 
      num? reviewCount, 
      List<dynamic>? reviews,}){
    _cName = cName;
    _subCat = subCat;
    _cityName = cityName;
    _resId = resId;
    _catId = catId;
    _scatId = scatId;
    _resName = resName;
    _resNameU = resNameU;
    _resDesc = resDesc;
    _resDescU = resDescU;
    _resWebsite = resWebsite;
    _resImage = resImage;
    _logo = logo;
    _resPhone = resPhone;
    _resAddress = resAddress;
    _resIsOpen = resIsOpen;
    _resStatus = resStatus;
    _resCreateDate = resCreateDate;
    _resRatings = resRatings;
    _status = status;
    _resVideo = resVideo;
    _resUrl = resUrl;
    _mfo = mfo;
    _lat = lat;
    _lon = lon;
    _vid = vid;
    _countryId = countryId;
    _stateId = stateId;
    _cityId = cityId;
    _structure = structure;
    _hours = hours;
    _experts = experts;
    _serviceOffered = serviceOffered;
    _price = price;
    _type = type;
    _allImage = allImage;
    _reviewCount = reviewCount;
    _reviews = reviews;
}

  Restaurants.fromJson(dynamic json) {
    _cName = json['c_name'];
    _subCat = json['sub_cat'];
    _cityName = json['city_name'];
    _resId = json['res_id'];
    _catId = json['cat_id'];
    _scatId = json['scat_id'];
    _resName = json['res_name'];
    _resNameU = json['res_name_u'];
    _resDesc = json['res_desc'];
    _resDescU = json['res_desc_u'];
    _resWebsite = json['res_website'];
    _resImage = json['res_image'] != null ? ResImage.fromJson(json['res_image']) : null;
    _logo = json['logo'] != null ? json['logo'].cast<String>() : [];
    _resPhone = json['res_phone'];
    _resAddress = json['res_address'];
    _resIsOpen = json['res_isOpen'];
    _resStatus = json['res_status'];
    _resCreateDate = json['res_create_date'];
    _resRatings = json['res_ratings'];
    _status = json['status'];
    _resVideo = json['res_video'];
    _resUrl = json['res_url'];
    _mfo = json['mfo'];
    _lat = json['lat'];
    _lon = json['lon'];
    _vid = json['vid'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _structure = json['structure'];
    _hours = json['hours'];
    _experts = json['experts'];
    _serviceOffered = json['service_offered'];
    _price = json['price'];
    if (json['type'] != null) {
      _type = [];
      json['type'].forEach((v) {
        _type?.add(Type.fromJson(v));
      });
    }
    _allImage = json['all_image'] != null ? json['all_image'].cast<String>() : [];
    _reviewCount = json['review_count'];
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(v.fromJson(v));
      });
    }
  }
  String? _cName;
  String? _subCat;
  String? _cityName;
  String? _resId;
  String? _catId;
  String? _scatId;
  String? _resName;
  String? _resNameU;
  String? _resDesc;
  String? _resDescU;
  String? _resWebsite;
  ResImage? _resImage;
  List<String>? _logo;
  String? _resPhone;
  String? _resAddress;
  String? _resIsOpen;
  String? _resStatus;
  String? _resCreateDate;
  String? _resRatings;
  String? _status;
  String? _resVideo;
  String? _resUrl;
  dynamic _mfo;
  dynamic _lat;
  dynamic _lon;
  String? _vid;
  String? _countryId;
  String? _stateId;
  String? _cityId;
  String? _structure;
  dynamic _hours;
  dynamic _experts;
  String? _serviceOffered;
  String? _price;
  List<Type>? _type;
  List<String>? _allImage;
  num? _reviewCount;
  List<dynamic>? _reviews;
Restaurants copyWith({  String? cName,
  String? subCat,
  String? cityName,
  String? resId,
  String? catId,
  String? scatId,
  String? resName,
  String? resNameU,
  String? resDesc,
  String? resDescU,
  String? resWebsite,
  ResImage? resImage,
  List<String>? logo,
  String? resPhone,
  String? resAddress,
  String? resIsOpen,
  String? resStatus,
  String? resCreateDate,
  String? resRatings,
  String? status,
  String? resVideo,
  String? resUrl,
  dynamic mfo,
  dynamic lat,
  dynamic lon,
  String? vid,
  String? countryId,
  String? stateId,
  String? cityId,
  String? structure,
  dynamic hours,
  dynamic experts,
  String? serviceOffered,
  String? price,
  List<Type>? type,
  List<String>? allImage,
  num? reviewCount,
  List<dynamic>? reviews,
}) => Restaurants(  cName: cName ?? _cName,
  subCat: subCat ?? _subCat,
  cityName: cityName ?? _cityName,
  resId: resId ?? _resId,
  catId: catId ?? _catId,
  scatId: scatId ?? _scatId,
  resName: resName ?? _resName,
  resNameU: resNameU ?? _resNameU,
  resDesc: resDesc ?? _resDesc,
  resDescU: resDescU ?? _resDescU,
  resWebsite: resWebsite ?? _resWebsite,
  resImage: resImage ?? _resImage,
  logo: logo ?? _logo,
  resPhone: resPhone ?? _resPhone,
  resAddress: resAddress ?? _resAddress,
  resIsOpen: resIsOpen ?? _resIsOpen,
  resStatus: resStatus ?? _resStatus,
  resCreateDate: resCreateDate ?? _resCreateDate,
  resRatings: resRatings ?? _resRatings,
  status: status ?? _status,
  resVideo: resVideo ?? _resVideo,
  resUrl: resUrl ?? _resUrl,
  mfo: mfo ?? _mfo,
  lat: lat ?? _lat,
  lon: lon ?? _lon,
  vid: vid ?? _vid,
  countryId: countryId ?? _countryId,
  stateId: stateId ?? _stateId,
  cityId: cityId ?? _cityId,
  structure: structure ?? _structure,
  hours: hours ?? _hours,
  experts: experts ?? _experts,
  serviceOffered: serviceOffered ?? _serviceOffered,
  price: price ?? _price,
  type: type ?? _type,
  allImage: allImage ?? _allImage,
  reviewCount: reviewCount ?? _reviewCount,
  reviews: reviews ?? _reviews,
);
  String? get cName => _cName;
  String? get subCat => _subCat;
  String? get cityName => _cityName;
  String? get resId => _resId;
  String? get catId => _catId;
  String? get scatId => _scatId;
  String? get resName => _resName;
  String? get resNameU => _resNameU;
  String? get resDesc => _resDesc;
  String? get resDescU => _resDescU;
  String? get resWebsite => _resWebsite;
  ResImage? get resImage => _resImage;
  List<String>? get logo => _logo;
  String? get resPhone => _resPhone;
  String? get resAddress => _resAddress;
  String? get resIsOpen => _resIsOpen;
  String? get resStatus => _resStatus;
  String? get resCreateDate => _resCreateDate;
  String? get resRatings => _resRatings;
  String? get status => _status;
  String? get resVideo => _resVideo;
  String? get resUrl => _resUrl;
  dynamic get mfo => _mfo;
  dynamic get lat => _lat;
  dynamic get lon => _lon;
  String? get vid => _vid;
  String? get countryId => _countryId;
  String? get stateId => _stateId;
  String? get cityId => _cityId;
  String? get structure => _structure;
  dynamic get hours => _hours;
  dynamic get experts => _experts;
  String? get serviceOffered => _serviceOffered;
  String? get price => _price;
  List<Type>? get type => _type;
  List<String>? get allImage => _allImage;
  num? get reviewCount => _reviewCount;
  List<dynamic>? get reviews => _reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['c_name'] = _cName;
    map['sub_cat'] = _subCat;
    map['city_name'] = _cityName;
    map['res_id'] = _resId;
    map['cat_id'] = _catId;
    map['scat_id'] = _scatId;
    map['res_name'] = _resName;
    map['res_name_u'] = _resNameU;
    map['res_desc'] = _resDesc;
    map['res_desc_u'] = _resDescU;
    map['res_website'] = _resWebsite;
    if (_resImage != null) {
      map['res_image'] = _resImage?.toJson();
    }
    map['logo'] = _logo;
    map['res_phone'] = _resPhone;
    map['res_address'] = _resAddress;
    map['res_isOpen'] = _resIsOpen;
    map['res_status'] = _resStatus;
    map['res_create_date'] = _resCreateDate;
    map['res_ratings'] = _resRatings;
    map['status'] = _status;
    map['res_video'] = _resVideo;
    map['res_url'] = _resUrl;
    map['mfo'] = _mfo;
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['vid'] = _vid;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['structure'] = _structure;
    map['hours'] = _hours;
    map['experts'] = _experts;
    map['service_offered'] = _serviceOffered;
    map['price'] = _price;
    if (_type != null) {
      map['type'] = _type?.map((v) => v.toJson()).toList();
    }
    map['all_image'] = _allImage;
    map['review_count'] = _reviewCount;
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type : "5000"
/// type_name : ""
/// price : "10000"

Type typeFromJson(String str) => Type.fromJson(json.decode(str));
String typeToJson(Type data) => json.encode(data.toJson());
class Type {
  Type({
      String? type, 
      String? typeName, 
      String? price,}){
    _type = type;
    _typeName = typeName;
    _price = price;
}

  Type.fromJson(dynamic json) {
    _type = json['type'];
    _typeName = json['type_name'];
    _price = json['price'];
  }
  String? _type;
  String? _typeName;
  String? _price;
Type copyWith({  String? type,
  String? typeName,
  String? price,
}) => Type(  type: type ?? _type,
  typeName: typeName ?? _typeName,
  price: price ?? _price,
);
  String? get type => _type;
  String? get typeName => _typeName;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['type_name'] = _typeName;
    map['price'] = _price;
    return map;
  }

}

/// res_imag0 : "https://developmentalphawizz.com/antsnest/uploads/"

ResImage resImageFromJson(String str) => ResImage.fromJson(json.decode(str));
String resImageToJson(ResImage data) => json.encode(data.toJson());
class ResImage {
  ResImage({
      String? resImag0,}){
    _resImag0 = resImag0;
}

  ResImage.fromJson(dynamic json) {
    _resImag0 = json['res_imag0'];
  }
  String? _resImag0;
ResImage copyWith({  String? resImag0,
}) => ResImage(  resImag0: resImag0 ?? _resImag0,
);
  String? get resImag0 => _resImag0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['res_imag0'] = _resImag0;
    return map;
  }

}