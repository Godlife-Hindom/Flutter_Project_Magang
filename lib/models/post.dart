
class Post {
  int? id;
  String? body;
  String? image;

  Post({
    this.id,
    this.body,
    this.image,
  });

// map json to post model

factory Post.fromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'],
    body: json['body'],
    image: json['image'],
  );
}
}