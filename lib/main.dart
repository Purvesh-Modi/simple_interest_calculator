import 'package:flutter/material.dart';

void main() => runApp(SimpleInterestCalculator());

class SimpleInterestCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleInterestCalculatorState();
  }
}

class _SimpleInterestCalculatorState extends State<SimpleInterestCalculator> {
  var _minimumPadding = 5.0;
  var _currencies = ['Rupees', 'Dollor', 'Pounds', 'Others'];

  String _currentItemSelected = 'Rupees';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calcularor App",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Interest Calcularor'),
        ),
        body: Container(
          margin: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getMoneyImage(),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: TextField(
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Principal Amount',
                    labelStyle: textStyle,
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
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    labelStyle: textStyle,
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
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        decoration: InputDecoration(
                          labelText: 'Terms',
                          labelStyle: textStyle,
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
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.black,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.25,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minimumPadding * 2),
                child: Text(
                  "Todo Text",
                  style: textStyle,
                ),
              ),
            ],
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
}
