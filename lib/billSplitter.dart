import 'package:flutter/material.dart';

import 'hexColor.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({super.key});

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  Color _purple = HexColor("#6908D6");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bill Spiltter',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20),
          children: [
            Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: _purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Per Person',
                        style: TextStyle(
                          color: _purple,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          '\$${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}',
                          style: TextStyle(
                            color: _purple,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.grey.shade500,
                      style: BorderStyle.solid,)),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      labelText: 'Enter Amount'
                    ),
                    onChanged: (String value){
                      try{
                        _billAmount = double.parse(value);
                      }
                      catch (e){
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Split',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: _purple.withOpacity(.2)
                              ),
                              child: Icon(Icons.remove, color: _purple,),
                            ),
                          ),
                          Text('$_personCounter', style: TextStyle(fontWeight: FontWeight.w700, color: _purple),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            decoration: BoxDecoration(
                              color: _purple.withOpacity(.2),
                              borderRadius: BorderRadius.circular(7)
                            ),
                            child: Icon(Icons.add, color: _purple,),
                          ),
                          )
                        ],
                      )
                    ],
                  ),

                  Container(margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tip', style: TextStyle(color: Colors.grey.shade700),),
                        Text(
                          '\$${(calculateTotalTip(_tipPercentage, _billAmount, _personCounter)).toStringAsFixed(2)}',
                          style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  //Slider
                  Column(
                    children: [
                      Text(
                        '$_tipPercentage%',
                        style: TextStyle(
                            color: _purple,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),

                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey.shade400,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double slidingValue) {
                            setState(() {
                              _tipPercentage = slidingValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  //to know how much each person will pay in case they are more than one, we pass the billamount, spiltby is the amount of people. 
  // The reason why we are calling tipPercentage is because
  // we are calling the calculateTotalTip inside the function to use its value
  calculateTotalPerPerson (double billAmount, int spiltBy, int tipPercentage){

    var totalPerPerson = (billAmount + calculateTotalTip(tipPercentage, billAmount, spiltBy)) / spiltBy;

    return totalPerPerson.toStringAsFixed(2);

  }
  
  
  //we pass the tip percentage and the bil amount, so we can get the value for the tip 
  calculateTotalTip (int tipPercentage, double billAmount, int splitBy){
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){
      //do nothing
    }else{
      totalTip = (tipPercentage * billAmount)/100;
    }
    return totalTip;
  }
}
