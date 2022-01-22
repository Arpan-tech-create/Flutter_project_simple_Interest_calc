import "package:flutter/material.dart";
void main(){

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner:false,
        title:'Sample Calc',
        home:SIForm(),
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.pink,
            accentColor: Colors.lightBlueAccent
        ),
      )
  );
}
class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}
class _SIFormState extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double _minimumPadding = 5.0;
  var _currentItemSelected='';
  @override
  void initState(){
    super.initState();
    _currentItemSelected=_currencies[0];

  }
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult='';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;
    return Scaffold(
      appBar: AppBar(
        title: Text('simple Interest calc'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  decoration: InputDecoration(
                      hintStyle: textStyle,
                      labelText: 'The Principal',
                      hintText: 'Enter the Principal e.g.. 13000',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In Percent',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in Years',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    )),
                    Container(width: _minimumPadding * 5,),
                    Expanded(child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value:_currentItemSelected,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    bottom: _minimumPadding, top: _minimumPadding),
                child: Row(children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme
                          .of(context)
                          .accentColor,
                      textColor: Theme
                          .of(context)
                          .primaryColorDark,
                      child: Text('Calculate', textScaleFactor: 1.5,),
                      onPressed: () {
                        setState(() {
                          this.displayResult= _calculateTotalReturns();
                        });

                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme
                          .of(context)
                          .primaryColorDark,
                      textColor: Theme
                          .of(context)
                          .primaryColorLight,
                      child: Text('Reset', textScaleFactor: 1.5,),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });

                      },
                    ),
                  ),
                ],)),
            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text(this.displayResult, style: textStyle,),
            )
          ],
        ),

      ),
    );
  }
  Widget getImageAsset(){
    AssetImage assetImage =AssetImage('download.png');
    Image image=Image(image:assetImage,width: 126.0,height: 126.0,);
    return Container(child: image,margin: EdgeInsets.all(_minimumPadding *10),);
  }
  void _onDropDownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected=newValueSelected;
    });

  }
  String _calculateTotalReturns(){
    double principal=double.parse(principalController.text);
    double roi=double.parse(roiController.text);
    double term=double.parse(termController.text);
    double totalAmountpayable=principal + (principal * roi*term)/100;
    String result ='After $term years ,your investment will be worth $totalAmountpayable $_currentItemSelected';
    return result;

  }
  void _reset(){
    principalController.text='';
    roiController.text='';
    termController.text='';
    displayResult='';
    _currentItemSelected=_currencies[0];
  }
}