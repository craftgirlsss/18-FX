class NewsModels {
  NewsModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final bool status;
  late final String message;
  late final List<Response> response;
  
  NewsModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    this.id,
    this.title,
    this.message,
    this.author,
    this.tanggal,
    this.picture,
  });
  String? id;
  String? title;
  String? message;
  String? author;
  String? tanggal;
  String? picture;
  
  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    message = json['message'];
    author = json['author'];
    tanggal = json['tanggal'];
    picture = json['picture'];
  }
}