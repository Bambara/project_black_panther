import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

import '../../core/app_export.dart';
import '../../models/organizer/t_list.dart';
import '../../models/tournament/tournaments.dart';

//Organizer Tournament List Screen Controller
class OTLSController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();
  final _apiClient = Get.find<ApiClient>();

  bool loaded = false;

  final tabList = ['', ''];
  int selectedTab = 0;

  late Tournaments tournaments;
  late TList tList;

  // late Organizations organizations;
  // late Sponsors sponsors;

  @override
  void onReady() {
    loadingData();
  }

  loadReady(HashMap<String, bool> executeList) {
    if (executeList['api_01'] == true) {
      loaded = true;
      update();
    }
  }

  void loadingData() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;

            _apiClient.getTournamentsByTCMemberId(session.id, session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                tList = (result['tournaments'] as TList);

                executeList['api_01'] = true;

/*                List<String> orgIds = [];
                for (var tournament in tournaments.tournaments) {
                  for (var organizer in tournament.toList) {
                    orgIds.add(organizer.organizationId);
                  }
                }

                List<String> spnIds = [];
                for (var tournament in tournaments.tournaments) {
                  for (var sponsor in tournament.tsList) {
                    spnIds.add(sponsor.sponsorId);
                  }
                }

                // Log.i(spnIds);

                _apiClient.getOrganizationByIds(orgIds, session.token).then((result) {
                  if (result!['status'].toString() == '200') {
                    // Log.w(statusSponsor['sponsors']);

                    organizations = (result['organizations'] as Organizations);

                    // List<String> ids = [];
                    // for (var tournament in tournaments.tournaments) {
                    //   for (var organizer in tournament.toList) {
                    //     ids.add(organizer.id);
                    //   }
                    // }

                    executeList['api_02'] = true;
                  } else if (result['status'].toString() == '404') {
                    executeList['api_02'] = true;
                    Log.w('No tournament data');
                  }
                }).catchError((onError) {
                  Fluttertoast.showToast(
                      msg: 'Error : $onError}',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorConstant.errorRed,
                      textColor: ColorConstant.darkBlack,
                      fontSize: 14);
                }).whenComplete(() => loadReady(executeList));

                _apiClient.getSponsorsByIds(spnIds, session.token).then((result) {
                  if (result!['status'].toString() == '200') {
                    // Log.w(statusSponsor['sponsors']);

                    sponsors = (result['sponsors'] as Sponsors);

                    // List<String> ids = [];
                    // for (var tournament in tournaments.tournaments) {
                    //   for (var organizer in tournament.toList) {
                    //     ids.add(organizer.id);
                    //   }
                    // }

                    executeList['api_03'] = true;
                  } else if (result['status'].toString() == '404') {
                    executeList['api_03'] = true;
                    Log.w('No tournament data');
                  }
                }).catchError((onError) {
                  Fluttertoast.showToast(
                      msg: 'Error : $onError}',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorConstant.errorRed,
                      textColor: ColorConstant.darkBlack,
                      fontSize: 14);
                }).whenComplete(() => loadReady(executeList));*/
              } else if (result['status'].toString() == '404') {
                executeList['api_01'] = true;
                Log.w('No tournament data');
              }
            }).catchError((onError) {
              Fluttertoast.showToast(
                  msg: 'Error : $onError}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorConstant.errorRed,
                  textColor: ColorConstant.darkBlack,
                  fontSize: 14);
            }).whenComplete(() => loadReady(executeList));
          } else {
            Fluttertoast.showToast(
                msg: 'Error : No Connection}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorConstant.yellow400,
                textColor: ColorConstant.darkBlack,
                fontSize: 14);
          }
        }).catchError((onError) {
          Fluttertoast.showToast(
              msg: 'Error : $onError}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorConstant.errorRed,
              textColor: ColorConstant.darkBlack,
              fontSize: 14);
        });
      });
    } catch (e) {
      Log.e(e);
    }
  }

  Widget goto(BuildContext context) {
    return Scaffold(
      body: GFFloatingWidget(
        body: const Text('body or any kind of widget here..'),
        verticalPosition: MediaQuery.of(context).size.height * 0.2,
        horizontalPosition: MediaQuery.of(context).size.width * 0.8,
        child: const GFIconBadge(
            counterChild: GFBadge(
              text: '12',
              shape: GFBadgeShape.circle,
            ),
            child: GFAvatar(
              size: GFSize.LARGE,
              backgroundImage: AssetImage('your asset image'),
            )),
      ),
    );
  }
}
