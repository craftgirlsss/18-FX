class MoneyConversionModels {
  MoneyConversionModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final bool status;
  late final String message;
  late final Response response;
  
  MoneyConversionModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = Response.fromJson(json['response']);
  }
}

class Response {
  Response({
    this.amountSource,
    this.amountReceived,
    this.rate,
  });
  int? amountSource;
  dynamic amountReceived;
  int? rate;
  
  Response.fromJson(Map<String, dynamic> json){
    amountSource = json['amount_source'];
    amountReceived = json['amount_received'];
    rate = json['rate'];
  }
}