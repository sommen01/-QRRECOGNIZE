import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrrecognize/tela_pessoa.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerTab extends StatefulWidget {
  @override
  _ScannerTabState createState() => _ScannerTabState();
}

class _ScannerTabState extends State<ScannerTab> {
  Uint8List bytes = Uint8List(0);

  Map<String, dynamic> userData = Map();
  Map<String, dynamic> unsavedData;

  TextEditingController _inputController;
  TextEditingController _outputController;
  String pontos;
  String uid;
  String cupomID;
  bool data = false;
  List<String> dados;
  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanner')),
      backgroundColor: Colors.grey[300],
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.632,
                      child: Center(
                        child: Container(
                          
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: <Widget>[
                          //       Text(data ? '' : 'Aguardando leitura...'),
                          // //       SizedBox(
                          // //         height: 5,
                          // //       ),
                          //       Text(data ?'${userData['name']}' : ''),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: <Widget>[
                          //           Text(data ? 'Pontos : ' : ''),
                          //           SizedBox(
                          //             width: 5,
                          //           ),
                          //           Text(data
                          //               ?'${userData['totalPontos']}'
                          //               : ''),
                          //         ],
                          //       ),
                          //       SizedBox(
                          //         height: 5,
                          //       ),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: <Widget>[
                          //           Text(data ? 'Status :' : ''),
                          //           SizedBox(
                          //             width: 5,
                          //           ),
                          //           Text(),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: TextField(
                        controller: this._outputController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.wrap_text),
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    this._buttonGroup(),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String time() {
    String data =
        formatDate(DateTime.now(), [dd, '.', mm, '.', yy, ' ', HH, ':', nn]);
    return data;
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('images/scanner.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Escanear")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scanPhoto,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('images/albums.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Escanear foto")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('Nada para retornar.');
    } else {
      this._outputController.text = barcode;
      var dados = json.decode(barcode);
      print(dados);
      data = true;
                      Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Pessoa(dados)),
                  );
    }
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    this._outputController.text = barcode;
    var dados = json.decode(barcode);
      print(dados);

    data = true;
   Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Pessoa(dados)),
                  );  }

  Future _scanPath(String path) async {
    String barcode = await scanner.scanPath(path);
    this._outputController.text = barcode;
    var dados = json.decode(barcode);
    data = true;
   Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Pessoa(dados)),
                  );  }

  Future _scanBytes() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    Uint8List bytes = file.readAsBytesSync();
    String barcode = await scanner.scanBytes(bytes);
    this._outputController.text = barcode;
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
  // _loadCurrentUser() async {
  // if(uid != null){
  //   if(userData["name"] == null){
  //     print(uid);
  //     DocumentSnapshot docUser =
  //       await Firestore.instance.collection("parceiros").document(uid).get();
  //     userData = docUser.data;
  //     print(userData);
  //   }
  // }
  // }

  void _showDialogSucesso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Sua transação foi concluída com sucesso!!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  unsavedData = Map();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
