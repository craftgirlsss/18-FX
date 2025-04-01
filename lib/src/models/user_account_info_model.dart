class UserAccountInfoModels {
  UserAccountInfoModels({
    required this.success,
    required this.message,
    required this.response,
    required this.infoDeposit,
  });
  late final String success;
  late final String message;
  late final Response response;
  late final InfoDeposit infoDeposit;
  
  UserAccountInfoModels.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    response = Response.fromJson(json['response']);
    infoDeposit = InfoDeposit.fromJson(json['infoDeposit']);
  }
}

class Response {
  Response({
    this.status,
    this.title,
    this.note,
    this.step,
    this.accounts,
  });
  int? status;
  String? title;
  String? note;
  String? step;
  List<Accounts> ?accounts;
  
  Response.fromJson(Map<String, dynamic> json){
    status = json['status'];
    title = json['title'];
    note = json['note'];
    step = json['step'];
    accounts = List.from(json['accounts']).map((e)=>Accounts.fromJson(e)).toList();
  }
}

class Accounts {
  Accounts({
    this.id,
    this.login,
    this.type,
    this.namaTipeAkun,
    this.marginFree,
    this.balance,
    this.lastDeposit,
    this.lastWithdraw,
    this.leverage,
    this.pnl,
    this.currency,
    this.minDeposit,
    this.minTopup,
    this.minWithdrawal,
    this.maxWithdrawal,
  });
  String? id;
  String? login;
  String? type;
  String? namaTipeAkun;
  String? marginFree;
  String? balance;
  String? lastDeposit;
  String? lastWithdraw;
  int? leverage;
  int? pnl;
  String? currency;
  int? minDeposit;
  int? minTopup;
  int? minWithdrawal;
  int? maxWithdrawal;
  
  Accounts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    login = json['login'];
    type = json['type'];
    namaTipeAkun = null;
    marginFree = json['margin_free'];
    balance = json['balance'];
    lastDeposit = json['last_deposit'];
    lastWithdraw = json['last_withdraw'];
    leverage = json['leverage'];
    pnl = json['pnl'];
    currency = json['currency'];
    minDeposit = json['min_deposit'];
    minTopup = json['min_topup'];
    minWithdrawal = json['min_withdrawal'];
    maxWithdrawal = json['max_withdrawal'];
  }
}

class InfoDeposit {
  InfoDeposit({
    this.pemberitahuan,
    this.keterangan,
    this.persyaratan,
  });
  String? pemberitahuan;
  List<String>? keterangan;
  List<String>? persyaratan;
  
  InfoDeposit.fromJson(Map<String, dynamic> json){
    pemberitahuan = json['pemberitahuan'];
    keterangan = List.castFrom<dynamic, String>(json['keterangan']);
    persyaratan = List.castFrom<dynamic, String>(json['persyaratan']);
  }
}