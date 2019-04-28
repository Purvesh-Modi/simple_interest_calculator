import 'package:flutter/material.dart';

void main() => runApp(SimpleInterestCalculator());

class SimpleInterestCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleInterestCalculatorState();
  }
}

class _SimpleInterestCalculatorState extends State<SimpleInterestCalculator> {
  var _formKey = GlobalKey<FormState>();

  final double _minimumPadding = 5.0;
  var _currencies = ['Rupees', 'Dollor', 'Pounds'];

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController amountController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calcularor App",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        primaryColorLight: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Interest Calcularor'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getMoneyImage(),
                Padding(
                  padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding,
                  ),
                  child: TextFormField(
                    style: textStyle,
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (String value) => _validateTextField(
                          value,
                          "Please enter principal amount.",
                        ),
                    decoration: InputDecoration(
                      labelText: 'Principal Amount',
                      labelStyle: textStyle,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.yellowAccent,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      hintText: 'Enter Principal Amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: interestRateController,
                    style: textStyle,
                    validator: (String value) => _validateTextField(
                          value,
                          "Please enter rate of interest.",
                        ),
                    decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      labelStyle: textStyle,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.yellowAccent,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      hintText: 'Rate of Interest in Percentage',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termController,
                          validator: (String value) => _validateTextField(
                                value,
                                "Please enter term in year.",
                              ),
                          decoration: InputDecoration(
                            labelText: 'Terms',
                            labelStyle: textStyle,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.yellowAccent,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            hintText: 'In Years',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: _minimumPadding * 5,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String dropDownItemValue) {
                            return DropdownMenuItem<String>(
                              value: dropDownItemValue,
                              child: Text(
                                dropDownItemValue,
                                style: textStyle,
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                          value: _currentItemSelected,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Colors.black,
                          child: Text(
                            'Calculate',
                            textScaleFactor: 1.25,
                          ),
                          onPressed: () => _calculateTotalReturns(),
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.25,
                          ),
                          onPressed: () => _resetFields(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getMoneyImage() => Container(
        child: Image(
          image: AssetImage('images/money.png'),
          width: 125.0,
          height: 125.0,
        ),
        margin: EdgeInsets.all(_minimumPadding * 10),
      );

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
  }

  void _calculateTotalReturns() {
    setState(() {
      if (_formKey.currentState.validate()) {
        double amount = double.parse(amountController.text);
        double rate = double.parse(interestRateController.text);
        double timeInYears = double.parse(termController.text);

        double totalAmount = amount + ((amount * rate * timeInYears) / 100);

        displayResult =
            "After $timeInYears years, your investment will be worth"
            " $totalAmount $_currentItemSelected";
      }
    });
  }

  void _resetFields(BuildContext context) {
    setState(() {
      amountController.text = '';
      interestRateController.text = '';
      termController.text = '';
      FocusScope.of(context).requestFocus(null);
      _currentItemSelected = _currencies[0];

      displayResult = '';
    });
  }

  String _validateTextField(String value, String errorMessage) {
    if (value.isEmpty) {
      return errorMessage;
    }
  }
}
