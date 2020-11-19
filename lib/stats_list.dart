import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatList extends StatelessWidget {

  final String title;
  final int covidresult;
  final Color backgroundColor;

  const StatList({Key key, this.title, this.covidresult, this.backgroundColor})
      : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Expanded(
            child: Text(
              '${NumberFormat("#,###").format(covidresult) ?? ""}',
              style: TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

