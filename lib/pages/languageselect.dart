import 'package:flutter/material.dart';
import './../main.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageOption(context, 'en', 'English'),
          _buildLanguageOption(context, 'fr', 'Français'),
          _buildLanguageOption(context, 'es', 'Español'),
          _buildLanguageOption(context, 'de', 'Deutsch'),
          _buildLanguageOption(context, 'it', 'Italiano'),
          _buildLanguageOption(context, 'pt', 'Português'),
          _buildLanguageOption(context, 'ru', 'Русский'),
          _buildLanguageOption(context, 'zh', '中文'),
          _buildLanguageOption(context, 'ja', '日本語'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String code, String language) {
    return ListTile(
      title: Text(language),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(language: code),
          ),
        );
      },
    );
  }
}
