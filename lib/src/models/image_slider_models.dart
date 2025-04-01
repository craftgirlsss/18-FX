class ImageSliderModels {
  ImageSliderModels({
    required this.status,
    required this.message,
    required this.response,
  });
  late final bool status;
  late final String message;
  late final List<Response> response;
  
  ImageSliderModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    required this.id,
    required this.picture,
    required this.link,
  });
  String? id;
  String? picture;
  String? link;
  
  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    picture = json['picture'];
    link = json['link'];
  }
}