import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 10);

  // GET /posts
  Future<List<Post>> fetchPosts() async {
    final uri = Uri.parse('$_baseUrl/posts'); // 1. buat alamat
    try {
      final response = await http.get(uri).timeout(_timeout); // 2. kirim request
      if (response.statusCode == 200) { // 3. cek status code
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Post.fromJson(e)).toList(); // 4. JSON -> objek
      }
      throw Exception('Gagal memuat pengumuman (kode ${response.statusCode})');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on http.ClientException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    }
  }

  // GET /posts/{id}/comments
  Future<List<Map<String, dynamic>>> fetchComments(int postId) async {
    final uri = Uri.parse('$_baseUrl/posts/$postId/comments');
    try {
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      throw Exception('Gagal memuat komentar (kode ${response.statusCode})');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on http.ClientException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    }
  }

  // POST /posts
  Future<Post> createPost(Post post) async {
    final uri = Uri.parse('$_baseUrl/posts');
    try {
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(post.toJson()),
          )
          .timeout(_timeout);
      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      }
      throw Exception('Gagal membuat pengumuman (kode ${response.statusCode})');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on http.ClientException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    }
  }
}