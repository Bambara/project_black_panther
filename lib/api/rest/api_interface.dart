class ApiInterface {
  //User
  static const String userSignup = '/api/v1/user/signup';
  static const String generalLogin = '/api/v1/user/signing';
  static const String getUserProfileById = '/api/v1/user/getUserById';
  static const String updateUserProfile = '/api/v1/user/update';
  static const String removeFreshUser = '/api/v1/user/id/';

  //Organizer
  static const String createOrganizerProfile = '/api/v1/organizer/create';
  static const String updateOrganizerProfile = '/api/v1/organizer/update';
  static const String getOrganizerProfileByUserId = '/api/v1/organizer/';

  //Player
  static const String getPlayerProfileByUserId = '/api/v1/player/profile/user_id/';

  //Organization
  static const String getAllOrganizations = '/api/v1/organization/';
  static const String getOrganizationsByType = '/api/v1/organization/type';
  static const String getOrganizationByName = '/api/v1/organization/name';
  static const String getOrganizationByIdList = '/api/v1/organization/ids';
  static const String createOrganization = '/api/v1/organization/create';

  //Sponsor
  static const String getAllSponsors = '/api/v1/sponsor/status';
  static const String getSponsorByIdList = '/api/v1/sponsor/ids';

  //Game
  static const String getAllGames = '/api/v1/game/';
  static const String getAllGamesByIdList = '/api/v1/game/ids';

  //Tournament
  static const String createTournament = '/api/v1/tournament/create';
  static const String updateTournament = '/api/v1/tournament/update';
  static const String getTournamentsByTCMemberId = '/api/v1/tournament/tc_member/id';
  static const String registerPlayerTeam = '/api/v1/tournament/team/registration';
  static const String getTRegPlayerTeams = '/api/v1/tournament/teams/tournament_id';
  static const String updatePlayerTeam = '/api/v1/tournament/team/update';
  static const String getAllTCTeamsByTId = '/api/v1/tournament/tc_team/t_id/';

  //Tournament Event
  static const String createTournamentEvent = '/api/v1/events/create';
  static const String getEventsByTId = '/api/v1/events/tournament_id';
  static const String assignPlayerTeamsToEvent = '/api/v1/events/player_team/assign/';
  static const String sendSMSToAssignPlayers = '/api/v1/mspace/sms/send/';
  static const String makePaymentFromAssignPlayers = '/api/v1/mspace/caas/direct/debit/';
  static const String resignPlayerTeamsToEvent = '/api/v1/events/player_team/resign/';
  static const String assignPlayerTeamsToEventList = '/api/v1/events/player_team/assign/event_list';
  static const String getAssignPlayerTeamsByPtlId = '/api/v1/events/player_team/ptl_id/';
  static const String getEventAssignedAllPlayerTeamsByTeId = '/api/v1/events/player_team/te_id/';

  //Event Matches
  static const String getAllMatchesByEventId = '/api/v1/matches/te_id/';
  static const String getAllMatchesByTournamentId = '/api/v1/matches/t_id/';

  //Player
  static const String getAllTNotRegPlayers = '/api/v1/player/tournament/register/not';
  static const String getAllTRegPlayers = '/api/v1/player/tournament/register/yes';

  ///Payments
  ///
  ///Make player team payment
  static const String makeTournamentPayment = '/api/v1/payment/pay/';
  static const String updateTournamentPayment = '/api/v1/payment/update/';
  static const String getTournamentPayments = '/api/v1/payment/';
  static const String deleteTournamentPayment = '/api/v1/payment/';
}
