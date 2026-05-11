import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class Tutorial11_2Screen extends StatefulWidget {
  const Tutorial11_2Screen({Key? key}) : super(key: key);

  @override
  State<Tutorial11_2Screen> createState() => _Tutorial11_2ScreenState();
}

class _Tutorial11_2ScreenState extends State<Tutorial11_2Screen> {
  late List<Map<String, dynamic>> data;
  late TextEditingController titleInput;
  late TextEditingController platInput;
  late TextEditingController langInput;
  late List<DropdownMenuItem<String>> colorItems;
  String? colorSelected;

  @override
  void initState() {
    super.initState();
    _initializeData();
    titleInput = TextEditingController();
    platInput = TextEditingController();
    langInput = TextEditingController();

    colorItems = [
      const DropdownMenuItem(value: 'blue', child: Text('blue')),
      const DropdownMenuItem(value: 'green', child: Text('green')),
      const DropdownMenuItem(value: 'yellow', child: Text('yellow')),
    ];
    colorSelected = null;
  }

  void _initializeData() {
    data = [
      {
        'title': 'Native App',
        'platform': 'Android, iOS',
        'lang': 'Java, Kotlin, Swift, C#',
        'color': Colors.red,
      },
      {
        'title': 'Hybrid App',
        'platform': 'Android, iOS, Web',
        'lang': 'Javascript, Dart',
        'color': Colors.grey,
      },
    ];
  }

  Color _getColorFromString(String? colorName) {
    switch (colorName) {
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.blue;
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.addNewTechDialogTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppStrings.techNameLabel,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: AppStrings.techNameHint,
                  ),
                  controller: titleInput,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppStrings.platformLabel,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: AppStrings.platformHint,
                  ),
                  controller: platInput,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppStrings.langLabel,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: AppStrings.langHint,
                  ),
                  controller: langInput,
                ),
                const SizedBox(height: AppDimensions.marginMedium),
                DropdownButton<String>(
                  items: colorItems,
                  onChanged: (val) {
                    setState(() {
                      colorSelected = val;
                    });
                  },
                  value: colorSelected,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(AppStrings.closeButtonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(AppStrings.saveButtonLabel),
              onPressed: () {
                if (titleInput.text.isNotEmpty &&
                    platInput.text.isNotEmpty &&
                    langInput.text.isNotEmpty &&
                    colorSelected != null) {
                  setState(() {
                    data.add({
                      'title': titleInput.text,
                      'platform': platInput.text,
                      'lang': langInput.text,
                      'color': _getColorFromString(colorSelected),
                    });
                  });
                  titleInput.clear();
                  platInput.clear();
                  langInput.clear();
                  colorSelected = null;
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added ${titleInput.text} successfully',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDetailDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.detailDialogTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index]['title'],
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSizeLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppDimensions.marginSmall),
                Text(data[index]['platform']),
                const SizedBox(height: AppDimensions.marginSmall),
                Text(data[index]['lang']),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(AppStrings.closeButtonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    titleInput.dispose();
    platInput.dispose();
    langInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABP Minggu 11'),
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: data.isEmpty
            ? const Center(
                child: Text(
                  AppStrings.noDataAvailable,
                  style: TextStyle(
                    color: AppColors.textTeal,
                    fontSize: AppDimensions.fontSizeXXLarge,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.marginMedium,
                      vertical: AppDimensions.marginSmall,
                    ),
                    child: TechStackCard(
                      tech: TechStack(
                        title: data[index]['title'],
                        platform: data[index]['platform'],
                        lang: data[index]['lang'],
                        color: data[index]['color'],
                      ),
                      onTap: () => _showDetailDialog(index),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
