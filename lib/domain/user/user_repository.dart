import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fireblog_test/domain/user/user.dart';
import 'package:fireblog_test/domain/user/user_provider.dart';

class UserRepository {
  UserProvider _userProvider = UserProvider();

  Future<void> logout() async => await FirebaseAuth.instance.signOut();

  Future<User> login(String email, String password) async {
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } catch (e) {

    }

    if (userCredential != null) {
      QuerySnapshot querySnapshot = await _userProvider.login(userCredential.user!.uid);
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      if (docs.length > 0) {
        User principal = User.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>
        );
        return principal;
      }
    }
    return User();
  }

  Future<User> join(String email, String password, String username) async {
    UserCredential? userCredential;
    try {
      userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Create 실패 시 익셉션 일어남
    }

    if (userCredential != null) {
      User principal = User(
        uid: "${userCredential.user!.uid}",
        email: userCredential.user!.email,
        username: username,
        created: userCredential.user!.metadata.creationTime,
        updated: userCredential.user!.metadata.creationTime,
      );
      //FireStore에 인서트 : 서비스 시 따로 관리해야할 정보가 필요 시 별도의 DB에 저장해서 관리!
      await _userProvider.join(principal);
      return principal;
    } else {
      return User();
    }
  }

  //중복체크용
  Future<int> checkEmail(String email) async {
    QuerySnapshot querySnapshot = await _userProvider.checkEmail(email);
    return querySnapshot.docs.length > 0 ? -1 : 1;
  }

  //중복체크용
  Future<int> checkUsername(String username) async {
    QuerySnapshot querySnapshot = await _userProvider.checkUsername(username);
    return querySnapshot.docs.length > 0 ? -1 : 1;
  }
}