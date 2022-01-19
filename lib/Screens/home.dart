import 'package:flutter/material.dart';
import 'package:xpoint/Screens/profil.dart';
import 'package:xpoint/widget/stepper.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.width;

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
                          Container(
                            height: h,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StepperWidget(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //now expense
                  ],
                ),
              );
            },
            initialChildSize: 0.85,
            minChildSize: 0.65,
            maxChildSize: 1,
          ),

          //draggable sheet
        ],
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          title: Text("Account"),
          content: Container(),
        ),
        Step(
          title: Text("Address"),
          content: Container(),
        ),
        Step(
          title: Text("Complete"),
          content: Container(),
        )
      ];
}
