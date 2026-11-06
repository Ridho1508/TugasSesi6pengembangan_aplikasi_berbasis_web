import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/post_service.dart';
import '../theme/app_theme.dart';
import '../widgets/category_filter.dart';
import '../widgets/post_card.dart';
import '../widgets/search_field.dart';
import '../widgets/state_message.dart';
import 'add_post_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  // Tombol tambah hanya tampil untuk admin.
  // Aplikasi ini belum punya login, jadi nilainya diatur dari sini.
  final bool isAdmin;
  const HomeScreen({super.key, this.isAdmin = true});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostService _service = PostService();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Post>> _postsFuture;

  String _query = '';
  PostCategory? _category; // null = Semua

  @override
  void initState() {
    super.initState();
    _postsFuture = _service.fetchPosts(); // dipanggil di initState, bukan build
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload() {
    setState(() {
      _postsFuture = _service.fetchPosts();
    });
  }

  Future<void> _refresh() async {
    final future = _service.fetchPosts();
    setState(() {
      _postsFuture = future;
    });
    try {
      await future;
    } catch (_) {
      // error ditampilkan oleh FutureBuilder
    }
  }

  void _resetFilter() {
    _searchController.clear();
    setState(() {
      _query = '';
      _category = null;
    });
  }

  Future<void> _openAddPost() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddPostScreen()),
    );
    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengumuman berhasil dibuat!')),
      );
    }
  }

  Widget _scrollableState(Widget child) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [SizedBox(height: 380, child: child)],
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot<List<Post>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 14),
            Text(
              'Memuat pengumuman...',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    if (snapshot.hasError) {
      final message =
          snapshot.error.toString().replaceFirst('Exception: ', '');
      return StateMessage(
        icon: Icons.wifi_off_rounded,
        title: 'Gagal memuat data',
        message: message,
        actionLabel: 'Coba Lagi',
        onAction: _reload,
      );
    }

    final posts = snapshot.data ?? [];
    if (posts.isEmpty) {
      return _scrollableState(
        const StateMessage(
          icon: Icons.campaign_outlined,
          title: 'Belum ada pengumuman',
          message: 'Pengumuman terbaru dari kampus akan muncul di sini.',
        ),
      );
    }

    final query = _query.trim().toLowerCase();
    final filtered = posts.where((p) {
      final matchCategory = _category == null || p.category == _category;
      final matchQuery = query.isEmpty ||
          p.title.toLowerCase().contains(query) ||
          p.body.toLowerCase().contains(query);
      return matchCategory && matchQuery;
    }).toList();

    if (filtered.isEmpty) {
      return _scrollableState(
        StateMessage(
          icon: Icons.search_off_rounded,
          title: 'Pengumuman tidak ditemukan',
          message: 'Coba kata kunci lain atau pilih kategori Semua.',
          actionLabel: 'Reset filter',
          onAction: _resetFilter,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
        itemCount: filtered.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                '${filtered.length} pengumuman',
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }
          final post = filtered[index - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PostCard(
              post: post,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailScreen(post: post)),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NusaInfo',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Informasi Kampus dalam Satu Genggaman',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),
                const SizedBox(height: 14),
                CategoryFilter(
                  selected: _category,
                  onChanged: (value) => setState(() => _category = value),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: FutureBuilder<List<Post>>(
                    future: _postsFuture,
                    builder: (context, snapshot) => _buildContent(snapshot),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              onPressed: _openAddPost,
              tooltip: 'Tambah pengumuman',
              child: const Icon(Icons.add_rounded, size: 28),
            )
          : null,
    );
  }
}