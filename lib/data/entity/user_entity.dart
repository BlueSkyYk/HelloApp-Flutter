class UserEntity {
  String qq;
  String realName;
  int gender;
  String phone;
  String nickname;
  int userId;
  String username;

  UserEntity(
      {this.qq,
      this.realName,
      this.gender,
      this.phone,
      this.nickname,
      this.userId,
      this.username});

  UserEntity.fromJson(Map<String, dynamic> json) {
    qq = json['qq'];
    realName = json['realName'];
    gender = json['gender'];
    phone = json['phone'];
    nickname = json['nickname'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qq'] = this.qq;
    data['realName'] = this.realName;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['nickname'] = this.nickname;
    data['userId'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}
