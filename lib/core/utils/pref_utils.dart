//ignore: unused_import
import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../models/user/logging_session.dart';
import 'log.dart';

class PrefUtils {
  // static SharedPreferences? _sharedPreferences;

  final _storedPreferences = GetStorage();
  bool _isInit = false;

  // initDatabase() async {
  //   await GetStorage.init();
  // }

  ///Preference Utility Class
  PrefUtils() {
    // SharedPreferences.getInstance().then((value) {
    //   _sharedPreferences = value;
    // });
    // if (_isInit == false) {
    //   init().then((value) {
    //     if (value) {
    //       Log.i('Stored Preference initialized');
    //     } else {
    //       Log.w('Stored Preference not initialized');
    //     }
    //   });
    // }
  }

  Future<bool> init() async {
    // _sharedPreferences ??= await SharedPreferences.getInstance();
    return _isInit = await GetStorage.init();
  }

  ///Store login session to local device
  ///
  ///Param : LoggingSession Object
  ///
  ///Return : Future<LoggingSession>
  Future<LoggingSession> storeLoggingSession(LoggingSession loggingSession) async {
    try {
      _storedPreferences.write('logging_session', loggingSession.toJson());

      Map<String, dynamic> sessionData = await _storedPreferences.read('logging_session');

      Log.i('Logging Session Created !');
      Log.i(sessionData);

      return LoggingSession.fromJson(sessionData);
    } catch (e) {
      Log.e(e);
      return LoggingSession('', '', '', '', '', '', '');
    }
  }

  ///Get local stored logging session
  ///
  ///Return : Future<LoggingSession>
  Future<LoggingSession> getLoggingSession() async {
    try {
      Map<String, dynamic> sessionData = await _storedPreferences.read('logging_session');
      if (sessionData.isEmpty) {
        return LoggingSession('', '', '', '', '', '', '');
      } else {
        return LoggingSession.fromJson(sessionData);
      }
    } catch (e) {
      Log.e(e);
      return LoggingSession('', '', '', '', '', '', '');
    }
  }

  Future<LoggingSession> storeTournament(LoggingSession loggingSession) async {
    try {
      _storedPreferences.write('logging_session', loggingSession.toJson());

      Map<String, dynamic> sessionData = await _storedPreferences.read('logging_session');

      Log.i('Logging Session Created !');
      Log.i(sessionData);

      return LoggingSession.fromJson(sessionData);
    } catch (e) {
      Log.e(e);
      return LoggingSession('', '', '', '', '', '', '');
    }
  }

  Future<void> destroySession() async {
    try {
      _storedPreferences.write('logging_session', LoggingSession('', '', '', '', '', '', '').toJson());
      Log.w('Logging Session Destroyed !');
    } catch (e) {
      Log.e(e);
    }
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _storedPreferences!.erase();
  }
}
