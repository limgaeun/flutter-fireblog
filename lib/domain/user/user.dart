class User {
  final String? uid;
  final String? username;
  final String? email;
  final DateTime? created;
  final DateTime? updated;

  User({
    this.uid,
    this.username,
    this.email,
    this.created,
    this.updated,
  });

  User.fromJson(Map<String, dynamic> json)
    : uid = json['uid'],
      username = json['username'],
      email = json['email'],
      created = json['created'].toDate(),
      updated = json['updated'].toDate();

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'username' : username,
    'email' : email,
    'created' : created,
    'updated' : updated,
  };
}