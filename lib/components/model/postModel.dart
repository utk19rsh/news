class Post {
  Post({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });
  final String name, email, body;
  final int id, postId;

  factory Post.fromJson({
    required int id,
    required String name,
    required String email,
    required String body,
    required int postId,
  }) {
    return Post(
      id: id,
      name: name,
      body: body,
      email: email,
      postId: postId,
    );
  }
}
