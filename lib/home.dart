import 'package:flutter/material.dart';
import 'package:mahasiswa_list/main_item.dart';
import 'package:http/http.dart' as http;
import 'package:mahasiswa_list/model/mahasiswa.dart';
import 'dart:async';
import 'dart:convert';
import 'utils/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<MainItem>> _fetchData() async {
    final request = await http.get(Api.listMahasiswa);

    if (request.statusCode == 200) {
      List response = json.decode(request.body)['result'];
      List<MainItem> data = [];

      // for (int i = 0; i < response.length; i++) {
      //   data.add(MainItem(
      //       mahasiswaItem: MahasiswaItem(
      //           nimMahasiswa: response[i]['mahasiswa_nim'],
      //           namaMahasiswa: response[i]['mahasiswa_nama'],
      //           alamatMahasiswa: response[i]['mahasiswa_alamat'],
      //           noTelpMahasiswa: response[i]['mahasiswa_notelp'])));
      // }

      for (int i = 0; i < response.length; i++) {
        data.add(MainItem(
          mahasiswaItem: MahasiswaItem(
            response[i]['mahasiswa_nim'],
            response[i]['mahasiswa_nama'],
            response[i]['mahasiswa_alamat'],
            response[i]['mahasiswa_notelp'],

          ),
        ));
      }
      return data;
    } else {
      return [];
    }
  }

  Widget loadingPage() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget homePage(List<MainItem> mahasiswa) {
    return ListView.builder(
      itemBuilder: (context, index) => mahasiswa[index],
      itemCount: mahasiswa.length,
    );
  }

  Widget errorPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Failed To Retrieve Data',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            onPressed: () {
              _fetchData();
              print('button pressed');
            },
            child: Text('Try Again'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetching data From JSON')
      ),
      body: FutureBuilder<List<MainItem>>(
          future: _fetchData(),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return errorPage();
              case ConnectionState.active:
                return loadingPage();
              case ConnectionState.waiting:
                return loadingPage();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  print('has data');
                  return homePage(snapshot.data);
                } else if (snapshot.hasError) {
                  print('has error');
                  return errorPage();
                } else {
                  return loadingPage();
                }
            }
          }),
    );
  }
}
