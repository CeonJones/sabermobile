import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:just_audio/just_audio.dart';
import 'package:sabermobile/models/latest_news_item.dart';
import 'package:sabermobile/models/more_stories_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Latest:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 1.0),
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
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          //decoration: BoxDecoration(
                          //border:
                          //Border.all(color: Colors.black, width: 5.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(latestNewsItems[index].image,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
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
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Image.network(moreStoriesItems[index].image),
                        Text(moreStoriesItems[index].headline,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          moreStoriesItems[index].description,
                        ),
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
