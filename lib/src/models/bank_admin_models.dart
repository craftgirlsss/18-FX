class BankAdminModels {
  BankAdminModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final bool status;
  late final String message;
  late final List<Response> response;
  
  BankAdminModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    this.id,
    this.currency,
    this.bankName,
    this.bankHolder,
    this.bankAccount,
  });
  String? id;
  String? currency;
  String? bankName;
  String? bankHolder;
  String? bankAccount;
  
  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    currency = json['currency'];
    bankName = json['bank_name'];
    bankHolder = json['bank_holder'];
    bankAccount = json['bank_account'];
  }
}