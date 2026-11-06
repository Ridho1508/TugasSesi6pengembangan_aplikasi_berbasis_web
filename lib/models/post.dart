enum PostCategory { akademik, event, umum }

class Post {
  final int? id;
  final int userId;
  final String title;
  final String body;

  Post({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}

// Properti tampilan. Tidak ikut dikirim ke API (tidak masuk toJson).
// JSONPlaceholder tidak punya kategori dan tanggal, jadi nilainya disimulasikan.
extension PostDisplay on Post {
  PostCategory get category {
    if (userId <= 3) return PostCategory.akademik;
    if (userId <= 6) return PostCategory.event;
    return PostCategory.umum;
  }

  String get displayTitle =>
      title.isEmpty ? title : title[0].toUpperCase() + title.substring(1);

  DateTime get publishedAt =>
      DateTime.now().subtract(Duration(minutes: 20 + (id ?? 0) * 95));

  String get timeAgo {
    final diff = DateTime.now().difference(publishedAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays < 7) return '${diff.inDays} hari lalu';
    return '${(diff.inDays / 7).floor()} minggu lalu';
  }
}