import 'dart:convert';
import 'package:delapanbelasfx/src/models/detail_temp_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/models/accounts_models.dart';
import 'package:delapanbelasfx/src/models/response_otp_models.dart';
import 'package:delapanbelasfx/src/views/login/view_stepper_trial.dart';
import 'package:delapanbelasfx/src/views/mainpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AccountsController extends GetxController{
  var emailRegisterTemp = ''.obs;
  RxString userID = ''.obs;
  RxString userToken = ''.obs;
  var fullNameRegisterTemp = ''.obs;
  RxString phoneUser = "0".obs;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  var isLoading = false.obs;
  var haveAccount = false.obs;
  var message = ''.obs;
  var accountsModels = Rxn<AccountsModels>();
  var responseOTPModels = Rxn<OTPModels>();
  Rxn<DetailTempModel> detailTempModel = Rxn<DetailTempModel>();
  var emailTemp = "".obs;
  var passwordTemp = "".obs;
  var idTemp = "".obs;
  var emailGoogle = "".obs;
  var nameGoogle = "".obs;
  var skipToDashboard = false.obs;
  RxString responseMessage = "".obs;

  // Get INFO USER API
  Future<bool> getUserInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? stringUserToken = prefs.getString('user_token');
      String? stringUserID = prefs.getString('user_id');
      if(stringUserToken == null || stringUserID == null){
        responseMessage("User token atau user ID gagal ditemukan");
        return false;
      }
      userToken(stringUserToken);
      userID(stringUserID);
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/get-info-user")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'user_token': userToken.value,
        },
      );
      var result = jsonDecode(response.body);
      print("User Token => $stringUserToken");
      print("User ID => $stringUserID");
      if(kDebugMode) print(result);
      isLoading(false);
      if (response.statusCode == 200) {
        responseMessage(result['message']);
        detailTempModel.value = DetailTempModel.fromJson(result);
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

  Future<String> checkMyVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version.substring(0, 3);
  }

  // Compare Version API
  Future<bool> compareVersionApp({String? version}) async {
    if(kDebugMode) print("Fungsi compareversion dijalankan");
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/utils/check-version")!,
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'version': version,
        },
      );

      var result = jsonDecode(response.body);
      debugPrint("$result");
      isLoading(false);

      if(response.statusCode == 200){
        responseMessage(result['message']);
        return true;
      }else{
        responseMessage(result['message']);
        return false;
      }
    } catch (e) {
      isLoading(false);
      responseMessage(e.toString());
      return false;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if(kDebugMode) print("ini user dari login Google => email : ${user?.email} \ndisplay name : ${user?.displayName} \nphotoURL : ${user?.photoURL}");
      if(user != null){
        loginWithGoogleMethod(
          email: user.email,
          name: user.displayName,
          imageProfile: user.photoURL,
        );
      }
    } catch (e) {
      debugPrint('Error signing in with Google: ${e.toString()}');
    }
  }

  // Login With Google V2
  Future<bool> loginWithGoogleMethod({String? name, String? imageProfile, String? email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/login-google")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'display_name': name,
          'display_picture': imageProfile,
          'email': email,
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if(kDebugMode) print("result register with google => $result");
      if (response.statusCode == 200) {
        detailTempModel.value = DetailTempModel.fromJson(result);
        prefs.setString('user_id', result['response']['personal_detail']['id']);
        prefs.setString('user_token', result['response']['token'] ?? '-');
        userID(detailTempModel.value?.response.personalDetail.id);
        userToken(result['response']['token']);
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

/*
  1 = wes terdaftar dan langsung login
  2 = belum terdaftar dan diarahkan ke stepper
*/
// checkGoogleAccountIsAvailable API
  checkGoogleAccountIsAvailable({String? email, String? name, String? urlProfile}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/login-google")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'display_name': name,
          'display_picture': urlProfile,
          'email': email,
        },
      );

      var result = jsonDecode(response.body);
      if(kDebugMode) print(result);
      isLoading(false);
      if(kDebugMode) print("ini result checkGoogleAccountIsAvailable() $result");
      if (response.statusCode == 200) {
        skipToDashboard.value = false;
        emailGoogle.value = email ?? '';
        nameGoogle.value = name ?? '';
        if(kDebugMode) print("ini response status code ${response.statusCode}");
          if(result['message'] == "Pendaftaran dengan google berhasil"){
            if(kDebugMode) print("Masuk ke if karena Register dengan google berhasil");
            accountsModels.value = AccountsModels.fromJson(jsonDecode(response.body));
            prefs.setString('id', result['response']['personal_detail']['id']);
            Future.delayed(const Duration(seconds: 1), (){
              Get.to(() => StepperTrialPage(currentStep: int.parse(result['response']['personal_detail']['ver']), fromLogin: false, registerWithGoogle: true, loginWithGoogle: false));
            });
          }else if(result['message'] == "Login google berhasil"){
            if(kDebugMode) print("Masuk ke else if karena Login dengan google berhasil");
            accountsModels.value = AccountsModels.fromJson(jsonDecode(response.body));
            prefs.setString('id', result['response']['personal_detail']['id']);
            if(result['response']['personal_detail']['status'] == "2"){
              if(kDebugMode) print("Masuk ke if karena status 2 melalui login google");
              Future.delayed(const Duration(seconds: 1), (){
                Get.to(() => StepperTrialPage(currentStep: int.parse(result['response']['personal_detail']['ver']), fromLogin: false, loginWithGoogle: true, registerWithGoogle: false));
              });
            }else if(result['response']['personal_detail']['status'] == "-1"){
              if(kDebugMode) print("Masuk ke if karena status -1 melalui login google");
              prefs.setBool('login', true);
              Future.delayed(const Duration(seconds: 1), (){
                prefs.setBool('loginWithGoogle', true);
                prefs.setString("emailGoogle", email!);
                prefs.setString('id', result['response']['personal_detail']['id']);
                Get.offAll(() => const MainPage());
              });
            }
          }
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


  // Register API
  Future<bool> register({String? email, String? name, String? referalCode = "", String? password, String? phoneCode = "62", String? phoneNumber, String? otp}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/register")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'email': email,
          'name': name,
          'password': password,
          'ibcode': referalCode,
          'phone_code': phoneCode,
          'phone': phoneNumber,
          'otp' : otp
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if(kDebugMode) print("result register manual => $result");
      if (response.statusCode == 200) {
        detailTempModel.value = DetailTempModel.fromJson(result);
        prefs.setString('user_id', detailTempModel.value?.response.personalDetail.id ?? '-');
        prefs.setString('user_token', result['response']['token'] ?? '-');
        userID(detailTempModel.value?.response.personalDetail.id);
        userToken(result['response']['token']);
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

  // Register API
  Future<bool> confirmOTP({String? otp, String? email}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/otp")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'email': email,
          'otp_code' : otp
        },
      );
      var result = jsonDecode(response.body);
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

  // Register API
  Future<bool> resendOTP({String? email}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/resend-otp")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'email': email
        },
      );
      var result = jsonDecode(response.body);
      if(kDebugMode) print(result);
      isLoading(false);
      if (response.statusCode == 200) {
        // responseOTPModels.value = OTPModels.fromJson(result);
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


  // Register API
  Future<bool> sendOTP({String? phone, String? phoneCode}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/send-otp")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'phone': phone,
          'phone_code' : phoneCode
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

  // Forgot Password API
  Future<bool> forgot({String? email}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/forget")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'email': email,
        },
      );
      var result = jsonDecode(response.body);
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
  
  // Login API
  Future<bool> login({String? email, String? password, bool? savedSessionLogin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/auth/login")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'email': email,
          'password': password
        },
      );
      var result = jsonDecode(response.body);
      isLoading(false);
      if(kDebugMode) print("result login => $result");
      if(response.statusCode == 200) {
        detailTempModel.value = DetailTempModel.fromJson(result);
        prefs.setString('user_id', result['response']['personal_detail']['id']);
        prefs.setString('user_token', result['response']['token'] ?? '-');
        prefs.setBool('login', true);
        userID(detailTempModel.value?.response.personalDetail.id);
        userToken(result['response']['token']);
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

  // Change Password API
  Future<bool> changePasswordAPI({String? oldPassword, String? newPassword, bool? savedSessionLogin = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('iuser_idd');
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/change-password")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'id' : id,
          'old_pass' : oldPassword,
          'new_pass': newPassword
        },
      );
      var result = jsonDecode(response.body);
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


  // Change Password API
  Future<bool> editProfile({
    String? city,
    String? tanggalLahir,
    String? tempatLahir,
    String? idType,
    String? idNumber,
    String? zip,
    String? address
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('user_id');
    print(id);
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://api-tridentprofutures.techcrm.net/profile")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'city': city,
          'tanggal-lahir': tanggalLahir,
          'tempat-lahir': tempatLahir,
          'id-type': "KTP",
          'id-number': idNumber,
          'zip': zip,
          'id': id,
          'address': address
        },
      );
      var result = jsonDecode(response.body);
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