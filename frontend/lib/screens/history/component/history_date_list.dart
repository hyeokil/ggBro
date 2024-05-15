import 'package:flutter/material.dart';

class HistoryDateList extends StatefulWidget {
  final Map<String, dynamic> dateHistoryList;

  const HistoryDateList({
    super.key, required this.dateHistoryList,
  });

  @override
  State<HistoryDateList> createState() => _HistoryDateListState();
}

class _HistoryDateListState extends State<HistoryDateList> {
  @override
  Widget build(BuildContext context) {
    return Text('${widget.dateHistoryList}');
  }
}
