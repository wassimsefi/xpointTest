import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xpoint/model/demande.dart';
import 'package:http/http.dart' as http;

class Listpage extends StatefulWidget {
  const Listpage({Key? key}) : super(key: key);

  @override
  _ListpageState createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  Future<List<Demande>> getDemand() async {
    final String apiUrl = "http://localhost:3000/demande";
    final Response = await http.get(apiUrl);

    if (Response.statusCode == 200) {
      List<Demande> demandes = demandeFromJson(Response.body);

      return demandes;
    } else {
      throw ("Can't get the demande");
    }
  }

  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    print('hello');

    List<Demande> demands = await getDemand();

    print('hello 222' + demands[1].title);
  }

  List<String> litems = ["1", "2", "3", "4", "5", "6", "7", "8"];

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
                          const Text(
                            "Liste data",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(1),
                        controller: ScrollController(keepScrollOffset: false),
                        itemCount: litems.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "TunCoin " + litems[index],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "1 TNC = \$ 0.1247",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[500]),
                                    ),
                                    Text(
                                      " \$ 0.1247",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.redAccent),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.arrow_circle_up_sharp,
                                              size: 18,
                                              color: Colors.green,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " 1.28%",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
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
