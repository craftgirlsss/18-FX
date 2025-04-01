class CountryModels {
  CountryModels({
    required this.country,
    required this.code,
    required this.iso,
  });
  late final String country;
  late final String code;
  late final String iso;
  
  CountryModels.fromJson(Map<String, dynamic> json){
    country = json['country'];
    code = json['code'];
    iso = json['iso'];
  }

}