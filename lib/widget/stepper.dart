import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xpoint/model/demande.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _currentStep = 0;
  String? title;
  String? email;
  String? category;
  String? type;
  String? formula;
  String? engagementManger;
  String? engagementPartner;
  bool isChecked = false;
  String? country;
  String? city;
  String? code;
  String? comment;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  void onStepContine() {
    final isLastStep = _currentStep == getSteps().length - 1;

    if (!_formKeys[_currentStep].currentState!.validate()) {
      print('Please enter correct data');
    } else {
      _formKeys[_currentStep].currentState!.save();

      if (isLastStep) {
        print("object ...............");
        loginUser();
        return;
      }
      _currentStep += 1;
      setState(() {});
    }
  }

  void onStepCancel() {
    if (_currentStep == 0) {
      return;
    }
    _currentStep -= 1;
    setState(() {});
  }

  void loginUser() async {
    const String apiUrl = "http://192.168.1.16:3000/demande/create";
    DemandeElement demande = DemandeElement(
      formule: formula!,
      needTransport: isChecked,
      title: title!,
      type: type!,
      category: category!,
      city: city!,
      comment: comment!,
      country: country!,
      date: DateTime.now(),
      email: email!,
      engagementManager: engagementManger!,
      engagementPartner: engagementPartner!,
    );
    final Response = await http.post(apiUrl, body: demande.toJson());
    if (Response.statusCode == 200) {
      final String responseString = Response.body;
      // return userModelFromJson(responseString);
    } else if (Response.statusCode == 401) {
      throw Exception(showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Log In Error'),
          content: const Text(
            'Account is not activated! ou not found! ',
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text('OK'))
          ],
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
            primary: Colors.lightBlue.shade900, secondary: Colors.grey),
      ),
      child: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: _currentStep,
        onStepContinue: onStepContine,
        onStepCancel: onStepCancel,
        controlsBuilder: (context, details) {
          return Row(
            children: [
              if (_currentStep != 0)
                Expanded(
                    child: TextButton(
                        onPressed: onStepCancel, child: Text('Back'))),
              const SizedBox(
                width: 12,
              ),
              if (_currentStep == getSteps().length - 1)
                Expanded(
                    child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text('Submit'))),
              if (_currentStep != getSteps().length - 1)
                Expanded(
                    child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text('NEXT'))),
            ],
          );
        },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 0,
            title: const Text(
              "Informations",
              style: TextStyle(fontSize: 12),
            ),
            content: _informationWidget()),
        Step(
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 1,
          title: const Text(
            "Engagement",
            style: TextStyle(fontSize: 12),
          ),
          content: _managmentWidget(),
        ),
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 2,
          title: const Text(
            "Location",
            style: TextStyle(fontSize: 12),
          ),
          content: _LocationWidget(),
        )
      ];

  Widget _informationWidget() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.lightBlue.shade900;
      }
      return Colors.lightBlue.shade900;
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKeys[0],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Titel', border: OutlineInputBorder()),
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) => val!.isEmpty ? 'Entrez un Titel' : null,
              onChanged: (val) => title = val,
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Colors.lightBlue.shade900, width: 2)),
              child: DropdownButtonFormField<String>(
                value: category,
                hint: const Text("Category"),
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    category = newValue!;
                  });
                },
                validator: (value) => value == null ? 'field required' : null,
                items: <String>[
                  'Category 1',
                  'Category 2',
                  'Category 3',
                  'Category 4'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Colors.lightBlue.shade900, width: 2)),
              child: DropdownButtonFormField<String>(
                value: type,
                validator: (value) => value == null ? 'field required' : null,
                hint: const Text("Type"),
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    type = newValue!;
                  });
                },
                items: <String>['Type 1', 'Type 2', 'Type 3', 'Type 4']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Colors.lightBlue.shade900, width: 2)),
              child: DropdownButtonFormField<String>(
                value: formula,
                validator: (value) => value == null ? 'field required' : null,
                hint: const Text("Formula"),
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    formula = newValue!;
                  });
                },
                items: <String>[
                  'Formula 1',
                  'Formula 2',
                  'Formula 3',
                  'Formula 4'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
              validator: (val) => (val!.isEmpty || !val.contains('@'))
                  ? 'Please enter valid email'
                  : null,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (val) => email = val,
            ),
            Row(
              children: [
                const Text("Need Transport"),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _managmentWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[1],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Colors.lightBlue.shade900, width: 2)),
              child: DropdownButtonFormField<String>(
                value: engagementManger,
                hint: const Text("Engagment Manger"),
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    engagementManger = newValue!;
                  });
                },
                validator: (value) => value == null ? 'field required' : null,
                items: <String>[
                  'Engagment Manger 1',
                  'Engagment Manger 2',
                  'Engagment Manger 3',
                  'Engagment Manger 4'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Colors.lightBlue.shade900, width: 2)),
              child: DropdownButtonFormField<String>(
                value: engagementPartner,
                hint: const Text("Engagment Partner "),
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    engagementPartner = newValue!;
                  });
                },
                validator: (value) => value == null ? 'field required' : null,
                items: <String>[
                  'Engagment Partner 1',
                  'Engagment Partner 2',
                  'Engagment Partner 3',
                  'Engagment Partner 4'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Engagment Code', border: OutlineInputBorder()),
              validator: (val) => val!.isEmpty ? 'Entrez un Code' : null,
              onChanged: (val) => code = val,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ],
        ),
      ),
    );
  }

  Widget _LocationWidget() {
    DateTime selectedDate = DateTime.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKeys[2],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Country', border: OutlineInputBorder()),
              validator: (val) => val!.isEmpty ? 'Entrez Country' : null,
              onChanged: (val) => country = val,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'City', border: OutlineInputBorder()),
              validator: (val) => val!.isEmpty ? 'Entrez City' : null,
              onChanged: (val) => city = val,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                      onPressed: () => _selectDate(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            " The full time of your Misson",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              maxLines: 2,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  labelText: 'Comments', border: OutlineInputBorder()),
              validator: (val) => val!.isEmpty ? 'Entrez Comments' : null,
              onChanged: (val) => comment = val,
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}
