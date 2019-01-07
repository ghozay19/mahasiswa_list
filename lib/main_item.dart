import 'package:flutter/material.dart';
import 'package:mahasiswa_list/model/mahasiswa.dart';

class MainItem extends StatefulWidget {
  final MahasiswaItem mahasiswaItem;

  const MainItem({Key key, this.mahasiswaItem}) : super(key: key);

  @override
  _MainItemState createState() => _MainItemState(mahasiswaItem);
}

class _MainItemState extends State<MainItem> {
  final MahasiswaItem mahasiswaItem;

  _MainItemState(this.mahasiswaItem);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        //height: 150.0,
        child: Card(
            elevation: 8.0,
            child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ColumnCustom(
                      text1: mahasiswaItem.nimMahasiswa,
                      text2: mahasiswaItem.namaMahasiswa,
                      text3: mahasiswaItem.alamatMahasiswa,
                      text4: mahasiswaItem.noTelpMahasiswa,
                    ),
                  ],
                ))),
      ),
    );
  }
}



//create a custom widget.

class ColumnCustom extends StatelessWidget {
  final String text1, text2, text3, text4;
  ColumnCustom({this.text1, this.text2, this.text3, this.text4});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nim'),
            Text('Nama'),
            Text('Alamat'),
            Text('No Telpon')
          ],
        ),
        SizedBox(
          width: 5.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(':'),
            Text(':'),
            Text(':'),
            Text(':'),
          ],
        ),
        SizedBox(
          width: 5.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(text1),
            Text(text2),
            Text(text3),
            Text(text4)
          ],
        )
      ],
    );
  }
}
