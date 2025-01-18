import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('en');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Hindi'),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('hi');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Marathi'),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('mr');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
