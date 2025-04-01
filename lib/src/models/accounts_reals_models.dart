class AccountsReaslModels {
  AccountsReaslModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final String status;
  late final String message;
  late final List<Response> response;
  
  AccountsReaslModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    required this.id,
    required this.account,
    required this.type,
    required this.datetime,
  });
  late final String id;
  late final String account;
  late final String type;
  late final String datetime;
  
  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    account = json['account'];
    type = json['type'];
    datetime = json['datetime'];
  }
}