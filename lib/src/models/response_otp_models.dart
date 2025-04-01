class OTPModels {
  OTPModels({
    required this.status,
    required this.message,
    required this.response,
  });
  String? status;
  String? message;
  late final Response response;
  
  OTPModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = Response.fromJson(json['response']);
  }
}

class Response {
  Response({
    required this.personalDetail,
  });
  late final PersonalDetail personalDetail;
  
  Response.fromJson(Map<String, dynamic> json){
    personalDetail = PersonalDetail.fromJson(json['personal_detail']);
  }
}

class PersonalDetail {
  PersonalDetail({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.city,
    this.country,
    this.address,
    this.zip,
    this.tglLahir,
    this.tmptLahir,
    this.typeId,
    this.idNumber,
    this.urlPhoto,
    this.status,
    this.ver,
  });
  String? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? city;
  String? country;
  String? address;
  String? zip;
  String? tglLahir;
  String? tmptLahir;
  String? typeId;
  String? idNumber;
  String? urlPhoto;
  String? status;
  String? ver;
  
  PersonalDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    city = json['city'];
    country = json['country'];
    address = json['address'];
    zip = json['zip'];
    tglLahir = json['tgl_lahir'];
    tmptLahir = json['tmpt_lahir'];
    typeId = json['type_id'];
    idNumber = json['id_number'];
    urlPhoto = json['url_photo'];
    status = json['status'];
    ver = json['ver'];
  }
}