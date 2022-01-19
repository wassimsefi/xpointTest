import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _currentStep = 0;

  void onStepContine() {
    final isLastStep = _currentStep == getSteps().length - 1;

    final FormState? formState = _formKey.currentState;

    if (!formState!.validate()) {
      print('Please enter correct data');
    } else {
      formState.save();

      if (isLastStep) {
        return print("object ...............");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: Colors.lightBlue.shade900),
        ),
        child: Form(
          key: _formKey,
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
                    SizedBox(
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
              }),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 0,
            title: Text("Informations"),
            content: _informationWidget()),
        Step(
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 1,
          title: Text("Engagement"),
          content: Center(child: Text("Complete")),
        ),
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 2,
          title: Text("Location"),
          content: Center(child: Text("Complete")),
        )
      ];
  final _formKey = GlobalKey<FormState>();

  Widget _informationWidget() {
    String nomComplet = '';
    String email = '';
    String dropdownValue = 'One';
    bool isChecked = false;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Nom complet', border: OutlineInputBorder()),
            validator: (val) => val!.isEmpty ? 'Entrez un nom' : null,
            onChanged: (val) => nomComplet = val,
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.lightBlue.shade900, width: 2)),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
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
                border: Border.all(color: Colors.lightBlue.shade900, width: 2)),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
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
                border: Border.all(color: Colors.lightBlue.shade900, width: 2)),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Email', border: OutlineInputBorder()),
            validator: (val) => (val!.isEmpty || !val.contains('@'))
                ? 'Please enter valid email'
                : null,
            onChanged: (val) => email = val,
          ),
          Row(
            children: [
              Text("Need Transport"),
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
    );
  }

  Widget _managmentWidget() {
    String code = '';
    String email = '';
    String dropdownValue = 'One';
    bool isChecked = false;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.lightBlue.shade900, width: 2)),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
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
                border: Border.all(color: Colors.lightBlue.shade900, width: 2)),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Engagment Code', border: OutlineInputBorder()),
            validator: (val) => val!.isEmpty ? 'Entrez un Code' : null,
            onChanged: (val) => code = val,
          ),
        ],
      ),
    );
  }

  Widget _LocationWidget() {
    String nomComplet = '';
    String email = '';
    String dropdownValue = 'One';
    bool isChecked = false;

    DateTime selectedDate = DateTime.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Contry', border: OutlineInputBorder()),
            validator: (val) => val!.isEmpty ? 'Entrez Contry' : null,
            onChanged: (val) => nomComplet = val,
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'City', border: OutlineInputBorder()),
            validator: (val) => val!.isEmpty ? 'Entrez City' : null,
            onChanged: (val) => nomComplet = val,
          ),
          const SizedBox(height: 10.0),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("${selectedDate.toLocal()}".split(' ')[0]),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            maxLines: 2,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Comments', border: OutlineInputBorder()),
            validator: (val) => val!.isEmpty ? 'Entrez Comments' : null,
            onChanged: (val) => nomComplet = val,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}
