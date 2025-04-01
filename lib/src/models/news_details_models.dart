class NewsDetailsModels {
  NewsDetailsModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final String status;
  late final String message;
  late final Response response;
  
  NewsDetailsModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = Response.fromJson(json['response']);
  }
}

class Response {
  Response({
    this.id,
    this.title,
    this.message,
    this.author,
    this.picture,
    this.tanggal
  });
  String? id;
  String? title;
  String? message;
  String? author;
  String? picture;
  String? tanggal;

  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    message = json['message'];
    tanggal = json['tanggal'];
    author = json['author'];
    picture = json['picture'];
  }
}