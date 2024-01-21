import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../core/app_export.dart';
import '../../models/common/game.dart';
import '../../models/common/organization.dart';
import '../../models/common/payment.dart';
import '../../models/common/sponsor_profile.dart';
import '../../models/organizer/organizer_profile.dart';
import '../../models/organizer/t_list.dart';
import '../../models/player/player_profile.dart';
import '../../models/tournament/event_match.dart';
import '../../models/tournament/event_team_assign.dart';
import '../../models/tournament/player_team.dart';
import '../../models/tournament/player_teams.dart';
import '../../models/tournament/tc_team.dart';
import '../../models/tournament/tournament.dart';
import '../../models/tournament/tournament_event.dart';
import '../../models/user/generic_login.dart';
import '../../models/user/logging_session.dart';
import '../../models/user/user_profile.dart';
import '../../models/user/user_signup.dart';
import 'api_interface.dart';

class ApiClient {
  final _baseUrl = Constants.baseUrl;
  final _prefUtils = Get.find<PrefUtils>();

  // final _initCtrl = Get.put<InitController>(InitController());

  final Connectivity _connectivity = Connectivity();

  final userFolder = CloudinaryPublic('dptexius9', 'user_images', cache: false);
  final organizationFolder = CloudinaryPublic('dptexius9', 'organization_images', cache: false);
  final organizerFolder = CloudinaryPublic('dptexius9', 'organizer_images', cache: false);
  final tournamentFolder = CloudinaryPublic('dptexius9', 'tournament_images', cache: false);
  final eventFolder = CloudinaryPublic('dptexius9', 'event_images', cache: false);
  final paymentFolder = CloudinaryPublic('dptexius9', 'payments', cache: false);

/*  void _showErrorToast(String error) {
    try {
      Fluttertoast.showToast(msg: error, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
    } catch (e) {
      Log.e(e);
    }
  }

  void _showInfoToast(String info) {
    try {
      Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.greenTransparent, textColor: ColorConstant.darkBlack, fontSize: 14);
    } catch (e) {
      Log.e(e);
    }
  }*/

  Future<bool> isConnect() async {
    bool isConnect = false;
    ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();
    try {
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet) {
        final connStatus = await InternetAddress.lookup('www.google.com');

        if (connStatus.isNotEmpty && connStatus[0].rawAddress.isNotEmpty) {
          isConnect = true;
          // Log.i('Connection Success');
        }
      }
    } on SocketException catch (e) {
      isConnect = false;
      Fluttertoast.showToast(
          msg: 'Error : ${e.osError}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
      Log.e(e);
    } on Error catch (e) {
      isConnect = false;
      Fluttertoast.showToast(
          msg: 'Error : $e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
      Log.e(e);
    }

    return isConnect;
  }

  Future<HashMap<String, String>?> uploadUserImage(File image, String name) async {
    HashMap<String, String> result = HashMap();

    try {
      CloudinaryResponse response = await userFolder
          .uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image, publicId: '${name}_${DateTime.now().toLocal().toString().replaceAll(' ', '_')}'),
      )
          .whenComplete(() {
        Log.i('Upload Success');
      });
      result['id'] = response.publicId;
      result['url'] = response.secureUrl;
      Log.i('Url : ${result['url']}');
      return result;
    } on CloudinaryException catch (e) {
      Log.e(e);
      result['id'] = name;
      result['url'] = name;
    } finally {}
    return result;
  }

  Future<HashMap<String, dynamic>> playerSignup(UserSignup playerSignup) async {
    HashMap<String, dynamic> result = HashMap();
    final client = RetryClient(http.Client());

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.userSignup),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(playerSignup.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['user'] = UserSignup.fromJson(jsonDecode(response.body));
        return result;
        //
      } else {
        result['status'] = response.statusCode.toString();
        result['user'] = '';
        Log.e(response.statusCode);
        Toaster.showErrorToast('Something went wrong !');
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }

    return result;
  }

  Future<HashMap<String, dynamic>> premiumSignup(UserSignup userSignup) async {
    HashMap<String, dynamic> result = HashMap();
    final client = RetryClient(http.Client());

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.userSignup),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(userSignup.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['user'] = UserSignup.fromJson(jsonDecode(response.body));
        return result;
        //
      } else {
        result['status'] = response.statusCode.toString();
        result['user'] = '';
        Log.e(response.statusCode);
        Toaster.showErrorToast('Something went wrong !');
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> userSignIn(GenericLogin genericLogin) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.generalLogin),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(genericLogin.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final loggingSession = LoggingSession.fromJson(jsonDecode(response.body));
        // Log.i(loggingSession);
        result['status'] = response.statusCode.toString();
        result['session'] = loggingSession;
        _prefUtils.storeLoggingSession(loggingSession);
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> removeFreshUser(String id) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.delete(
        Uri.http(
          _baseUrl,
          ApiInterface.removeFreshUser,
          {'id': id},
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // body: jsonEncode(payment.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        Toaster.showInfoToast('User delete success !');
        return result;
      } else {
        Log.e(response.statusCode);
        Toaster.showErrorToast('Payment fail !');
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //User Profile API
  Future<HashMap<String, dynamic>?> getUserProfileById(String userId, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getUserProfileById, {
          'id': userId,
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['user_profile'] = UserProfile.fromJson(jsonDecode(response.body));
        // Log.i(UserProfile.fromJson(jsonDecode(response.body)).toJson());
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> updateUserProfile(UserProfile userProfile, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      // Log.i(Uri.http(_baseUrl, ApiInterface.updateUserProfile, {'id': userProfile.id}));
      // Log.i(userProfile.toJson());

      final response = await client.patch(
        Uri.http(_baseUrl, ApiInterface.updateUserProfile, {'id': userProfile.id}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userProfile.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        result['userProfile'] = UserProfile.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['userProfile'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Organizer API
  Future<HashMap<String, String>> uploadOrganizerProfileImage(File image, String name) async {
    HashMap<String, String> result = HashMap();

    try {
      CloudinaryResponse response = await organizerFolder
          .uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image, publicId: '${name}_${DateTime.now().toLocal().toString().replaceAll(' ', '_')}'),
      )
          .whenComplete(() {
        Log.i('Upload Success');
      });
      result['id'] = response.publicId;
      result['url'] = response.secureUrl;
      return result;
    } on SocketException catch (e) {
      Log.e(e);
    } on CloudinaryException catch (e) {
      Log.e(e);
      result['id'] = name;
      result['url'] = name;
    } finally {}
    return result;
  }

  Future<HashMap<String, dynamic>> createOrganizerProfile(OrganizerProfile organizerProfile, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.createOrganizerProfile),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(organizerProfile.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        result['status'] = response.statusCode.toString();
        result['organizerProfile'] = OrganizerProfile.fromJson(jsonDecode(response.body));
        return result;
      } else if (response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        result['organizerProfile'] = OrganizerProfile.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['organizerProfile'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> updateOrganizerProfile(OrganizerProfile organizerProfile, String organizerId, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.patch(
        Uri.http(_baseUrl, ApiInterface.updateOrganizerProfile, {
          'id': organizerId,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(organizerProfile.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['organizerProfile'] = OrganizerProfile.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['organizerProfile'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getOrganizerProfileByUserId(String userId, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getOrganizerProfileByUserId, {
          'user_id': userId,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['organizer'] = OrganizerProfile.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['organizer'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Player API
  ///Get player profile using user id
  Future<HashMap<String, dynamic>?> getPlayerProfileByUserId(String userId, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getPlayerProfileByUserId, {
          'user_id': userId,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['player'] = PlayerProfile.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['organizer'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Organization API
  Future<HashMap<String, String>> uploadOrganizationProfileImage(File image, String name) async {
    HashMap<String, String> result = HashMap();

    try {
      CloudinaryResponse response = await organizationFolder
          .uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image, publicId: '${name}_${DateTime.now().toLocal().toString().replaceAll(' ', '_')}'),
      )
          .whenComplete(() {
        Log.i('Upload Success');
      });
      result['id'] = response.publicId;
      result['url'] = response.secureUrl;
      return result;
    } on SocketException catch (e) {
      Log.e(e);
    } on CloudinaryException catch (e) {
      Log.e(e);
      result['id'] = name;
      result['url'] = name;
    } finally {}
    return result;
  }

  Future<HashMap<String, dynamic>> createOrganization(Organization organization, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.createOrganization),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(organization.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201 || response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        // result['organizations'] = Organizations.fromJson(jsonDecode(response.body));
        result['organizations'] = (jsonDecode(response.body)['organizations'] as List<dynamic>).map((e) => Organization.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        // result['organizations'] = Organizations.fromJson(jsonDecode(response.body));
        result['organizations'] = (jsonDecode(response.body)['organizations'] as List<dynamic>).map((e) => Organization.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getOrganizationByName(String name, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getOrganizationByName, {
          'name': name,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['organization'] = Organization.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['organization'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getAllOrganizations(String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['organizations'] = (jsonDecode(response.body)['organizations'] as List<dynamic>).map((e) => Organization.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getOrganizationsByType(String type, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getOrganizationsByType, {
          'status': status,
          'type': type,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['organizations'] = (jsonDecode(response.body)['organizations'] as List<dynamic>).map((e) => Organization.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getOrganizationByIds(List<String> idList, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.post(
        Uri.http(
          _baseUrl,
          ApiInterface.getOrganizationByIdList,
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'ids': idList}),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['organizations'] = (jsonDecode(response.body)['organizations'] as List<dynamic>).map((e) => Organization.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['organizations'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Sponsor API
  Future<HashMap<String, dynamic>?> getAllSponsors(String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getAllSponsors, {
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['sponsors'] = (jsonDecode(response.body)['sponsors'] as List<dynamic>).map((e) => SponsorProfile.fromJson(e as Map<String, dynamic>)).toList();
        // Log.i(Sponsors.fromJson(jsonDecode(response.body)).sponsors.first.name);
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getSponsorsByIds(List<String> idList, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.post(
        Uri.http(
          _baseUrl,
          ApiInterface.getSponsorByIdList,
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'ids': idList}),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['sponsors'] = (jsonDecode(response.body)['sponsors'] as List<dynamic>).map((e) => SponsorProfile.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['sponsors'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Game API
  Future<HashMap<String, dynamic>?> getAllGames(String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      // Log.i(Uri.http(_baseUrl, ApiInterface.getAllGames, {'status': status}));

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getAllGames, {
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['games'] = (jsonDecode(response.body)['games'] as List<dynamic>).map((e) => Game.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getGamesByIds(List<String> idList, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.post(
        Uri.http(
          _baseUrl,
          ApiInterface.getAllGamesByIdList,
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'ids': idList}),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['games'] = (jsonDecode(response.body)['games'] as List<dynamic>).map((e) => Game.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['games'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Tournament API
  Future<HashMap<String, String>> uploadTournamentArtWork(File image, String name, String prefix) async {
    HashMap<String, String> result = HashMap();

    try {
      CloudinaryResponse response = await tournamentFolder
          .uploadFile(CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image, publicId: '${name}_${prefix}_${DateTime.now().toLocal().toString().replaceAll(' ', '_')}'))
          .whenComplete(() {
        Log.i('Upload Success');
      });
      result['id'] = response.publicId;
      result['url'] = response.secureUrl;
      return result;
    } on SocketException catch (e) {
      Log.e(e);
    } on CloudinaryException catch (e) {
      Log.e(e);
      result['id'] = name;
      result['url'] = name;
    } finally {}
    return result;
  }

  Future<HashMap<String, dynamic>> createTournament(Tournament tournament, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.createTournament),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(tournament.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        result['tournament'] = Tournament.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['tournament'] = Tournament.fromJson(jsonDecode(response.body));
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> updateTournament(Tournament tournament, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.patch(
        Uri.http(_baseUrl, ApiInterface.updateTournament),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(tournament.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        result['tournament'] = Tournament.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['tournament'] = Tournament.fromJson(jsonDecode(response.body));
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getTournamentsByTCMemberId(String userId, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getTournamentsByTCMemberId, {
          'id': userId,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['tournaments'] = TList.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['tournaments'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      // //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> registerPlayerTeam(PlayerTeam playerTeam, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.registerPlayerTeam),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(playerTeam.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        result['playerTeam'] = PlayerTeam.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['playerTeam'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Payments

  ///Upload payment attachment
  Future<HashMap<String, String>> uploadPaymentAttachment(File image, String name, String prefix) async {
    HashMap<String, String> result = HashMap();

    try {
      await paymentFolder
          .uploadFile(CloudinaryFile.fromFile(
        image.path,
        resourceType: CloudinaryResourceType.Image,
        publicId: '${name}_${prefix}_${DateTime.now().toLocal().toString().replaceAll(' ', '_')}',
      ))
          .then((response) {
        result['id'] = response.publicId;
        result['url'] = response.secureUrl;
      }).whenComplete(() {
        Log.i('Upload Success ! ${result['id']}');
      });
    } on SocketException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on CloudinaryException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {}
    return result;
  }

  ///Make tournament payment
  Future<HashMap<String, dynamic>> makeTournamentPayment(Payment payment, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.makeTournamentPayment),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payment.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['payment'] = Payment.fromJson(jsonDecode(response.body));
        Toaster.showInfoToast('Payment success !');
        return result;
      } else {
        Log.e(response.statusCode);
        Toaster.showErrorToast('Payment fail !');
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  ///Update tournament payment
  Future<HashMap<String, dynamic>> getTournamentPayments(String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.get(
        Uri.http(
          _baseUrl,
          ApiInterface.getTournamentPayments,
          {'status': status},
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode(status.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        // result['playerTeam'] = Payment.fromJson(jsonDecode(response.body));
        result['payments'] = (jsonDecode(response.body)['payments'] as List<dynamic>).map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList();
        Toaster.showInfoToast('Payments Load success !');
        return result;
      } else if (response.statusCode == 404) {
        Log.w(response.statusCode);
        Toaster.showWarnToast('Not payments found !');
      } else {
        Log.e(response.statusCode);
        Toaster.showErrorToast(jsonDecode(response.body)['error'].toString());
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  ///Update tournament payment
  Future<HashMap<String, dynamic>> updateTournamentPayment(Payment payment, String id, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.patch(
        Uri.http(
          _baseUrl,
          ApiInterface.updateTournamentPayment,
          {'id': id},
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payment.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['payment'] = Payment.fromJson(jsonDecode(response.body));
        Toaster.showInfoToast('Payment update success !');
        return result;
      } else {
        Log.e(response.statusCode);
        Toaster.showErrorToast('Payment fail !');
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  ///Remove tournament payment
  Future<HashMap<String, dynamic>> removeTournamentPayment(String id, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.delete(
        Uri.http(
          _baseUrl,
          ApiInterface.deleteTournamentPayment,
          {'id': id},
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode(payment.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['payments'] = (jsonDecode(response.body)['payments'] as List<dynamic>).map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList();
        Toaster.showInfoToast('Payment delete success !');
        return result;
      } else {
        Log.e(response.statusCode);
        Toaster.showErrorToast('Payment fail !');
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  ///Get All Registered Player Teams using Tournament id.
  Future<HashMap<String, dynamic>?> getTRegisteredPlayerTeamsByTId(String tournamentId, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getTRegPlayerTeams, {
          'tournament_id': tournamentId,
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['playerTeams'] = (jsonDecode(response.body)['player_teams'] as List<dynamic>).map((e) => PlayerTeam.fromJson(e as Map<String, dynamic>)).toList();
        // result['playerTeams'] = PlayerTeams.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['playerTeams'] = (jsonDecode(response.body)['player_teams'] as List<dynamic>).map((e) => PlayerTeam.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> updatePlayerTeam(PlayerTeam playerTeam, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.patch(
        Uri.http(_baseUrl, ApiInterface.updatePlayerTeam),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(playerTeam.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        result['playerTeams'] = PlayerTeam.fromJson(jsonDecode(response.body));
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['playerTeams'] = '';
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Tournament Event API
  Future<HashMap<String, String>> uploadEventArtWorks(File image, String name, String prefix) async {
    HashMap<String, String> result = HashMap();
    try {
      CloudinaryResponse response = await eventFolder
          .uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          resourceType: CloudinaryResourceType.Image,
          publicId: '${name}_${prefix}_${DateTime.now().toLocal().toString().replaceAll(' ', '_')}',
        ),
      )
          .whenComplete(() {
        Log.i('Upload Success');
      });
      result['id'] = response.publicId;
      result['url'] = response.secureUrl;
      return result;
    } on SocketException catch (e) {
      Log.e(e);
    } on CloudinaryException catch (e) {
      Log.e(e);
      result['id'] = name;
      result['url'] = name;
    } finally {}
    return result;
  }

  Future<HashMap<String, dynamic>> createEvent(TournamentEvent te, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.createTournamentEvent),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(te.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        // Log.w(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['t_events'] = (jsonDecode(response.body)['events'] as List<dynamic>).map((e) => TournamentEvent.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        // result['t_events'] = TEvents.fromJson(jsonDecode(response.body));
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getEventsByTournamentId(String id, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getEventsByTId, {
          'id': id,
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        // result['t_events'] = TEvents.fromJson(jsonDecode(response.body));
        result['t_events'] = (jsonDecode(response.body)['events'] as List<dynamic>).map((e) => TournamentEvent.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      // //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> assignPlayerTeamsToEvents(List<EventTeamAssign> eventTeamAssign, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(_baseUrl, ApiInterface.assignPlayerTeamsToEventList, {
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'eventTeamAssign': eventTeamAssign}),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        // result['playerTeams'] = PlayerTeams.fromJson(jsonDecode(response.body));
        result['playerTeams'] = (jsonDecode(response.body)['assigned_teams'] as List<dynamic>).map((e) => EventTeamAssign.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['playerTeams'] = PlayerTeams.fromJson(jsonDecode(response.body));
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  ///Get all event matches by event id
  ///
  Future<HashMap<String, dynamic>?> getEventMatchesByTournamentId(String tournamentId, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getAllMatchesByTournamentId, {
          'tournament_id': tournamentId,
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        // Toaster.showInfoToast('Event matches load successful !');
        result['status'] = response.statusCode.toString();
        result['event_matches'] = (jsonDecode(response.body)['eventMatches'] as List<dynamic>).map((e) => EventMatch.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      // //Log.i('Client Closed');
    }
    return result;
  }

  ///Assign player team to the event
  Future<HashMap<String, dynamic>> assignPlayerTeamToEvent(EventTeamAssign eventTeamAssign, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(
          _baseUrl,
          ApiInterface.assignPlayerTeamsToEvent,
          {
            // 'status': status,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(eventTeamAssign.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.w(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['assigned_teams'] = (jsonDecode(response.body)['assigned_teams'] as List<dynamic>).map((e) => EventTeamAssign.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e('${response.statusCode} : ${jsonDecode(response.body)['error']}');

        final error = jsonDecode(response.body)['error'].toString();

        switch (response.statusCode) {
          case 404:
            {
              Toaster.showWarnToast('Team data not found');
            }
            break;

          case 500:
            {
              if (error.contains('Duplicate')) {
                Toaster.showWarnToast('This team already assigned to this event');
              } else {
                Toaster.showErrorToast(error);
              }
            }
            break;

          default:
            {
              Toaster.showErrorToast(error);
            }
            break;
        }
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> sendSMSToAssignedPlayers(Map<String, dynamic> payLoad, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(
          _baseUrl,
          ApiInterface.sendSMSToAssignPlayers,
          {
            // 'status': status,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payLoad),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.w(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        return result;
      } else {
        Log.e('${response.statusCode} : ${jsonDecode(response.body)['error']}');

        final error = jsonDecode(response.body)['error'].toString();

        switch (response.statusCode) {
          case 404:
            {
              Toaster.showWarnToast('Team data not found');
            }
            break;

          case 500:
            {
              if (error.contains('Duplicate')) {
                Toaster.showWarnToast('This team already assigned to this event');
              } else {
                Toaster.showErrorToast(error);
              }
            }
            break;

          default:
            {
              Toaster.showErrorToast(error);
            }
            break;
        }
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> makePaymentFromAssignedPlayers(Map<String, dynamic> payLoad, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.post(
        Uri.http(
          _baseUrl,
          ApiInterface.makePaymentFromAssignPlayers,
          {
            // 'status': status,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payLoad),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.w(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        return result;
      } else {
        Log.e('${response.statusCode} : ${jsonDecode(response.body)['error']}');

        final error = jsonDecode(response.body)['error'].toString();

        switch (response.statusCode) {
          case 404:
            {
              Toaster.showWarnToast('Team data not found');
            }
            break;

          case 500:
            {
              if (error.contains('Duplicate')) {
                Toaster.showWarnToast('This team already assigned to this event');
              } else {
                Toaster.showErrorToast(error);
              }
            }
            break;

          default:
            {
              Toaster.showErrorToast(error);
            }
            break;
        }
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  ///Resign  player teams from event.
  Future<HashMap<String, dynamic>> resignPlayerTeamToEvent(String id, String teId, String ptlId, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.delete(
        Uri.http(
          _baseUrl,
          ApiInterface.resignPlayerTeamsToEvent,
          {
            'te_id': teId,
            'ptl_id': ptlId,
            'id': id,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode(eventTeamAssign.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.w(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        result['assigned_teams'] = (jsonDecode(response.body)['assigned_teams'] as List<dynamic>).map((e) => EventTeamAssign.fromJson(e as Map<String, dynamic>)).toList();
        Toaster.showInfoToast('Resign done successfully');
        return result;
      } else {
        Log.e('${response.statusCode} : ${jsonDecode(response.body)['error']}');

        final error = jsonDecode(response.body)['error'].toString();

        switch (response.statusCode) {
          case 404:
            {
              Toaster.showWarnToast('Team data not found 😮 !');
            }
            break;

          case 500:
            {
              if (error.contains('Duplicate')) {
                Toaster.showWarnToast('This team already assigned to this event');
              } else {
                Toaster.showErrorToast(error);
              }
            }
            break;

          default:
            {
              Toaster.showErrorToast(error);
            }
            break;
        }
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  ///Get Event Assigned  Player Teams using "ptl_id".
  Future<HashMap<String, dynamic>> getAssignPlayerTeamsByPtlId(String ptlId, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getAssignPlayerTeamsByPtlId, {
          'ptl_id': ptlId,
          // 'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode({'eventTeamAssign': eventTeamAssign}),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        // result['playerTeams'] = PlayerTeams.fromJson(jsonDecode(response.body));
        result['playerTeams'] = (jsonDecode(response.body)['assigned_teams'] as List<dynamic>).map((e) => EventTeamAssign.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['playerTeams'] = (jsonDecode(response.body)['assigned_teams'] as List<dynamic>).map((e) => EventTeamAssign.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  ///Get event assigned all player teams filter by "te_id".
  Future<HashMap<String, dynamic>> getAllEventAssignPlayerTeamsByEventId(String eventId, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getEventAssignedAllPlayerTeamsByTeId, {
          'te_id': eventId,
          // 'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode({'eventTeamAssign': eventTeamAssign}),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        // result['playerTeams'] = PlayerTeams.fromJson(jsonDecode(response.body));
        result['assigned_teams'] = (jsonDecode(response.body)['assigned_teams'] as List<dynamic>).map((e) => EventTeamAssign.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Fluttertoast.showToast(
            msg: jsonDecode(response.body)['error'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorConstant.greenTransparent,
            textColor: ColorConstant.darkBlack,
            fontSize: 14);
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        result['error'] = (jsonDecode(response.body)['error']);
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>> getAllTCTeamsByTournamentId(String tId, String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getAllTCTeamsByTId, {
          'id': tId,
          // 'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode({'eventTeamAssign': eventTeamAssign}),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        result['status'] = response.statusCode.toString();
        // Log.w(jsonDecode(response.body));
        // result['playerTeams'] = PlayerTeams.fromJson(jsonDecode(response.body));
        result['te_teams'] = (jsonDecode(response.body)['tct_list'] as List<dynamic>).map((e) => TCTeam.fromJson(e as Map<String, dynamic>)).toList();
        Toaster.showInfoToast('Coordinator teams load done ☺');
        return result;
      } else {
        Log.e('${response.statusCode} : ${jsonDecode(response.body)['error']}');

        final error = jsonDecode(response.body)['error'].toString();

        switch (response.statusCode) {
          case 404:
            {
              Toaster.showWarnToast(error);
            }
            break;

          case 500:
            {
              Toaster.showErrorToast(error);
            }
            break;

          default:
            {
              Toaster.showErrorToast(error);
            }
            break;
        }
      }
    } on TimeoutException catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } on Error catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  //Tournament Player Team API
  Future<HashMap<String, String>> uploadPlayerTeamLogo(File image, String name, String prefix) async {
    HashMap<String, String> result = HashMap();

    try {
      CloudinaryResponse response = await tournamentFolder
          .uploadFile(CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image, publicId: '${name}_${prefix}_${DateTime.now().toLocal().toString().replaceAll(' ', '_')}'))
          .whenComplete(() {
        Log.i('Upload Success');
      });
      result['id'] = response.publicId;
      result['url'] = response.secureUrl;
      return result;
    } on SocketException catch (e) {
      Log.e(e);
    } on CloudinaryException catch (e) {
      Log.e(e);
      result['id'] = name;
      result['url'] = name;
    } finally {}
    return result;
  }

  //Player API
  Future<HashMap<String, dynamic>?> getAllTNotRegPlayers(String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getAllTNotRegPlayers, {
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        // result['playerProfiles'] = PlayerProfiles.fromJson(jsonDecode(response.body));
        result['playerProfiles'] = (jsonDecode(response.body)['profiles'] as List<dynamic>).map((e) => PlayerProfile.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }

  Future<HashMap<String, dynamic>?> getAllTRegPlayers(String status, String token) async {
    final client = RetryClient(http.Client());
    HashMap<String, dynamic> result = HashMap();

    try {
/*      Log.i(Uri.http(_baseUrl, ApiInterface.getAllOrganizations, {
        'status': status,
      }));*/

      final response = await client.get(
        Uri.http(_baseUrl, ApiInterface.getAllTRegPlayers, {'status': status}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Log.i(jsonDecode(response.body));
        result['status'] = response.statusCode.toString();
        // result['playerProfiles'] = PlayerProfiles.fromJson(jsonDecode(response.body));
        result['playerProfiles'] = (jsonDecode(response.body)['profiles'] as List<dynamic>).map((e) => PlayerProfile.fromJson(e as Map<String, dynamic>)).toList();
        return result;
      } else {
        Log.e(response.statusCode);
        result['status'] = response.statusCode.toString();
        return result;
      }
    } on TimeoutException catch (e) {
      Log.e(e);
    } on Error catch (e) {
      Log.e(e);
      result['status'] = e;
      return result;
    } finally {
      client.close();
      //Log.i('Client Closed');
    }
    return result;
  }
}
