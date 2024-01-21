import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/app_export.dart';
import '../../../core/utils/generator.dart';
import '../../../models/common/art_work.dart';
import '../../../models/common/payment.dart';
import '../../../models/player/player_profile.dart';
import '../../../models/tournament/event_match.dart';
import '../../../models/tournament/player_team.dart';
import '../../../models/tournament/tournament.dart';
import '../../../models/tournament/tournament_event.dart';
import '../../../models/user/user_profile.dart';

///PTMSController - PlayerTeamManagementScreenController
class PTPMSController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();
  final _apiClient = Get.find<ApiClient>();

  final payReasonCtrl = TextEditingController();
  final teamNameCtrl = TextEditingController();

  final cardNumberCtrl = TextEditingController();
  final yyCtrl = TextEditingController();
  final mmCtrl = TextEditingController();
  final csvCtrl = TextEditingController();
  final cardNameCtrl = TextEditingController();

  final payAmountCtrl = TextEditingController();
  final refNumberCtrl = TextEditingController();
  final remarkCtrl = TextEditingController();

  String teamCode = '';

  final tabList = ['', ''];
  int selectedTab = 0;

  final Tournament? tournament;
  final Payment? payment;
  String payReason = 'Tournament';
  String payReasonId = '';

  // String payer = '';
  // String payerType = '';
  String targetType = 'Player Team';
  String targetId = '';

  File attachment = File('');
  List<File> attachmentList = [];
  bool isAttachmentSelected = false;
  final List<ArtWork> attachments = [];

  final List<String> paymentMethods = ["Cash", "Card", "Bank Transfer", "Mobile Cash"], teamNames = [''], payReasons = ['Tournament'];
  String paymentMethode = 'Cash';
  List<PlayerTeam> playerTeams = [];
  late PlayerTeam playerTeam;

  // late PlayerProfiles playerProfiles;
  late List<PlayerProfile> playerProfiles;
  late PlayerProfile selectedPlayer;

  bool loading = false, isEnable = false;
  bool approveStatus = true;

  final List<String> paymentReasonTypes = ["Tournament", "Event", "Match"];
  String paymentReasonType = 'Tournament';

  int type = 0;

  late List<TournamentEvent> tEvents;
  late TournamentEvent tEvent;
  late List<EventMatch> eventMatches;
  late EventMatch eventMatch;

  late String trace;

  PTPMSController({required this.tournament, required this.payment});

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void onReady() {
    _loadingData();
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _loadReady(HashMap<String, bool> executeList) {
    if (executeList['api_01'] == true && executeList['api_02'] == true && executeList['api_03'] == true && executeList['api_04'] == true && executeList['api_05'] == true) {
      loading = true;

      if (payment != null) {
        Log.i(payment!.toJson());
        trace = payment!.trace;
        payReason = payment!.payReason;
        payReasonId = payment!.payReasonId;
        targetId = payment!.targetId;
        // payReasonCtrl.text = payment!.payReasonId;
        // teamNameCtrl.text = payment!.targetId;
        attachments.clear();
        attachments.addAll(payment!.attachments);
        paymentMethode = payment!.payMethode;
        payAmountCtrl.text = payment!.payAmount.toString();
        refNumberCtrl.text = payment!.refNumber;
        remarkCtrl.text = payment!.remark;
        if (payment!.approveStatus == 'Approved') {
          approveStatus = true;
        } else {
          approveStatus = false;
        }
      } else {
        trace = Generator.getRandomString(8);
      }
      update(['tab', true]);
      // update(['paymentReasonType', true]);
    }
  }

  void _loadingData() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;
            executeList['api_02'] = false;
            executeList['api_03'] = true;
            executeList['api_04'] = true;
            executeList['api_05'] = true;

            // payer = session.userName;
            // payerType = session.role;

            if (payment != null) {
              if (payment!.payReason == 'Tournament') {
                //
                payReasons.clear();
                payReasons.add(tournament!.name);
                payReasonCtrl.text = tournament!.name;
                payReasonId = tournament!.id;
                executeList['api_02'] = true;
                //
              } else if (payment!.payReason == 'Event') {
                //
                _apiClient.getEventsByTournamentId(tournament!.id, 'Enable', session.token).then((result) {
                  if (result!['status'].toString() == '200') {
                    // Log.w(statusSponsor['sponsors']);

                    tEvents = result['t_events'] as List<TournamentEvent>;

                    payReasons.clear();
                    for (var event in tEvents) {
                      tEvent = event;
                      payReasons.add(event.eventName);
                    }

                    executeList['api_02'] = true;
                  } else if (result['status'].toString() == '404') {
                    executeList['api_02'] = true;
                    Log.w('No team data');
                  }
                }).catchError((onError) {
                  Toaster.showErrorToast(onError.toString());
                }).whenComplete(() => _loadReady(executeList));
                //
              } else if (payment!.payReason == 'Match') {
                //
                _apiClient.getEventMatchesByTournamentId(tournament!.id, 'All', session.token).then((statusOrg) {
                  if (statusOrg!['status'].toString() == '200') {
                    eventMatches = (statusOrg['event_matches']) as List<EventMatch>;

                    payReasons.clear();
                    for (var match in eventMatches) {
                      eventMatch = match;
                      payReasons.add(match.name);
                    }
                    executeList['api_02'] = true;
                  } else if (statusOrg['status'].toString() == '404') {
                    Log.w('Events not found');
                    executeList['api_02'] = true;
                  }
                }).catchError((onError) {
                  Log.e(onError);
                  Toaster.showErrorToast(onError.toString());
                }).whenComplete(() => update(['payReason', true]));
                //
              }
              //
              if (payment!.targetType == 'Player Team') {
                _apiClient.getTRegisteredPlayerTeamsByTId(tournament!.id, 'Enable', session.token).then((result) {
                  if (result!['status'].toString() == '200') {
                    // Log.w(statusSponsor['sponsors']);

                    playerTeams = result['playerTeams'] as List<PlayerTeam>;

                    teamNames.clear();
                    for (var pTeam in playerTeams) {
                      playerTeam = pTeam;
                      teamNames.add(pTeam.name);
                    }

                    teamNameCtrl.text = playerTeams
                        .where((team) {
                          final id = team.id;
                          final input = payment!.targetId;

                          return id == (input);
                        })
                        .toList()
                        .first
                        .name;

                    executeList['api_01'] = true;
                  } else if (result['status'].toString() == '404') {
                    executeList['api_01'] = true;
                    Log.w('No team data');
                  }
                }).catchError((onError) {
                  Toaster.showErrorToast(onError.toString());
                }).whenComplete(() => _loadReady(executeList));
              }
            } else {
              executeList['api_01'] = true;
              executeList['api_02'] = true;
              executeList['api_03'] = true;
              _loadReady(executeList);
            }
          }
        }).catchError((onError) {
          Toaster.showErrorToast(onError.toString());
        });
      });
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }

  Widget _showLoaderDialog(BuildContext context) {
    // BuildContext dialogContext;
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Center(
            child: Container(
              color: Colors.transparent,
              height: height * 0.2,
              width: width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SpinKitFadingCircle(color: Colors.greenAccent, size: 50),
                  SizedBox(width: 10),
                  Text("Saving..."),
                ],
              ),
            ),
          );
        },
      ),
    );
    showDialog(
      context: context,
      builder: (context) {
        // dialogContext = context;
        return alert;
      },
    );

    return alert;
  }

  Future<File> pickAttachment() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      // Log.i('select');
      isAttachmentSelected = true;
      return File(pickedFile.path);
    } else {
      isAttachmentSelected = false;
      getImageFileFromAssets('images/01.jpg');
    }
    // update();
    return File('');
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    // update();
    return file;
  }

  set setAttachment(File value) {
    attachment = value;
    attachments.removeWhere((element) => element.url == attachment.path);
    attachments.add(ArtWork('', '', attachment.path, attachment.path));
    attachmentList.removeWhere((element) => element.path == attachment.path);
    attachmentList.add(attachment);
    Log.i(attachmentList.length);
    update();
  }

  void removeArtWork(int index) {
    try {
      attachments.removeAt(index);
      attachmentList.removeAt(index);
      // update(['tFDs', true]);
      update();
    } catch (e) {
      Log.e(e);
    }
  }

  void selectTeamType(String value) {
    paymentMethode = value;
    update(['payMethod', true]);
    // update();
  }

  void selectPayReasonType(String value) {
    paymentReasonType = value;
    if (value == 'Tournament') {
      payReasons.clear();
      payReasons.add(tournament!.name);
    } else if (value == 'Event') {
      getAllEventsByTournament();
    } else if (value == 'Match') {
      getAllEventMatchesByTournamentId();
    }

    getTRegisteredPlayerTeamsByTId();

    update(['paymentReasonType', true]);
  }

  void onChangeStatus(bool value) {
    approveStatus = value;
    update(['approveStatus', true]);
  }

  Future<List<ArtWork>> uploadAttachments(String prefix) async {
    final List<ArtWork> uAttachments = [];
    try {
      if (attachments.isNotEmpty) {
        for (var attachment in attachmentList) {
          Log.i(attachment.path);
          await _apiClient.uploadPaymentAttachment(attachment, trace, prefix).then((result) {
            uAttachments.add(ArtWork('', result['id']!, result['id']!, result['url']!));
          });
        }
      }
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }

    return uAttachments;
  }

  void makePayment(BuildContext context) {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            if (payment == null) {
              uploadAttachments('pay_attach').then((uAttachments) {
                final payment = Payment('', double.parse(payAmountCtrl.text), paymentMethode, session.role, session.id, targetType, targetId, refNumberCtrl.text, uAttachments, payReason,
                    payReasonId, remarkCtrl.text, trace, approveStatus ? 'Approved' : 'Not Approved', '', '');

                _apiClient.getUserProfileById(session.id, 'Enable', session.token).then((value) {
                  if (value!['status'].toString() == '200') {
                    Log.i('Call');

                    final userProfile = value['user_profile'] as UserProfile;

                    _apiClient.makePaymentFromAssignedPlayers({"trxId": Generator.getRandomString(20), "payerId": userProfile.mobile, "amount": "20"}, session.token).then((value) {
                      if (value['status'].toString() == '200') {
                        Log.i('Payed');
//
                        _apiClient.makeTournamentPayment(payment, session.token).then((paymentResult) {
                          if (paymentResult['status'].toString() == '201') {
                            Get.back();
                          }
                        }).catchError((onError) {
                          Log.e(onError);
                          Toaster.showErrorToast(onError.toString());
                        });
                      }
                    }).catchError((error) {
                      Toaster.showErrorToast(error);
                    });
                  }
                }).catchError((onError) {
                  Toaster.showErrorToast(onError);
                });
              }).onError((error, stackTrace) {
                Log.e(error);
                Toaster.showErrorToast(error.toString());
              });
            } else {
              uploadAttachments('pay_attach').then((uAttachments) {
                attachments.addAll(uAttachments);

                final paymentU = Payment(payment!.id, double.parse(payAmountCtrl.text), paymentMethode, session.role, session.id, targetType, targetId, refNumberCtrl.text, attachments, payReason,
                    payReasonId, remarkCtrl.text, trace, approveStatus ? 'Approved' : 'Not Approved', '', '');

                _apiClient.updateTournamentPayment(paymentU, payment!.id, session.token).then((paymentResult) {
                  if (paymentResult['status'].toString() == '200') {
                    Get.back();
                  }
                }).catchError((onError) {
                  Log.e(onError);
                  Toaster.showErrorToast(onError.toString());
                });
              }).onError((error, stackTrace) {
                Log.e(error);
                Toaster.showErrorToast(error.toString());
              });
            }
          }
        }).catchError((onError) {
          Log.e(onError);
          Toaster.showErrorToast(onError.toString());
        });
      });
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }

  void getAllEventsByTournament() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            _apiClient.getEventsByTournamentId(tournament!.id, 'All', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                tEvents = (statusOrg['t_events']) as List<TournamentEvent>;

                payReasons.clear();
                for (var event in tEvents) {
                  tEvent = event;
                  payReasons.add(event.eventName);
                }

                //
                // Log.w(tEvents.events.first.toJson());
                //
                // eventNameList.clear();
                // eventNameList.add('None');
                // for (var event in tEvents.events) {
                //   eventNameList.add(event.eventName);
                // }
              } else if (statusOrg['status'].toString() == '404') {
                Log.w('Events not found');
              }
            }).catchError((onError) {
              Log.e(onError);
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(() => update(['payReason', true]));
          }
        }).catchError((onError) {
          Log.e(onError);
          Toaster.showErrorToast(onError.toString());
        });
      });
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }

  void getAllEventMatchesByTournamentId() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            _apiClient.getEventMatchesByTournamentId(tournament!.id, 'All', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                eventMatches = (statusOrg['event_matches']) as List<EventMatch>;

                payReasons.clear();
                for (var match in eventMatches) {
                  eventMatch = match;
                  payReasons.add(match.name);
                }
              } else if (statusOrg['status'].toString() == '404') {
                Log.w('Events not found');
              }
            }).catchError((onError) {
              Log.e(onError);
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(() => update(['payReason', true]));
          }
        }).catchError((onError) {
          Log.e(onError);
          Toaster.showErrorToast(onError.toString());
        });
      });
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }

  void getTRegisteredPlayerTeamsByTId() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            _apiClient.getTRegisteredPlayerTeamsByTId(tournament!.id, 'Enable', session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                playerTeams = result['playerTeams'] as List<PlayerTeam>;

                teamNames.clear();
                for (var pTeam in playerTeams) {
                  playerTeam = pTeam;
                  teamNames.add(pTeam.name);
                }
              } else if (result['status'].toString() == '404') {
                Log.w('No team data');
              }
            }).catchError((onError) {
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(() => update(['targetTeam', true]));
          }
        }).catchError((onError) {
          Log.e(onError);
          Toaster.showErrorToast(onError.toString());
        });
      });
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }

  void getReasonId(String reason) {
    try {
      if ('Tournament' == paymentReasonType) {
        payReasonId = tournament!.id;
      } else if ('Event' == paymentReasonType) {
        payReasonId = tEvents
            .where((game) {
              final name = game.eventName;
              final input = reason;

              return name == (input);
            })
            .toList()
            .first
            .id;
      } else if ('Match' == paymentReasonType) {
        payReasonId = eventMatches
            .where((game) {
              final name = game.name;
              final input = reason;

              return name == (input);
            })
            .toList()
            .first
            .id;
      }
      // Log.i(payReasonId);
      update(['paymentReasonType', true]);
    } catch (e) {
      Log.e(e);
    }
  }

  void getTargetId(String target) {
    try {
      playerTeam = playerTeams
          .where((team) {
            final name = team.name;
            final input = target;

            return name == input;
          })
          .toList()
          .first;
      targetId = playerTeam.id;

      // Log.i(targetId);
      update(['targetTeam', true]);
    } catch (e) {
      Log.e(e);
    }
  }
}
