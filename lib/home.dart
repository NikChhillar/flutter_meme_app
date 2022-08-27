import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: avoid_init_to_null
  var image = null;

  @override
  void initState() {
    generateRandomMeme();
    super.initState();
  }

  void generateRandomMeme() async {
    var url = Uri.parse('https://meme-api.herokuapp.com/gimme');
    var response = await http.get(url);
    var parsed = json.decode(response.body);

    setState(() {
      image = parsed['url'];
    });
  }

  void share() {
    Share.share('check this out... $image');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'WTF! Memes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade500,
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: (image != null)
            ? Column(
                children: [
                  Flexible(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.network(image),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => generateRandomMeme(),
                            icon: Icon(
                              Icons.change_circle_outlined,
                              size: 42,
                              color: Colors.blueGrey.shade600,
                            ),
                          ),
                          IconButton(
                            onPressed: () => share(),
                            icon: Icon(
                              Icons.share,
                              size: 42,
                              color: Colors.blueGrey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
