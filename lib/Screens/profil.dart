import 'package:flutter/material.dart';

class Profilpage extends StatefulWidget {
  const Profilpage({Key? key}) : super(key: key);

  @override
  _ProfilpageState createState() => _ProfilpageState();
}

class _ProfilpageState extends State<Profilpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      height: MediaQuery.of(context).size.height,
      // width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          //Container for top data

          DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Profil",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    //now expense
                  ],
                ),
              );
            },
            initialChildSize: 0.75,
            minChildSize: 0.65,
            maxChildSize: 1,
          ),

          //draggable sheet
        ],
      ),
    );
  }
}
