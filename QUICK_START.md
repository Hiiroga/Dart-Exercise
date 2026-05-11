# Quick Start Guide - Exercise Dart

## Untuk Developer Baru

### Langkah 1: Setup Project
```bash
# Clone atau buka project
cd "d:\Semester 6\ABP\7.2\nama_pro"

# Get dependencies
flutter pub get

# Run aplikasi
flutter run
```

### Langkah 2: Understand Struktur
```
Buka folder lib/ untuk melihat:
- constants/   → Warna, string, ukuran
- models/      → Data structures
- screens/     → Halaman aplikasi
- widgets/     → Komponen reusable
- main.dart    → Entry point
```

### Langkah 3: Navigasi Aplikasi
```
Home Screen
  ↓ (Button "Go to Tutorial 11-1")
Tutorial 11-1 (PageView)
  ├─ Bottom Nav untuk switch halaman
  └─ Page 2 ke Tutorial 11-2
      ↓
Tutorial 11-2 (ListView + Form)
  ├─ View data items
  ├─ FAB untuk add item
  └─ Click item untuk detail
```

---

## Common Tasks

### Menambah Color Baru
```dart
// Di lib/constants/app_colors.dart
static const Color newColor = Color(0xFF123456);
```

### Menambah String Baru
```dart
// Di lib/constants/app_strings.dart
static const String newString = 'Text here';
```

### Menambah Dimension Baru
```dart
// Di lib/constants/app_dimensions.dart
static const double newDimension = 16.0;
```

### Menambah Model Baru
```dart
// 1. Buat file: lib/models/nama.dart
class Nama {
  final String field;
  
  const Nama({required this.field});
  
  factory Nama.fromJson(Map<String, dynamic> json) {
    return Nama(field: json['field']);
  }
}

// 2. Export di lib/models/models.dart
export 'nama.dart';
```

### Menambah Widget Reusable
```dart
// 1. Buat file: lib/widgets/nama_widget.dart
class NamaWidget extends StatelessWidget {
  const NamaWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// 2. Export di lib/widgets/widgets.dart
export 'nama_widget.dart';

// 3. Gunakan di screen:
import 'package:nama_pro/widgets/widgets.dart';
// ... NamaWidget()
```

### Menambah Screen Baru
```dart
// 1. Buat file: lib/screens/nama_screen.dart
class NamaScreen extends StatelessWidget {
  const NamaScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nama')),
      body: const Center(child: Text('Content')),
    );
  }
}

// 2. Export di lib/screens/screens.dart
export 'nama_screen.dart';

// 3. Add route di lib/main.dart
'/nama': (context) => const NamaScreen(),

// 4. Navigasi dari screen lain
Navigator.pushNamed(context, '/nama');
```

---

## 🎨 Using Constants

```dart
// ✅ Gunakan constants
import 'package:nama_pro/constants/constants.dart';

Text(
  AppStrings.welcomeText,
  style: TextStyle(
    color: AppColors.primaryBlue,
    fontSize: AppDimensions.fontSizeXXLarge,
  ),
)

// Jangan hardcode
Text(
  "Welcome",
  style: TextStyle(
    color: Color(0xFF7367F0),
    fontSize: 28,
  ),
)
```

---

## Widget Composition

```dart
// Buat widget besar dari smaller widgets

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StudentProfileHeader(student: student),
          ToeflStatusCard(score: score),
          TechStackCard(tech: tech),
        ],
      ),
    );
  }
}
```

---

## Navigation Example

```dart
// Navigate to another screen
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/tutorial_11_1');
  },
  child: const Text('Go'),
)

// Navigate with arguments (jika diperlukan)
Navigator.pushNamed(
  context,
  '/tutorial_11_2',
  arguments: {'data': someData},
)

// Pop back
Navigator.pop(context);

// Pop until
Navigator.popUntil(context, ModalRoute.withName('/home'));
```

---

## State Management Pattern

```dart
class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  // Declare state variables
  List<String> items = [];
  
  @override
  void initState() {
    super.initState();
    // Initialize data
    _loadData();
  }
  
  void _loadData() {
    // Load atau setup data
  }
  
  void _addItem(String item) {
    setState(() {
      items.add(item); // Update state
    });
  }
  
  @override
  void dispose() {
    // Cleanup resources
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Text(items[index]);
        },
      ),
    );
  }
}
```

---

## Responsive Design Tips

```dart
// Get screen dimensions
double screenWidth = MediaQuery.of(context).size.width;
double screenHeight = MediaQuery.of(context).size.height;

// Responsive padding
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: screenWidth * 0.05, // 5% of screen width
    vertical: AppDimensions.paddingLarge,
  ),
  child: const Text('Content'),
)

// Flexible layouts
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)
```

---

## Debugging Tips

```dart
// Print to console
print('Debug: $value');
print(item.toJson());

// Use DevTools
// Run: flutter pub global activate devtools
//      devtools

// Hot reload vs Hot restart
// Ctrl+S (VS Code) = Hot Reload
// Ctrl+Shift+S (VS Code) = Hot Restart

// Check build errors
flutter analyze

// Clean build
flutter clean
flutter pub get
flutter run
```

---

## Testing dalam Aplikasi

```dart
// Manual testing flow
// 1. Start di home, verify UI muncul
// 2. Click "Go to Tutorial 11-1"
// 3. Verify PageView muncul dengan 3 halaman
// 4. Click bottom nav items
// 5. Click button di page 2 untuk ke Tutorial 11-2
// 6. Verify ListView muncul
// 7. Click FAB untuk add item
// 8. Fill form dan save
// 9. Verify item muncul di list
// 10. Click item untuk detail dialog
// 11. Close dan verify item masih ada
// 12. Navigate back dan forward verify data persist
```

---

## Common Errors & Fixes

### Error: "Type 'X' is not a subtype of type 'Y'"
```dart
// Pastikan model casting benar
List<Product> items = data.cast<Product>();
```

### Error: "setState called after dispose"
```dart
// Cek apakah mounted sebelum setState
if (mounted) {
  setState(() {
    value = newValue;
  });
}
```

### Error: "The argument type cannot be assigned to type"
```dart
// Pastikan parameter type sesuai
void myFunction(String text) { }
myFunction('hello'); // String
myFunction(123);     // int
```

### Error: "Named route not found"
```dart
// Pastikan route ada di main.dart
// Pastikan nama route benar saat navigate
Navigator.pushNamed(context, '/correct_route_name');
```

---

## Additional Resources

### Flutter Documentation
- https://flutter.dev/docs
- https://api.flutter.dev

### Dart Documentation  
- https://dart.dev/guides

### Package Management
- https://pub.dev
- Find packages: `flutter pub search keyword`
- Add package: `flutter pub add package_name`

---

## Best Practices

```dart
// DO
- Gunakan const constructor
- Extract large widgets ke files terpisah
- Use named parameters
- Validate input
- Handle errors
- Comment complex logic

// DON'T
- Hardcode value
- Deep nesting
- Ignore null safety
- Large build methods
- Performance-heavy widgets di build
```

---

## File Structure Reference

```
Ingin menambah feature? Ikuti struktur:

Feature "Authentication"
├── lib/models/user.dart (Data model)
├── lib/screens/login_screen.dart
├── lib/screens/register_screen.dart
├── lib/widgets/login_form.dart
├── lib/widgets/register_form.dart
├── constants/app_strings.dart (Tambah strings)
└── main.dart (Tambah routes)
```

---

## Development Workflow

```
1. Plan feature
2. Create necessary files
3. Add constants (colors, strings, dimensions)
4. Create models if needed
5. Create reusable widgets
6. Create screen
7. Add routing in main.dart
8. Test functionality
9. Refactor if needed
10. Document changes
```

---

## Need Help?

1. **Baca PROJECT_DOCUMENTATION.md** untuk detailed guide
2. **Check VERIFICATION_CHECKLIST.md** untuk verification
3. **Look at existing code** sebagai reference
4. **Use Flutter DevTools** untuk debugging

---

**Selamat Mengembangkan!**

Jika ada pertanyaan atau menemukan bug, dokumentasikan dan improve project.

---

*Last Updated: Mei 2026*  
*Version: 1.0.0*
