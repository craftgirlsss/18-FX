class ListTradeAccountsModelsAfterCreateRealAccounts {
  ListTradeAccountsModelsAfterCreateRealAccounts({
    required this.status,
    required this.message,
    required this.response,
  });
  String? status;
  String? message;
  List<Response>? response;
  
  ListTradeAccountsModelsAfterCreateRealAccounts.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    required this.account,
    required this.datetime,
  });
  String? account;
  String? datetime;
  
  Response.fromJson(Map<String, dynamic> json){
    account = json['account'];
    datetime = json['datetime'];
  }
}