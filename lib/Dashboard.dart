import 'package:flutter/material.dart';
import 'package:modul_6/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:modul_6/Trending.dart';
import 'dart:convert';
import 'label.dart';
import 'Cari.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {

  Future<Pilem> fetchTrending() async{
    final response = await http.get(Uri.parse('https://api-lk21.herokuapp.com/newupload'));

    if (response.statusCode == 200) {
      return Pilem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed');
    }
  }

  Future<List<Cari>> fetchCari() async{
    final response =
    await http.get(Uri.parse('http://10.0.2.2:8000/api/jadwal'));

    if(response.statusCode ==200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((cari) => new Cari.fromJson(cari)).toList();
    }else{
      throw Exception('Failed to load Board Activity');
    }
  }

  Future<List<Cari>> futureSearch;

  Future<Pilem> futureTrending;

  SharedPreferences pref;
  String username;
  String nim;
  @override
  void initState() {
    getElement();
    super.initState();
    futureTrending = fetchTrending();
    futureSearch = fetchCari();
  }

  void getElement() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username');
      nim = pref.getString('nim');
    });
  }

  /* @override
  Widget build(BuildContext context) {
    final setpref = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$username', style: TextStyle(color: Colors.white),),
          Text('$nim', style: TextStyle(color: Colors.white),),
        ],
      ),
    ); */
    
    /*final logout = Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () async {
            pref = await SharedPreferences.getInstance();
            pref.remove('username');
            pref.remove('nim');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: Text('Log out', style: TextStyle(color: Colors.white)),
        ),
    ); */


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Color.fromRGBO(169, 194, 32, 1.0),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Main Menu"),
                  Tab(text: "Jadwal"),
                  Tab(text: "Akun")
                ],
              ),
              title: Text('Sakarep'),
            ),
            body: TabBarView(
              children: [
                FutureBuilder(
                  future: futureTrending,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print("Has Data: ${snapshot.hasData}");
                      return ListView.builder(
                        itemCount: snapshot.data.result.length,
                        itemBuilder: (BuildContext context, int index) {
                          return trending(
                              img: snapshot.data.result[index].thumbnail,
                              title: snapshot.data.result[index].title,
                              difficulty: snapshot.data.result[index].rating,
                              //genre: snapshot.data.result[index].rating,
                              durasi : snapshot.data.result[index].duration,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Trendetail(
                                      image: snapshot.data.result[index].thumbnail,
                                      title: snapshot.data.result[index].title,
                                      rating : snapshot.data.result[index].rating,
                                      trailer : snapshot.data.result[index].trailer,
                                      duration : snapshot.data.result[index].duration,
                                    )));
                              }
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      print("Has Error: ${snapshot.hasError}");
                      return Text('Error!!!');
                    } else {
                      print("Loading...");
                      return CircularProgressIndicator();
                    }
                  },
                ),
                FutureBuilder(
                  future: futureSearch,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print("Has Data: ${snapshot.hasData}");
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return search(
                              title: snapshot.data[index].title,
                              rating: snapshot.data[index].rating,
                              duration: snapshot.data[index].duration,
                              waktu : snapshot.data[index].waktu,
                              description : snapshot.data[index].description,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      print("Has Error: ${snapshot.hasError}");
                      return Text('Error!!!');
                    } else {
                      print("Loading...");
                      return CircularProgressIndicator();
                    }
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(''),
                    Text('Profile',style: TextStyle(color: Colors.black, fontSize: 30)),
                    Text(''),
                    Image.network('https://www.kindpng.com/picc/m/381-3812277_ville-de-saint-etienne-png-download-gambar-icon.png',height: 100,width: 100,),
                    Text(''),Text(''),
                    Text('Nama  : $username', style: TextStyle(color: Colors.black)),
                    Text('NIM   : $nim', style: TextStyle(color: Colors.black)),
                    Padding(
                      padding: EdgeInsets.only(left: 10,top: 30,bottom: 20 ,right: 10 ),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () async {
                          pref = await SharedPreferences.getInstance();
                          pref.remove('username');
                          pref.remove('nim');
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        padding: EdgeInsets.all(12),
                        color: Color.fromRGBO(169, 194, 32, 1.0),
                        child: Text('Log out', style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                )
              ],
            )
        )
        );
  }

  Widget search(
      {
        String title,
        String rating,
        String duration,
        String waktu,
        String description,

        Function onTap
      }){
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(rating),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(duration + ' menit'),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(waktu),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(description),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget trending(
      {
        String img,
        String title,
        String difficulty,
        String durasi,
        String genre,

        Function onTap
      }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 120,
                          child: Image.network(img)
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(difficulty),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(durasi),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('More Detail'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
  }

class Trendetail extends StatelessWidget {
  final String title, image, rating, trailer, duration;

  const Trendetail({Key key, this.title,this.image,this.rating,this.duration,this.trailer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(169, 194, 32, 1.0),
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Padding(
              child : Image.network(image,width: 250,),
                padding: EdgeInsets.only(top: 5, left: 55)
            ),

            Text('Duration : ' + duration, textAlign: TextAlign.left),
            SizedBox(
              height: 10,
            ),
            Text('Rating : ' + rating, textAlign: TextAlign.left),
            SizedBox(
              height: 10,
            ),
            Text('Trailer : ' + trailer, textAlign: TextAlign.left),
            SizedBox(
              height: 10,
            ),
          ]
      ),
    );
  }
}
class Searchtail extends StatelessWidget {

  final String title, rating, duration, waktu, description;

  const Searchtail({Key key, this.title,this.rating,this.duration,this.waktu,this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(169, 194, 32, 1.0),
        title: Text(title),
      ),

      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text('Duration : ' + duration, textAlign: TextAlign.left),
            SizedBox(
              height: 10,
            ),
            Text('Rating : ' + rating, textAlign: TextAlign.left),
            SizedBox(
              height: 10,
            ),
            Text('Duration : ' + waktu, textAlign: TextAlign.left),
            SizedBox(
              height: 10,
            ),
            Text('Trailer : ' + description, textAlign: TextAlign.left),
            SizedBox(
              height: 10,
            ),
          ]
      ),
    );
  }
}