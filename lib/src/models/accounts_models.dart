class AccountsModels {
  AccountsModels({
    this.status,
    this.message,
    this.response,
  });
  String? status;
  String? message;
  Response? response;
  
  AccountsModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = Response.fromJson(json['response']);
  }
}

class Response {
  Response({
    required this.personalDetail,
    required this.bank,
    // required this.accountDetail,
  });
  late final List<Bank> bank;
  late final PersonalDetail personalDetail;
  // late final List<AccountDetail> accountDetail;
  
  Response.fromJson(Map<String, dynamic> json){
    personalDetail = PersonalDetail.fromJson(json['personal_detail']);
    bank = List.from(json['bank']).map((e)=>Bank.fromJson(e)).toList();
    // accountDetail = List.from(json['account_detail']).map((e)=>AccountDetail.fromJson(e)).toList();
  }
}

class PersonalDetail {
  PersonalDetail({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.urlPhoto,
    this.tanggalLahir,
    this.tempatLahir,
    this.country,
    this.status,
    this.city,
    this.address,
    this.zip,
    this.typeID,
    this.typeNumber,
    this.ver
  });
  String? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? urlPhoto;
  String? tanggalLahir;
  String? tempatLahir;
  String? country;
  String? city;
  String? address;
  String? zip;
  String? typeID;
  String? typeNumber;
  String? status;
  String? ver;
  
  PersonalDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    tanggalLahir = json['tgl_lahir'];
    tempatLahir = json['tmpt_lahir'];
    country = json['country'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    typeID = json['type_id'];
    typeNumber = json['id_number'];
    urlPhoto = json['url_photo'];
    status = json['status'];
    ver = json['ver'];
  }
}

class Bank {
  Bank({
    required this.id,
    required this.name,
    required this.account,
    required this.branch,
    required this.type,
  });
  late final String id;
  late final String name;
  late final String account;
  late final String branch;
  late final String type;
  
  Bank.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    account = json['account'];
    branch = json['branch'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['account'] = account;
    data['branch'] = branch;
    data['type'] = type;
    return data;
  }
}

// class AccountDetail {
//   AccountDetail({
//     required this.account,
//     required this.type,
//     required this.dateCreate,
//   });
//   int? account;
//   String? type;
//   String? dateCreate;
  
//   AccountDetail.fromJson(Map<String, dynamic> json){
//     account = json['account'];
//     type = json['type'];
//     dateCreate = json['date_create'];
//   }
// }