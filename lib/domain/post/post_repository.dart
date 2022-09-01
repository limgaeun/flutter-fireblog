import 'package:fireblog_test/controller/user_controller.dart';
import 'package:fireblog_test/domain/post/post.dart';
import 'package:fireblog_test/domain/post/post_provider.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository{
  UserController u = Get.find<UserController>();
  final PostProvider _postProvider = PostProvider();

  Future<List<Post>> findAll() async {
    QuerySnapshot querySnapshot = await _postProvider.findAll();
    List<Post> posts = querySnapshot.docs.map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return posts;
  }

  Future<Post> save(String title, String content) async {
    DocumentSnapshot result = await _postProvider.save(title, content);
    return Post.fromJson(result.data() as Map<String, dynamic>);
  }

  Future<Post> findById(String id) async {
    DocumentSnapshot result = await _postProvider.findById(id);
    return result.data() == null
        ? Post()
        : Post.fromJson(result.data() as Map<String, dynamic>);
  }

  Future<int> updateById(String id, String title, String content) async {
    await _postProvider.updateById(id, title, content);
    Post post = await findById(id);
    return post.title == title && post.content == content ? 1 : -1;
  }

  Future<int> deleteById(String id) async {
    await _postProvider.deleteById(id);
    Post post = await findById(id);
    return post.id == null ? 1 : -1;
  }
}