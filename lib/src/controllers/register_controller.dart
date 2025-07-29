import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController extends GetxController{
  AccountsController accountsController = Get.put(AccountsController());
  var isLoading = false.obs;
  RxString responseMessage = "None".obs;

  // register step 1
  Future<bool> step1({
    String? phone,
    String? gender,
    String? city,
    String? country,
    String? address,
    String? tglLahir,
    String? tempatLahir,
    String? zip
  }) async {
    String? idTemporary = accountsController.userToken.value;
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/verify-1")!,
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': idTemporary,
          'phone': phone,
          'gender': gender,
          'city': city,
          'country': country,
          'address': address,
          'tanggal_lahir' : tglLahir,
          'tempat_lahir' : tempatLahir,
          'zip': zip,
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if(kDebugMode) print(result);
      if (response.statusCode == 200) {
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

  // register step 2
  Future<bool> step2({
    String? bank1Account,
    String? bank1name,
    String? bank1branch,
    String? bank1type,
    String? bank2account,
    String? bank2name,
    String? bank2branch,
    String? bank2type
  }) async {
    String? idTemporary = accountsController.userToken.value;
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/verify-2")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'user_token': idTemporary,
          'bank_1_account': bank1Account,
          'bank_1_name': bank1name,
          'bank_1_branch': bank1branch,
          'bank_1_type': bank1type,
          'bank_2_account': bank2account,
          'bank_2_name': bank2name,
          'bank_2_branch': bank2branch,
          'bank_2_type': bank2type
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if(kDebugMode) print(result);
      if (response.statusCode == 200) {
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

  // register step 3
  Future<bool> step3({
      String? idType,
      String? idNumber,
    }) async {
    String? idTemporary = accountsController.userToken.value;
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/verify-3")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'user_token': idTemporary,
          'id_type': idType,
          'id_number': idNumber
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if(kDebugMode) print("ini result dari step 33 $result dengan idTemporary => $idTemporary");
      if (response.statusCode == 200) {
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
}
