class ListTradingAccountModels {
  ListTradingAccountModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final bool status;
  late final String message;
  late final List<Response> response;
  
  ListTradingAccountModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    this.id,
    this.login,
    this.type,
    this.namaTipeAkun,
    this.rate,
    this.marginFree,
    this.marginFreePercent,
    this.balance,
    this.leverage,
    this.pnl,
    this.currency,
    this.totalDeposit,
    this.totalWithdrawal,
    this.minDeposit,
    this.minTopup,
    this.minWithdrawal,
    this.maxWithdrawal,
  });
  String? id;
  String? login;
  String? type;
  String? namaTipeAkun;
  String? rate;
  int? marginFree;
  int? marginFreePercent;
  String? balance;
  String? leverage;
  String? pnl;
  String? currency;
  String? totalDeposit;
  String? totalWithdrawal;
  String? minDeposit;
  String? minTopup;
  String? minWithdrawal;
  String? maxWithdrawal;
  
  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    login = json['login'];
    type = json['type'];
    namaTipeAkun = json['nama_tipe_akun'];
    rate = json['rate'];
    marginFree = json['margin_free'];
    marginFreePercent = json['margin_free_percent'];
    balance = json['balance'];
    leverage = json['leverage'];
    pnl = json['pnl'];
    currency = json['currency'];
    totalDeposit = json['total_deposit'];
    totalWithdrawal = json['total_withdrawal'];
    minDeposit = json['min_deposit'];
    minTopup = json['min_topup'];
    minWithdrawal = json['min_withdrawal'];
    maxWithdrawal = json['max_withdrawal'];
  }
}