import 'dart:convert';
import 'package:delapanbelasfx/src/models/document_models.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/models/news_details_models.dart';
import 'package:delapanbelasfx/src/models/news_models.dart';
import 'package:http/http.dart' as http;
import 'package:delapanbelasfx/src/models/image_slider_models.dart';

class UtilsController extends GetxController{
  var isLoading = false.obs;
  RxString mainURL = "https://api.dbsolution.app".obs;
  RxString xAPIKey = "fewAHdSkx28301294cKSnczdAs".obs;
  RxString responseMessage = "".obs;
  Rxn<ImageSliderModels> responseImageSlider = Rxn<ImageSliderModels>();
  var newsModels = Rxn<NewsModels>();
  var newsDetailModels = Rxn<NewsDetailsModels>();
  Rxn<DocumentModels> documentModels = Rxn<DocumentModels>();

  // Image Slider HomePage API
  Future<bool> getImageSlider() async {
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.tryParse("${mainURL.value}/util/slide")!, 
        headers: {
          'x-api-key': xAPIKey.value,
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if (response.statusCode == 200) {
        responseImageSlider.value = ImageSliderModels.fromJson(result);
        responseMessage(result['message']);
        return true;
      } else {
        responseMessage(result['message']);
        return false;
      }
    } catch (e) {
      isLoading(false);
      responseMessage(e.toString());
      return false;
    }
  }


  Future<bool> getListNewsAPI() async {
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.tryParse("${mainURL.value}/util/news")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if (response.statusCode == 200) {
        newsModels.value = NewsModels.fromJson(result);
        responseMessage(result['message']);
        return true;
      } else {
        responseMessage(result['message']);
        return false;
      }
    } catch (e) {
      responseMessage(e.toString());
      isLoading(false);
      return false;
    }
  }

  getDetailsNewsAPI({String? id}) async {
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.tryParse("${mainURL.value}/news?type_news=detail&id=$id")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if (response.statusCode == 200) {
        newsDetailModels.value = NewsDetailsModels.fromJson(result);
        responseMessage(result['message']);
        return true;
      } else {
        responseMessage(result['message']);
        return false;
      }
    } catch (e) {
      isLoading(false);
      responseMessage(e.toString());
      return false;
    }
  }

  // Documents List GET
  Future<bool> downloadDocuments({String? id}) async {
    isLoading(true);
    try{
      http.Response response = await http.get(
        Uri.tryParse("${mainURL.value}/document?id=$id")!,
        headers: {
          'x-api-key': xAPIKey.value,
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if(response.statusCode == 200){
        documentModels.value = DocumentModels.fromJson(result);
        responseMessage(result['message']);
        return true;
      }else{
        responseMessage(result['message']);
        return false;
      }
    }catch(e){
      responseMessage(e.toString());
      return false;
    }
  }
}