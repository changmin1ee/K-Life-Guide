class ApiEndpoints {
  // Auth
  static const String googleLogin = '/api/auth/google';
  static const String logout = '/api/auth/logout';

  // Member
  static const String myProfile = '/api/members/me';
  static const String myLanguage = '/api/members/me/language';

  // Home
  static const String home = '/api/home';

  // Mission
  static const String missions = '/api/missions';
  static String missionDetail(int id) => '/api/missions/$id';
  static String startMission(int id) => '/api/missions/$id/start';
  static String completeMission(int id) => '/api/missions/$id/complete';
  static const String myMissions = '/api/members/me/missions';
  static const String myCompletedMissions = '/api/members/me/missions/completed';

  // Community
  static const String posts = '/api/posts';
  static String postDetail(String id) => '/api/posts/$id';
  static String postReplies(String id) => '/api/posts/$id/replies';
  static String likePost(String id) => '/api/posts/$id/like';
  static String solvePost(String id) => '/api/posts/$id/solve';
  static const String myPosts = '/api/members/me/posts';

  // Phrase
  static const String phrases = '/api/phrases';
  static String savePhrase(int id) => '/api/phrases/$id/save';
  static const String mySavedPhrases = '/api/members/me/phrases/saved';

  // Roadmap
  static const String roadmap = '/api/roadmap';
  static String toggleRoadmap(int id) => '/api/roadmap/$id/toggle';

  // Reward
  static const String myBadges = '/api/members/me/badges';
  static const String myPointHistory = '/api/members/me/points/history';
  static const String myPassport = '/api/members/me/passport';
}
