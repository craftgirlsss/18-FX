class UserInfoModels {
  UserInfoModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final bool status;
  late final String message;
  late final Response response;
  
  UserInfoModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = Response.fromJson(json['response']);
  }
}

class Response {
  Response({
     this.MBRID,
     this.MBRNAME,
     this.MBREMAIL,
     this.MBRCODE,
     this.MBRTYPE,
     this.MBRACCMAX,
     this.MBRACCMAXMICRO,
     this.MBRJENISKELAMIN,
     this.MBROAUTHPIC,
     this.MBRTMPTLAHIR,
     this.MBRTGLLAHIR,
     this.MBRCOUNTRY,
     this.MBRCITY,
     this.MBRADDRESS,
     this.MBRPHONECODE,
     this.MBRPHONE,
     this.MBRZIP,
     this.MBRTYPEIDT,
     this.MBRNOIDT,
     this.MBRAVATAR,
     this.MBROTP,
     this.MBRBECOMEIB,
     this.MBRVERIF,
     this.MBRSTS,
  });
  String? MBRID;
  String? MBRNAME;
  String? MBREMAIL;
  String? MBRCODE;
  String? MBRTYPE;
  String? MBRACCMAX;
  String? MBRACCMAXMICRO;
  String? MBRJENISKELAMIN;
  String? MBROAUTHPIC;
  String? MBRTMPTLAHIR;
  String? MBRTGLLAHIR;
  String? MBRCOUNTRY;
  String? MBRCITY;
  String? MBRADDRESS;
  String? MBRPHONECODE;
  String? MBRPHONE;
  String? MBRZIP;
  String? MBRTYPEIDT;
  String? MBRNOIDT;
  String? MBRAVATAR;
  String? MBROTP;
  String? MBRBECOMEIB;
  String? MBRVERIF;
  String? MBRSTS;
  
  Response.fromJson(Map<String, dynamic> json){
    MBRID = json['MBR_ID'];
    MBRNAME = json['MBR_NAME'];
    MBREMAIL = json['MBR_EMAIL'];
    MBRCODE = json['MBR_CODE'];
    MBRTYPE = json['MBR_TYPE'];
    MBRACCMAX = json['MBR_ACCMAX'];
    MBRACCMAXMICRO = json['MBR_ACCMAX_MICRO'];
    MBRJENISKELAMIN = json['MBR_JENIS_KELAMIN'];
    MBROAUTHPIC = json['MBR_OAUTH_PIC'];
    MBRTMPTLAHIR = json['MBR_TMPTLAHIR'];
    MBRTGLLAHIR = json['MBR_TGLLAHIR'];
    MBRCOUNTRY = json['MBR_COUNTRY'];
    MBRCITY = json['MBR_CITY'];
    MBRADDRESS = json['MBR_ADDRESS'];
    MBRPHONECODE = json['MBR_PHONE_CODE'];
    MBRPHONE = json['MBR_PHONE'];
    MBRZIP = json['MBR_ZIP'];
    MBRTYPEIDT = json['MBR_TYPE_IDT'];
    MBRNOIDT = json['MBR_NO_IDT'];
    MBRAVATAR = json['MBR_AVATAR'];
    MBROTP = json['MBR_OTP'];
    MBRBECOMEIB = json['MBR_BECOME_IB'];
    MBRVERIF = json['MBR_VERIF'];
    MBRSTS = json['MBR_STS'];
  }
}