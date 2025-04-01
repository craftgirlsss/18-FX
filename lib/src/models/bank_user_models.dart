class BankUserModels {
  BankUserModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final bool status;
  late final String message;
  late final List<Response> response;
  
  BankUserModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    this.id,
    this.name,
    this.account,
    this.branch,
    this.type,
    this.userName,
  });
  String? id;
  String? name;
  String? account;
  String? branch;
  String? type;
  String? userName;
  
  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    account = json['account'];
    branch = json['branch'];
    type = json['type'];
    userName = json['user_name'];
  }
}