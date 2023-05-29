
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:intl/intl.dart';

import '../widget/RatingActionSheet.dart';


class TrackStatus extends StatefulWidget {
  const TrackStatus({Key? key}) : super(key: key);

  @override
  State<TrackStatus> createState() => _TrackStatusState();

}

class _TrackStatusState extends State<TrackStatus> {

//
//
//   List<TextDto> orderList = [
//     TextDto("Your request has been sent to Mechanic", DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())),
//   ];
//
//   List<TextDto> shippedList = [
//     TextDto("Mechanic has approved your request", DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())),
//   ];
//
//   List<TextDto> outOfDeliveryList = [
//     TextDto("Mechanic is on his way to fix your Vehicle within 45 mins", DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now().add(Duration(minutes: 45)))),
//   ];
//
//   List<TextDto> deliveredList = [
//     TextDto("Payment through Cash Recieved", DateFormat('dd-MM-yyyy').format(DateTime.now())),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text("Track Status"),
//         ),
//         body:Padding(
//         padding: const EdgeInsets.all(20),
//         child: Card(
//           elevation: 3.0,
//           color: Colors.white,
//           child: OrderTracker(
//             status: Status.delivered,
//             activeColor: Colors.deepPurpleAccent,
//             inActiveColor: Colors.brown,
//             orderTitleAndDateList: orderList,
//             shippedTitleAndDateList: shippedList,
//             outOfDeliveryTitleAndDateList: outOfDeliveryList,
//             deliveredTitleAndDateList: deliveredList,
//           ),
//         ),
//       ),
//     );
//   }
// }
  String _orderStatus = 'Requested Service';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order status', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Container(

              child: Card(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Current status:'),
                    Text(_orderStatus),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Update status'),
              onPressed: () {
                _updateStatus();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateStatus() {
    setState(() {
      if (_orderStatus == 'Requested Service') {
        _orderStatus = 'Accepted Request';
      } else if (_orderStatus == 'Accepted Request') {
        _orderStatus = 'Mechanic on his way to fix';
      } else if (_orderStatus == 'Mechanic on his way to fix') {
        _orderStatus = 'Please pay Mechanic on Cash.';
      } else {
        _orderStatus = 'Paid';
        if (_orderStatus == 'Paid') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Would you like to rate the Service?"),
                    actions: <Widget>[
                      TextButton(
                        child: new Text('OK'),
                        onPressed: () {
                          _showRatingActionSheet(context);
                        },
                      )
                    ]);
              });
        }
      }
    });
  }
}
void _showRatingActionSheet(BuildContext context) async {
  int selectedRating = await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return RatingActionSheet();
    },
  );

  // Do something with selectedRating value (e.g. save to database)

}