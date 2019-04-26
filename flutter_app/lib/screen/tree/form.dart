import 'package:flutter/material.dart';
import 'package:multi_page_form/multi_page_form.dart';

class FormTree extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiPageForm(
        totalPage: 3,
        pageList: <Widget>[page1(), page2(), page3()],
        onFormSubmitted: () {
          print("Form is submitted");
           Navigator.of(context).pop();
        },
    );
  }
   Widget page1() {
      return Container(
        child: ListView(
          children: [
            Container(
              height: 20.0,
              width: 20.0,
              color: Colors.purple,
            ),
            Container(
              height: 20.0,
              width: 20.0,
              color: Colors.blue,
            )
          ],
        ),
      );
    }
  
    Widget page2() {
      return Container(
        child: ListView(
          children: [
            Container(
              height: 200.0,
              width: 200.0,
              color: Colors.yellow,
            )
          ],
        ),
      );
    }
  
    Widget page3() {
      return Container(
        child: ListView(
          children: [
            Container(
              height: 200.0,
              width: 200.0,
              color: Colors.green,
            )
          ],
        ),
      );
  }

  
}