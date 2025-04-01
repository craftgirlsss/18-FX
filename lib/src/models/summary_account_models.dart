class SummaryAccountModels {
  SummaryAccountModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final String status;
  late final String message;
  late final Response response;
  
  SummaryAccountModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = Response.fromJson(json['response']);
  }
}

class Response {
  Response({
    this.profit,
    this.deposit,
    this.balance,
    this.swap,
    this.commission
  });
    dynamic profit;
    dynamic deposit;
    dynamic balance;
    dynamic swap;
    dynamic commission;
  
  Response.fromJson(Map<String, dynamic> json){
    profit = json['profit'];
    deposit = json['deposit'];
    balance = json['balance'];
    swap = json['swap'];
    commission = json['commission'];
  }
}