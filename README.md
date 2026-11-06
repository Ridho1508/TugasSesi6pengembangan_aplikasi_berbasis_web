# NusaInfo

NusaInfo adalah aplikasi Flutter untuk menampilkan informasi dan pengumuman kampus.
Data diambil dari internet menggunakan package `http` dan API
[JSONPlaceholder](https://jsonplaceholder.typicode.com).

> **Catatan data:** Data pengumuman berasal dari JSONPlaceholder, sebuah API contoh
> yang isinya berupa teks lorem ipsum (bahasa Latin). Karena API tidak menyediakan
> kategori dan tanggal, kategori (Akademik, Event, Umum) ditentukan dari `userId`
> dan waktu publikasi ("1 jam lalu") dihitung dari `id` hanya untuk keperluan tampilan.
> Data baru yang dikirim lewat POST hanya disimulasikan oleh API dan tidak benar-benar
> tersimpan, sehingga tidak muncul di daftar setelah refresh.

## Fitur

- Daftar pengumuman dari `GET /posts` dengan loading, pesan error, dan tombol "Coba Lagi".
- Tarik layar ke bawah untuk memuat ulang data (`RefreshIndicator`).
- Pencarian berdasarkan judul dan isi pengumuman.
- Filter kategori: Semua, Akademik, Event.
- Detail pengumuman beserta daftar komentar dari `GET /posts/{id}/comments`.
- Tambah pengumuman lewat form dengan validasi (`GlobalKey`) dan `POST /posts`.
- `SnackBar` ditampilkan di Home setelah pengumuman berhasil dibuat.
- Tampilan kosong, tidak ditemukan, dan error saat internet mati.
- Tombol tambah hanya tampil untuk admin (parameter `isAdmin` pada `HomeScreen`).

## Struktur Folder

```
lib/
├── main.dart
├── models/
│   └── post.dart
├── services/
│   └── post_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   └── add_post_screen.dart
├── theme/
│   └── app_theme.dart
└── widgets/
    ├── post_card.dart
    ├── search_field.dart
    ├── category_filter.dart
    └── state_message.dart
```

## Cara Menjalankan

```
flutter pub get
flutter run
```

## Screenshot

### Halaman Utama

| Home Screen | Detail Screen | Add Post Screen |
|---|---|---|
| ![Home](screenshots/home.png) | ![Detail](screenshots/detail.png) | ![Add](screenshots/add.png) |

### Kondisi Khusus

| Error Internet Mati | SnackBar Berhasil |
|---|---|
| ![Error](screenshots/error.png) | ![SnackBar](screenshots/snackbar.png) |

### Tambahan

| Pencarian | Filter Event | Tidak Ditemukan | Validasi Form |
|---|---|---|---|
| ![Pencarian](screenshots/search.png) | ![Event](screenshots/filter_event.png) | ![Kosong](screenshots/not_found.png) | ![Validasi](screenshots/validation.png) |

## Pembuat

Ridho Safutra - TI24G Software Engineering, Universitas Nusa Putra