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
| ![Home]<img width="407" height="758" alt="image" src="https://github.com/user-attachments/assets/4eb8bef0-efa6-4f34-9ae0-d1ea0496e3de" />
 | ![Detail]<img width="409" height="755" alt="image" src="https://github.com/user-attachments/assets/8552867b-4706-48ce-a04b-cee9003f5f09" />
 | ![Add] <img width="401" height="739" alt="image" src="https://github.com/user-attachments/assets/b053b9d3-bae6-4c1b-954e-ffa56d3dd5bc" />
 |

### Kondisi Khusus

| Error Internet Mati | SnackBar Berhasil |
|---|---|
| ![Error]<img width="401" height="694" alt="image" src="https://github.com/user-attachments/assets/39ae2060-1175-44bb-a3f0-dac11ea71c43" />
 | ![SnackBar]<img width="405" height="747" alt="image" src="https://github.com/user-attachments/assets/0882b0f2-58a3-4ee6-afd3-cffc922bcecf" />
 |

### Tambahan

| Pencarian | Filter Event | Tidak Ditemukan | Validasi Form |
|---|---|---|---|
| ![Pencarian]<img width="403" height="763" alt="image" src="https://github.com/user-attachments/assets/62bd37d3-284e-4b7c-8a2b-f9653ce9d6b0" />
 | ![Event]<img width="397" height="748" alt="image" src="https://github.com/user-attachments/assets/09ffa662-df3e-4cc1-9556-bb347472c22f" />


## Pembuat

Ridho Safutra - TI24G Software Engineering, Universitas Nusa Putra
