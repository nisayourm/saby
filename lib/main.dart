import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main () => runApp(Pixabay());
class Pixabay extends StatefulWidget {
  @override
  _PixabayState createState() => _PixabayState();
}

class _PixabayState extends State<Pixabay> {
  Map images;
  List imgList;

   Future getImage() async{
    http.Response response = await http.get('https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=yellow+flowers&image_type=photo&pretty=true');
    // debugPrint(response.body);
    images = json.decode(response.body);

    //conver json to array
    setState(() {
     imgList = images['hits']; 
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage() ;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Day is the day",
          style: TextStyle(color: Colors.purple),
          ),
          centerTitle: true,
          backgroundColor: Colors.pink[200],
        ),
        body: ListView.builder(
          itemCount: imgList != null ? imgList.length:0,
          itemBuilder: (context,i){
            return Card(
             child: Column(
               children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Image.network(imgList[i]['largeImageURL']),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: <Widget>[
                         CircleAvatar(
                           backgroundImage: NetworkImage(imgList[i]['userImageURL']),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("${imgList[i]['tags']}"),
                         ),
                         IconButton(icon: Icon(Icons.favorite,
                         color: Colors.red,
                         size: 40,
                         ),),
                         IconButton(icon: Icon(Icons.face,
                         size: 40,
                         color: Colors.pink[200],
                         )),
                       ],
                     ),
                   ),
               ],
             ),
            );
          }
        ),
      ),
    );
  }
}