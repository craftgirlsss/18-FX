class TransactionDPWDModels {
  TransactionDPWDModels({
    required this.success,
    required this.message,
    required this.login,
    required this.response,
  });
  late final String success;
  late final String message;
  late final String login;
  late final List<Response> response;

  TransactionDPWDModels.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    login = json['login'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['login'] = login;
    data['response'] = response.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Response {
  Response({
    this.login,
    this.currency,
    this.orderType,
    this.amount,
    this.time,
    this.image,
  });
  String? login;
  String? currency;
  String? orderType;
  String? amount;
  String? time;
  String? image;
  String? status;

  Response.fromJson(Map<String, dynamic> json){
    login = json['login'];
    currency = json['currency'];
    orderType = json['orderType'];
    amount = json['amount'];
    time = json['time'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['currency'] = currency;
    data['orderType'] = orderType;
    data['amount'] = amount;
    data['time'] = time;
    data['image'] = image;
    return data;
  }
}