class PendingModels {
  PendingModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final String status;
  late final String message;
  late final List<Response> response;
  
  PendingModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    this.ticket,
    this.opentime,
    this.symbol,
    this.lot,
    this.openprice,
    this.sl,
    this.tp,
    this.comment,
    this.ordertype
  });
  int? ticket;
  String? opentime;
  String? symbol;
  int? lot;
  double? openprice;
  dynamic sl;
  dynamic tp;
  String? comment;
  String? ordertype;
  
  Response.fromJson(Map<String, dynamic> json){
    ticket = json['ticket'];
    opentime = json['opentime'];
    symbol = json['symbol'];
    lot = json['lot'];
    openprice = json['openprice'];
    sl = json['sl'];
    tp = json['tp'];
    comment = json['comment'];
    ordertype = json['orderType'];
  }
}