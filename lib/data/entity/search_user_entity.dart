class SearchUserEntity {
	int gender;
	String nickname;
	int userId;
	String username;

	SearchUserEntity({this.gender, this.nickname, this.userId, this.username});

	SearchUserEntity.fromJson(Map<String, dynamic> json) {
		gender = json['gender'];
		nickname = json['nickname'];
		userId = json['userId'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['gender'] = this.gender;
		data['nickname'] = this.nickname;
		data['userId'] = this.userId;
		data['username'] = this.username;
		return data;
	}
}
