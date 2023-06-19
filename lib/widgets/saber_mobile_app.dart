import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:just_audio/just_audio.dart';
import 'package:sabermobile/widgets/home_page.dart';
import 'package:sabermobile/widgets/radio_page.dart';

class SaberMobileApp extends StatefulWidget {
  const SaberMobileApp({super.key});

  @override
  State<SaberMobileApp> createState() => _SaberMobileAppState();
}

class _SaberMobileAppState extends State<SaberMobileApp> {
  
  @override
  void initState() {
    super.initState();

    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://sabermag.squarespace.com/stories');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll(
            'div.summary-title > a')
        .map((element) => element.innerHtml.trim())    
        .toList();

    print('Count: ${titles.length}');
    for (final title in titles) {
      debugPrint(title);
    }
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const RadioPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.ibmPlexMonoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
          backgroundColor: const Color.fromRGBO(242, 242, 4, 1.0),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(242, 242, 4, 1.0),
            elevation: 5.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    '/Users/ceonjones/sabermobile/assets/images/SLOGO+SOFT+BLACK.png',
                    fit: BoxFit.cover,
                    height: 60),
              ],
            ),
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(22, 22, 22, 1.0),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.radio),
                label: 'Radio',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromRGBO(242, 242, 4, 1.0),
            unselectedItemColor: const Color.fromRGBO(255, 255, 255, 1.0),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          )),
    );
  }
}
