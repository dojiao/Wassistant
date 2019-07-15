/// Player model
class Player {
  /// Player nickname
  String nickname;

  /// Player account id
  int accountId;

  /// Constructor
  Player(this.nickname, this.accountId);

  /// Serializing JSON inside player model
  Player.fromJSON(Map<String, dynamic> json) {
    nickname = json['nickname'];
    accountId = json['account_id'];
  }

  /// Mapping player model to JSON
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'account_id': accountId,
      };
}
