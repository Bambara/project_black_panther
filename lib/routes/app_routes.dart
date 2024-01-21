import 'package:get/get.dart';
import 'package:project_black_panther/views/user/account_section_screen.dart';

import '../core/utils/initial_bindings.dart';
import '../views/common/solo_list_screen.dart';
import '../views/init_screen.dart';
import '../views/organizer/event_add_screen.dart';
import '../views/organizer/event_dashboard.dart';
import '../views/organizer/events_list_screen.dart';
import '../views/organizer/oa_screen.dart';
import '../views/organizer/organizer_drawer_screen.dart';
import '../views/organizer/tournament/ptm_screen.dart';
import '../views/organizer/tournament/ptpm_screen.dart';
import '../views/organizer/tournament/tctm_screen.dart';
import '../views/organizer/tournament/tournament_add_screen.dart';
import '../views/organizer/tournament/tournament_dashboard.dart';
import '../views/organizer/tournament_list_screen.dart';
import '../views/player/pa_screen.dart';
import '../views/player/player_drawer_screen.dart';
import '../views/user/free_signup_screen.dart';
import '../views/user/login_screen.dart';
import '../views/user/otp_verify_screen.dart';
import '../views/user/premium_signup_screen.dart';
import '../views/user/signup_selection_screen.dart';
import 'bindings/ass_binding.dart';
import 'bindings/fss_binding.dart';
import 'bindings/ls_binding.dart';
import 'bindings/oas_binding.dart';
import 'bindings/ods_binding.dart';
import 'bindings/oeds_binding.dart';
import 'bindings/oels_binding.dart';
import 'bindings/oes_binding.dart';
import 'bindings/organizer/ptpms_binding.dart';
import 'bindings/organizer/tctms_binding.dart';
import 'bindings/otls_binding.dart';
import 'bindings/otps_binding.dart';
import 'bindings/ots_binding.dart';
import 'bindings/pds_binding.dart';
import 'bindings/player/pas_binding.dart';
import 'bindings/pss_binding.dart';
import 'bindings/ptms_binding.dart';
import 'bindings/sls_binding.dart';
import 'bindings/suss_binding.dart';
import 'bindings/tas_binding.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const routeName = '/';

  static List<GetPage> pages = [
    GetPage(
      name: initialRoute,
      page: () => const InitScreen(),
      binding: InitialBindings(),
    ),
    GetPage(
      name: '/loginScreen',
      page: () => const LoginScreen(),
      binding: LSBinding(),
    ),
/*    GetPage(
      name: "/loginScreen",
      page: () => const LoginScreen(),
      binding: LSBinding(),
    ),*/
    GetPage(
      name: "/accSelectScreen",
      page: () => const AccountSelectionScreen(),
      binding: ASSBinding(),
    ),
    GetPage(
      name: "/signupSelectScreen",
      page: () => const SignUpSelectionScreen(userType: ''),
      binding: SUSSBinding(),
    ),
    GetPage(
      name: "/premiumSignupScreen",
      page: () => const PremiumSignupScreen(),
      binding: PSSBinding(signupType: ''),
    ),
    GetPage(
      name: "/freeSignupScreen",
      page: () => const FreeSignupScreen(),
      binding: FSSBinding(signupType: ''),
    ),
    GetPage(
      name: "/organizerDrawerScreen",
      page: () => const OrganizerDrawerScreen(),
      binding: ODSBinding(),
    ),
    GetPage(
      name: "/playerDrawerScreen",
      page: () => const PlayerDrawerScreen(),
      binding: PDSBinding(),
    ),
    GetPage(
      name: "/organizerAccountScreen",
      page: () => const OAScreen(),
      binding: OASBinding(),
    ),
    GetPage(
      name: "/tournamentAddScreen",
      page: () => const TournamentAddScreen(),
      binding: TASBinding(tournament: null),
    ),
    GetPage(
      name: "/otlScreen",
      page: () => OTLScreen(openDrawer: () {}),
      binding: OTLSBinding(),
    ),
    GetPage(
      name: "/eventsListScreen",
      page: () => const EventsListScreen(),
      binding: OELSBinding(),
    ),
    GetPage(
      name: "/eventScreen",
      page: () => const EventAddScreen(),
      binding: OEASBinding(tournament: null),
    ),
    GetPage(
      name: "/otScreen",
      page: () => const OrganizerTournamentScreen(),
      binding: OTSBinding(tournament: null),
    ),
    GetPage(
      name: "/oeDashBoardScreen",
      page: () => const OrganizerEventDashboard(),
      binding: OEDSBinding(tEvent: null, clans: [], clubs: [], playerProfiles: [], playerTeams: []),
    ),
    GetPage(
      name: "/soloListScreen",
      page: () => const SoloListScreen(),
      binding: SLSBinding(tEvent: null),
    ),
    GetPage(
      name: "/ptmScreen",
      page: () => const PTMScreen(),
      binding: PTMSBinding(tournament: null, playerTeam: null),
    ),
    GetPage(
      name: "/tctmScreen",
      page: () => const TCTMScreen(),
      binding: TCTMSBinding(tournament: null, playerTeam: null),
    ),
    GetPage(
      name: "/ptpmScreen",
      page: () => const PTPMScreen(),
      binding: PTPMSBinding(tournament: null, payment: null),
    ),
    GetPage(
      name: "/otpScreen",
      page: () => const OPTVerifyScreen(),
      binding: OTPScreenBinding(userSignup: null, mobileNumber: '', openType: '', userType: ''),
    ),
    GetPage(
      name: "/playerAccountScreen",
      page: () => const PAScreen(),
      binding: PASBinding(),
    ),
  ];
}
