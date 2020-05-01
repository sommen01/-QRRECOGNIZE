import 'package:flutter/material.dart';
import 'package:qrrecognize/scanner.dart';

class Home extends StatelessWidget {
  static final String path = "lib/src/pages/travel/travel_home.dart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
    child :Container(
      height: MediaQuery.of(context).size.height * 1,
          child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xff8a202a),
                Color(0xff00316c),
                Color(0xffa05c17),
                Color(0xff004c36)
              ])),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: 250,
                      child: Text(
                        "Ola, tenha um bom trabalho",
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          top: 400,
          left: 42,
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  child: Image.asset(
                    "assets/luiz.png",
                    fit: BoxFit.contain,
                  ),
                ),
                
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Container(
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'KEK'
                      ),
                      onPressed: (){
                                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScannerTab()),
                  );
                      },)
                  ),
                ),
              )
            ],
          ),
      ),
        ),
        ],
      ),
    )
      )
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height - 53);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 90);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 14);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;
  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount,
      this.oldPrice, this.newPrice);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container()),
    );
  }
}
