import '../config/drawer_item.dart';
import '../generated/assets.dart';

class DrawerItems {
  /*static final DrawerItem dashBoard = DrawerItem('Dashboard',  Assets.iconsLocation);
  static final DrawerItem tournaments = DrawerItem('Tournaments', Icons.sports_esports);
  static final DrawerItem newsFeed = DrawerItem('News Feed', Icons.newspaper);
  static final DrawerItem stream = DrawerItem('Stream', Icons.cast_connected);
  static final DrawerItem chat = DrawerItem('Chat', Icons.chat_outlined);
  static final DrawerItem shuffle = DrawerItem('Shuffle', FontAwesomeIcons.shuffle);
  static final DrawerItem scoreBoard = DrawerItem('Score Board', Icons.scoreboard);
  static final DrawerItem registration = DrawerItem('Registration', Icons.badge);
  static final DrawerItem pointSystem = DrawerItem('Point System', Icons.score);
  static final DrawerItem settings = DrawerItem('Settings', FontAwesomeIcons.gears);*/

  static final DrawerItem dashBoard = DrawerItem('Dashboard', Assets.iconsDashboard);
  static final DrawerItem tournaments = DrawerItem('Tournaments', Assets.iconsTournament);
  static final DrawerItem newsFeed = DrawerItem('News Feed', Assets.iconsNewsFeed);
  static final DrawerItem stream = DrawerItem('Stream', Assets.iconsStream);
  static final DrawerItem chat = DrawerItem('Chat', Assets.iconsChat);
  static final DrawerItem shuffle = DrawerItem('Shuffle', Assets.iconsShuffle);
  static final DrawerItem scoreBoard = DrawerItem('Score Board', Assets.iconsScoreboard);
  static final DrawerItem registration = DrawerItem('Registration', Assets.iconsBadge);
  static final DrawerItem pointSystem = DrawerItem('Point System', Assets.iconsPointSystem);
  static final DrawerItem settings = DrawerItem('Settings', Assets.iconsSettings);

  static final List<DrawerItem> all = [dashBoard, tournaments, newsFeed, stream, chat, shuffle, scoreBoard, registration, pointSystem, settings];
}
