import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(SaberMobileApp());
}

//Class that represents each latest story item in our horizontal listview. Class holds the image and link to the story
class LatestNewsItem {
  final String image;
  final String link;

  LatestNewsItem(this.image, this.link);
}

class MoreStoriesItem {
  final String image;
  final String link;
  final String headline;
  final String description;

  MoreStoriesItem(this.image, this.link, this.headline, this.description);
}

//List of more stories items that will be displayed in the vertical listview
List<MoreStoriesItem> moreStoriesItems = [
  MoreStoriesItem(
      'https://images.squarespace-cdn.com/content/v1/5f75d9b14cf107041e3f6a1a/77ecd555-065d-4947-99d7-dadee67ac4aa/Screen+Shot+2022-05-19+at+2.55.51+PM.png?format=1500w',
      'https://sabermag.squarespace.com/culture-wr/dom-chronicles-drops-still-learning',
      'Dom Chronicles drops ‘STILL LEARNING’',
      'Dom has returned! This time he’s back to remind us that he’s ‘STILL LEARNING’'),
  MoreStoriesItem(
      'https://images.squarespace-cdn.com/content/v1/5f75d9b14cf107041e3f6a1a/1654540160563-FGFT7F0LIFH17DTR5EGF/DSC03808.jpg?format=1500w',
      'https://sabermag.squarespace.com/culture-wr/fuse6',
      'Fuse 6 | Scenes From The Weekend',
      'The best way to describe the 6th Installment of Fuse: “a moment”.'),
  MoreStoriesItem(
      'https://images.squarespace-cdn.com/content/v1/5f75d9b14cf107041e3f6a1a/8c867a75-281b-4dd4-ab5a-5660cbaa197b/IMG_2041.jpeg?format=1500w',
      'https://sabermag.squarespace.com/life-wr/my-mind-plays-tricks-on-me-j7b49',
      '“my mind plays tricks on me” | midori 🐛',
      'A Journal entry by midori.'),
  MoreStoriesItem(
      'https://images.squarespace-cdn.com/content/v1/5f75d9b14cf107041e3f6a1a/1624325492285-EF9NOGBF0FMA4B4QABZR/P1.jpg?format=1500w',
      'https://sabermag.squarespace.com/life-wr/0ah0fp715ddry0caxnnpmsb6zdqsnu',
      'Between Death and Dying | Short Story',
      'A short story written by Elijah Morinville.'),
  MoreStoriesItem(
      'https://images.squarespace-cdn.com/content/v1/5f75d9b14cf107041e3f6a1a/c81179ae-b819-48b2-97eb-71a5e4c4a13b/aniifa+2.png?format=1500w',
      'https://sabermag.squarespace.com/life-wr/antifastole',
      'Antifa Stole My Tear Ducts',
      'A current events op ed written by DarWickline'),
];

List<LatestNewsItem> latestNewsItems = [
  LatestNewsItem(
      'https://images.squarespace-cdn.com/content/v1/5f75d9b14cf107041e3f6a1a/1677807413637-34EIKXKUZOL1UR5U4YV5/Screen+Shot+2023-03-02+at+7.36.37+PM.png?format=1500w',
      'https://youtu.be/-BXYZY9ZMc4'),
  LatestNewsItem(
      'https://images.squarespace-cdn.com/content/v1/5f75d9b14cf107041e3f6a1a/2f6eb955-f6ef-48d4-aaba-5fb5bfbd6337/DSC03957.jpg?format=1500w',
      'https://sabermag.squarespace.com/culture-wr/sauced-year-two'),
  LatestNewsItem(
      'https://images.squarespace-cdn.com/content/v1/5f75d9b14cf107041e3f6a1a/2e385228-8c1d-4e3c-b7f3-1a275889a234/FE069494-30BC-4355-BE4B-A440416818CC.JPG?format=1500w',
      'https://sabermag.squarespace.com/culture-wr/abby-sarabia-qampa'),
];

//HomePage widget that will be used in the bottom navigation bar
//Displays a horizontal list of latest stories and a vertical list of more stories articles, and content
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Latest:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: 200,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: latestNewsItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (await canLaunch(latestNewsItems[index].link)) {
                          await launch(latestNewsItems[index].link);
                        } else {
                          throw 'Could not launch ${latestNewsItems[index].link}';
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.network(latestNewsItems[index].image),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Stories:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                onTap: () async {
                  if (await canLaunch(moreStoriesItems[index].link)) {
                    await launch(moreStoriesItems[index].link);
                  } else {
                    throw 'Could not launch ${moreStoriesItems[index].link}';
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(moreStoriesItems[index].image),
                        Text(moreStoriesItems[index].headline,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(moreStoriesItems[index].description),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: moreStoriesItems.length,
          ),
        ),
      ],
    );
  }
}

//Radio page widget to be used in the bottom navigation bar. Displays 24/7 radio player
class RadioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'This is the Radio Page',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

//Main widget for the app, which includes state management for the bottom nav bar
class SaberMobileApp extends StatefulWidget {
  @override
  State<SaberMobileApp> createState() => _SaberMobileAppState();
}

//State for the SaberMobileApp. Includes theme, appbar, background color, and bottom navigation bar
class _SaberMobileAppState extends State<SaberMobileApp> {
  int _selectedIndex = 0;

//List of widgets that will be displayed as the body of te app based on the index of the bottom navigation bar
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    RadioPage(),
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
          backgroundColor: Color.fromRGBO(242, 242, 4, 1.0),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(242, 242, 4, 1.0),
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
            backgroundColor: Color.fromRGBO(22, 22, 22, 1.0),
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
            selectedItemColor: Color.fromRGBO(242, 242, 4, 1.0),
            unselectedItemColor: Color.fromRGBO(255, 255, 255, 1.0),
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
