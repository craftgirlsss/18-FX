import 'dart:convert';
import 'package:delapanbelasfx/src/models/bank_admin_models.dart';
import 'package:delapanbelasfx/src/models/bank_user_models.dart';
import 'package:delapanbelasfx/src/models/list_trading_account_models.dart';
import 'package:delapanbelasfx/src/models/money_conversion_models.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:http_parser/http_parser.dart';

class TradingAccountController extends GetxController{
  RxBool isLoading = false.obs;
  RxString responseMessage = "".obs;
  AccountsController accountsController = Get.find();
  Rxn<ListTradingAccountModels> listTradingAccount = Rxn<ListTradingAccountModels>();
  Rxn<BankAdminModels> bankAdminModels = Rxn<BankAdminModels>();
  Rxn<BankUserModels> bankUserModels = Rxn<BankUserModels>();
  Rxn<MoneyConversionModels> moneyConversionModels = Rxn<MoneyConversionModels>();

  @override
  onInit() {
    super.onInit();
    getListAccountTrading();
  }

  // CREATE DEMO AKUN TRADING API
  Future<bool> createDemo() async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api.dbsolution.app/account/create-demo")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': accountsController.userToken.value
        },
      );
      var result = jsonDecode(response.body);
      if(kDebugMode) print(result);
      isLoading(false);
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

  // POST LIST TRADING AKUN API
  Future<bool> getListAccountTrading() async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api.dbsolution.app/account/info")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': accountsController.userToken.value
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if (response.statusCode == 200) {
        listTradingAccount.value = ListTradingAccountModels.fromJson(result);
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

  // POST LIST BANK ADMIN API
  Future<bool> getListBankAdmin({String? currency}) async {
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.tryParse("https://api.dbsolution.app/util/bank-admin?currency=$currency")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if (response.statusCode == 200) {
        bankAdminModels.value = BankAdminModels.fromJson(result);
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

  // POST LIST BANK USER API
  Future<bool> getListBankUser() async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api.dbsolution.app/account/get_user_bank")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': accountsController.userToken.value
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if (response.statusCode == 200) {
        bankUserModels.value = BankUserModels.fromJson(result);
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


  // POST INFO RATE CONVERSION MONEY API
  // type = withdrawal, deposit
  Future<bool> moneyConversion({String? amount, String? type, String? tradingID}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api.dbsolution.app/transaction/rate-conversation")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': accountsController.userToken.value,
          'account': tradingID,
          'type': type ?? "withdrawal",
          'amount': amount
        },
      );
      var result = jsonDecode(response.body);
      if(kDebugMode) print(result);
      isLoading(false);
      if (response.statusCode == 200) {
        moneyConversionModels.value = MoneyConversionModels.fromJson(result);
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

  // INTERNAL TRANSFER API
  Future<bool> internalTransfer({String? amount, String? accountFrom, String? accountTo}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api.dbsolution.app/transaction/internal-transfer")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': accountsController.userToken.value,
          'acc_from': accountFrom,
          'acc_to': accountTo,
          'amount': amount
        },
      );
      var result = jsonDecode(response.body);
      if(kDebugMode) print(result);
      isLoading(false);
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

  // MUTASI AKUN TRADING API
  Future<bool> mutasiAkun({String? amount, String? accountFrom, String? accountTo}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api.dbsolution.app/transaction/internal-transfer")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': accountsController.userToken.value,
          'acc_from': accountFrom,
          'acc_to': accountTo,
          'amount': amount
        },
      );
      var result = jsonDecode(response.body);
      if(kDebugMode) print(result);
      isLoading(false);
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

  // POST WITHDRAWAL API
  Future<bool> withdrawal({String? amount, String? userBankID, String? tradingID}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api.dbsolution.app/transaction/withdrawal")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': accountsController.userToken.value,
          'account': tradingID,
          'bank_user': userBankID,
          'amount': amount
        },
      );
      var result = jsonDecode(response.body);
      if(kDebugMode) print(result);
      isLoading(false);
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

  // POST DEPOSIT API
  Future<bool> deposit({String? amount, String? userBankID, String? bankAdminID, String? tradingID, String? urlImage}) async {
    try {
      isLoading(true);
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('https://api.dbsolution.app/transaction/deposit'));
      request.headers.addAll({
        'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
        'Content-Type': 'application/x-www-form-urlencoded'
      });
      request.fields.addAll({
        'user_token': accountsController.userToken.value,
        'account': tradingID!,
        'bank_user': userBankID!,
        'bank_admin' : bankAdminID!,
        'amount': amount!
      });
      request.files.add(await http.MultipartFile.fromPath('image', urlImage!, contentType: MediaType('image', 'jpeg')));
      http.StreamedResponse response = await request.send();
      var result = jsonDecode(await response.stream.bytesToString());
      isLoading(false);
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