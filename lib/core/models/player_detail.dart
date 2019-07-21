/// Player detail model
class PlayerDetail {
  /// User id
  int accountId;

  /// Date when player's account was created
  DateTime createdAt;

  /// Indicates if the game profile is hidden
  bool hiddenProfile;

  /// Player's karma
  /// Warning: The field will be disabled.
  int karma;

  /// Last battle time
  DateTime lastBattleTime;

  /// Service Record level
  int levelingPoints;

  /// Service Record points
  int levelingTier;

  /// End time of last game session
  DateTime logoutAt;

  /// Player name
  String nickname;

  /// Date when stats for player and player's ships were updated
  DateTime statsUpdatedAt;

  /// Date when player details were updated
  DateTime updatedAt;

  /// Player statistics
  Statistics statistics;

  /// Serializing JSON inside player detail model
  PlayerDetail.fromJSON(Map<String, dynamic> json) {
    accountId = json['account_id'];
    createdAt = json['created_at'];
    hiddenProfile = json['hidden_profile'];
    karma = json['karma'];
    lastBattleTime = json['last_battle_time'];
    levelingPoints = json['leveling_points'];
    levelingTier = json['leveling_tier'];
    logoutAt = json['logout_at'];
    nickname = json['nickname'];
    statsUpdatedAt = json['stats_updated_at'];
    updatedAt = json['updated_at'];
    statistics = Statistics.fromJSON(json['statistics']);
  }

  /// Mapping player model to JSON
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'account_id': accountId,
        'created_at': createdAt,
      };
}

/// Player statistics
class Statistics {
  /// Battles fought
  int battles;

  /// Miles travelled
  int distance;

  /// Serializing JSON inside statistics model
  Statistics.fromJSON(Map<String, dynamic> json) {
    battles = json['battles'];
    distance = json['distance'];
  }
}
