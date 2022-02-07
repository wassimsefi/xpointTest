import 'package:flutter/material.dart';
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
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                  child: StepperWidget(),
                ),
              );
            },
            initialChildSize: 0.75,
            minChildSize: 0.5,
          ),

          //draggable sheet
        ],
      ),
    );
  }
}
