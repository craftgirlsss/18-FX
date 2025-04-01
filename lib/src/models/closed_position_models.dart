class ClosedPositionModels {
  ClosedPositionModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final String status;
  late final String message;
  late final List<Response> response;
  
  ClosedPositionModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
  this.ticket,
  this.opentime,
  this.type,
  this.symbol,
  this.lot,
  this.openprice,
  this.closeprice,
  this.sl,
  this.tp,
  this.profit,
  this.closetime,
  this.swap,
  this.commission
  });

  int? ticket;
  String? opentime;
  String? type;
  String? symbol;
  String? closetime;
  int? lot;
  double? openprice;
  double? closeprice;
  dynamic swap;
  dynamic commission;
  dynamic sl;
  dynamic tp;
  dynamic profit;
  
  Response.fromJson(Map<String, dynamic> json){
    ticket = json['ticket'];
    opentime = json['opentime'];
    type = json['type'];
    symbol = json['symbol'];
    swap = json['swap'];
    commission = json['commision'];
    lot = json['lot'];
    openprice = json['openprice'];
    closetime = json['closetime'];
    closeprice = json['closeprice'];
    sl = json['sl'];
    tp = json['tp'];
    profit = json['profit'];
  }
}