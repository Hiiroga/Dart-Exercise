# Dokumentasi Projekt: nama_pro

## Ringkasan
Proyek Flutter `nama_pro` adalah aplikasi pembelajaran dengan implementasi:
- Halaman profil mahasiswa dengan status TOEFL
- Navigasi PageView dengan bottom navigation
- ListView dengan form dialog untuk menambah data
- Arsitektur modular dan scalable

## Struktur Proyek

```
lib/
├── constants/
│   ├── app_colors.dart          # Definisi warna aplikasi
│   ├── app_strings.dart         # String konstanta
│   ├── app_dimensions.dart      # Ukuran & spacing
│   └── constants.dart           # Index file
│
├── models/
│   ├── student.dart             # Model data mahasiswa
│   ├── toefl_score.dart         # Model skor TOEFL
│   ├── tech_stack.dart          # Model tech stack
│   ├── product.dart             # Model produk (untuk networking)
│   └── models.dart              # Index file
│
├── screens/
│   ├── home_screen.dart         # Halaman utama
│   ├── tutorial_11_1_screen.dart    # PageView dengan bottom nav
│   ├── tutorial_11_2_screen.dart    # ListView + form dialog
│   └── screens.dart             # Index file
│
├── widgets/
│   ├── student_profile_header.dart  # Header profil
│   ├── toefl_status_card.dart       # Kartu status TOEFL
│   ├── tech_stack_card.dart         # Kartu tech stack
│   ├── product_card.dart            # Kartu produk
│   └── widgets.dart             # Index file
│
└── main.dart                    # Entry point aplikasi
```

## Fitur Utama

### 1. Home Screen (`HomeScreen`)
- Menampilkan profil mahasiswa
- Status tes TOEFL dengan skor
- Navigasi ke Tutorial 11-1
- Menggunakan custom widgets: `StudentProfileHeader`, `ToeflStatusCard`

### 2. Tutorial 11-1 Screen (`Tutorial11_1Screen`)
- PageView dengan 3 halaman
- Bottom Navigation Bar untuk navigasi
- Halaman 1: Home (kembali ke home screen)
- Halaman 2: Email (navigasi ke Tutorial 11-2)
- Halaman 3: Profile

### 3. Tutorial 11-2 Screen (`Tutorial11_2Screen`)
- ListView menampilkan data tech stack
- Floating Action Button untuk menambah data
- Dialog form untuk input data baru
- Detail dialog untuk melihat informasi lengkap
- Dropdown untuk memilih warna

## Konvensi Kode

### Naming Conventions
```dart
// Classes - PascalCase
class HomeScreen extends StatefulWidget { }

// Variables & functions - camelCase
int currentIndex = 0;
void displayData() { }

// Constants - camelCase dengan prefix App
const String appTitle = 'ABP Minggu 11';
const Color primaryColor = Colors.blue;

// Files - snake_case
home_screen.dart
toefl_status_card.dart
app_colors.dart
```

### Import Organization
```dart
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
```

## Navigation

Routes yang tersedia:
```dart
'/home'           → HomeScreen
'/tutorial_11_1'  → Tutorial11_1Screen (PageView)
'/tutorial_11_2'  → Tutorial11_2Screen (ListView)
```

Navigasi contoh:
```dart
// Push ke halaman baru
Navigator.pushNamed(context, '/tutorial_11_1');

// Pop ke halaman sebelumnya
Navigator.pop(context);
```

## Data Models

### Student
```dart
Student(
  id: 1,
  name: 'Nama Mahasiswa',
  studentId: '103012330011',
  email: 'email@telkomuniversity.ac.id',
)
```

### ToeflScore
```dart
ToeflScore(
  listening: 80,
  structure: 80,
  reading: 90,
  total: 250,
  status: 'LULUS',
)
```

### TechStack
```dart
TechStack(
  title: 'Native App',
  platform: 'Android, iOS',
  lang: 'Java, Kotlin, Swift, C#',
  color: Colors.red,
)
```

## Warna & Styling

Semua warna didefinisikan di AppColors:
```dart
AppColors.primaryBlue        // Warna biru utama
AppColors.primaryDarkBlue    // Warna biru gelap
AppColors.backgroundWhite    // Warna latar putih
AppColors.textDark           // Warna teks gelap
AppColors.successGreen       // Warna hijau kesuksesan
```

Semua ukuran & spacing di `AppDimensions`:
```dart
AppDimensions.paddingLarge   // Padding besar
AppDimensions.fontSizeXXLarge // Ukuran font besar
AppDimensions.radiusMedium   // Border radius medium
```

## Cara Menambah Fitur Baru

### 1. Tambah Screen Baru
```dart
// 1. Buat file di lib/screens/nama_screen.dart
class NamaScreen extends StatefulWidget {
  const NamaScreen({Key? key}) : super(key: key);

  @override
  State<NamaScreen> createState() => _NamaScreenState();
}

class _NamaScreenState extends State<NamaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nama')),
      body: const Center(child: Text('Konten')),
    );
  }
}

// 2. Export di screens.dart
export 'nama_screen.dart';

// 3. Tambah route di main.dart
'/nama': (context) => const NamaScreen(),
```

### 2. Tambah Widget Reusable
```dart
// 1. Buat file di lib/widgets/nama_widget.dart
class NamaWidget extends StatelessWidget {
  final String title;

  const NamaWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(title));
  }
}

// 2. Export di widgets.dart
export 'nama_widget.dart';

// 3. Gunakan di screen
NamaWidget(title: 'Contoh')
```

### 3. Tambah Model Baru
```dart
// 1. Buat file di lib/models/nama.dart
class Nama {
  final int id;
  final String name;

  const Nama({required this.id, required this.name});

  factory Nama.fromJson(Map<String, dynamic> json) {
    return Nama(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

// 2. Export di models.dart
export 'nama.dart';
```

## Persiapan untuk Networking (Tutorial 12)

Untuk menambah fitur networking ke Laravel backend:

### 1. Update pubspec.yaml
```yaml
dependencies:
  http: ^1.1.0
```

### 2. Buat service untuk API
```dart
// lib/utils/api_service.dart
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://IP_ADDRESS:8000/api';

  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/product'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['list'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data');
    }
  }
}
```

### 3. Buat screen untuk networking
```dart
// lib/screens/product_list_screen.dart
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = ApiService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produk')),
      body: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ProductCard(product: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
```

## Android Permissions (untuk networking)

Tambah ke `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

## Testing

### Test Routing
1. Jalankan aplikasi: `flutter run`
2. Buka halaman home
3. Klik "Go to Tutorial 11-1"
4. Gunakan bottom navigation untuk berpindah antar halaman
5. Di halaman email, klik tombol untuk pergi ke Tutorial 11-2
6. Di Tutorial 11-2, tambah data baru dengan FAB

### Test Data Consistency
1. Tambah data di Tutorial 11-2
2. Navigasi ke halaman lain
3. Kembali ke Tutorial 11-2
4. Verifikasi data masih ada

## Checklist Development

- [ ] Struktur folder modular
- [ ] Constants untuk semua hardcoded value
- [ ] Reusable widgets
- [ ] Multiple screens dengan navigation
- [ ] Data models dengan JSON serialization
- [ ] Clean code dan naming convention
- [ ] Error handling & validation
- [ ] State management (Provider/Riverpod)
- [ ] Networking integration
- [ ] Unit testing
- [ ] UI testing
- [ ] Performance optimization

## Troubleshooting

### Import errors
```dart
// Pastikan menggunakan path relatif yang benar
import '../constants/constants.dart';  // ✓ Benar
import 'package:nama_pro/constants/constants.dart';  // ✓ Juga benar
```

### Navigation errors
```dart
// Pastikan route sudah terdaftar di main.dart
// Gunakan trailing slash jika diperlukan
Navigator.pushNamed(context, '/tutorial_11_1');
```

### Widget not updating
```dart
// Gunakan setState() untuk StatefulWidget
setState(() {
  data.add(newItem);
});
```

## Referensi

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language](https://dart.dev)
- [Material Design](https://material.io/design)

## Notes

- Proyek mengikuti Material Design 3
- Menggunakan named routes untuk navigasi
- Semua hardcoded value sudah di-extract ke constants
- Widgets sudah di-modularkan untuk reusability
- Siap untuk menambah networking dan state management

---

**Last Updated:** Mei 2026
**Version:** 1.0.0
