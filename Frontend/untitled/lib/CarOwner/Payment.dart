
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Payment"),
        ),
        body:Padding(
        padding: const EdgeInsets.all(20),
        child: Expanded(
          child: Column(
            children: [
             Text("Transaction History", style:TextStyle(fontSize: 16)),


              Divider(),
                Container(
                  height: 200,
                  child: Card(
                    elevation: 3.0,
                    color: Colors.white,
                    child:Expanded(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         Text(""+getCurrentDate()),
                        Text("Cash on Service"),
                        ElevatedButton(onPressed: (){}, child: Text("Paid"),),
                      ],
                    ),
                    ),

                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
