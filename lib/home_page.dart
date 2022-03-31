import 'dart:convert';
import 'package:api_sample/album.dart';
import 'package:api_sample/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  late Post data;
  List<Post> dataList = [];

  @override
  void initState() {
    getData();
    getDataList();
    super.initState();
  }

  getAlbumData() async {
    String api = "https://jsonplaceholder.typicode.com/photos";
    Uri uri = Uri.parse(api);
    http.Response data = await http.get(uri);
    List<Album> albums = [];
    if (data.statusCode == 200) {
      var decodedData = jsonDecode(data.body);
      decodedData.forEach((var item) {
        var album = parseAlbum(item);
        album.toString();
        albums.add(album);
      });
    } else {}
  }

  Album parseAlbum(var item) {
    int albumId = item["albumId"];
    int id = item["id"];
    String title = item["title"];
    String thumbnailUrl = item["thumbnailUrl"];
    String url = item["url"];

    return Album(albumId, id, title, thumbnailUrl, url);
  }

  getDataList() async {
    String address = "https://jsonplaceholder.typicode.com/posts";
    Uri addressUri = Uri.parse(address);
    var response = await http.get(addressUri);
    if (response.statusCode < 300) {
      var responseData = jsonDecode(response.body);
      responseData.forEach((item) {
        var eachPost =
            Post(item["id"], item["userId"], item["title"], item["body"]);
        dataList.add(eachPost);
      });
      setState(() {});
    } else {
      print(response.statusCode);
    }
    isLoading = false;
    setState(() {});
  }

  getData() async {
    String address = "https://jsonplaceholder.typicode.com/posts/1/";
    Uri addressUri = Uri.parse(address);
    var response = await http.get(addressUri);
    if (response.statusCode < 300) {
      var responseData = jsonDecode(response.body);
      data = Post(responseData["id"], responseData["userId"],
          responseData["title"], responseData["body"]);
    } else {
      print(response.statusCode);
    }
    isLoading = false;
    setState(() {});
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text(widget.title),
  //       ),
  //       body: Center(
  //         child: Text(isLoading ? "Loading" : data.body),
  //       ) // This trailing comma makes auto-formatting nicer for build methods.
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int pos) {
              var data = dataList[pos];
              return ListTile(
                title: Text(data.title),
                subtitle: Text(data.body),
              );
            }) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
