class DocumentModels {
  DocumentModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final String status;
  late final String message;
  late final List<Response> response;

  DocumentModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['response'] = response.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Response {
  Response({
    this.nomor,
    this.title,
    this.desc,
    this.download,
  });
  String? nomor;
  String? title;
  String? desc;
  String? download;

  Response.fromJson(Map<String, dynamic> json){
    nomor = json['nomor'];
    title = json['title'];
    desc = json['desc'];
    download = json['download'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nomor'] = nomor;
    data['title'] = title;
    data['desc'] = desc;
    data['download'] = download;
    return data;
  }
}