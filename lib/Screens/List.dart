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
  Future<List<DemandeElement>> getDemandes() async {
    const String apiUrl = "http://192.168.1.16:3000/demande/";
    final Response = await http.get(apiUrl);

    if (Response.statusCode == 200) {
      List<dynamic> json = jsonDecode(Response.body);

      List<DemandeElement> demandes =
          json.map((dynamic item) => DemandeElement.fromJson(item)).toList();

      return demandes;
    } else {
      throw ("Can't get the article");
    }
  }

  @override
  void initState() {
    super.initState();
    getDemandes();
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Liste data",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: Colors.black),
                        ),
                      ],
                    ),

                    Flexible(
                      child: FutureBuilder(
                        future: getDemandes(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<DemandeElement>> snapshot) {
                          if (snapshot.hasData) {
                            List<DemandeElement>? demandes = snapshot.data;
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(1),
                              controller:
                                  ScrollController(keepScrollOffset: false),
                              itemCount: demandes!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              demandes[index].title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey[900]),
                                            ),
                                            Text(
                                              demandes[index].category,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey[900]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
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
