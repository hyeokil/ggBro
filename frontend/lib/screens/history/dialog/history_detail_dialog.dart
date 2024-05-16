import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/history_model.dart';
import 'package:provider/provider.dart';

class HistoryDetailDialog extends StatefulWidget {
  final String date;
  final String time;

  const HistoryDetailDialog({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  State<HistoryDetailDialog> createState() => _HistoryDetailDialogState();
}

class _HistoryDetailDialogState extends State<HistoryDetailDialog> {
  late HistoryModel historyModel;
  late Map<String,  dynamic> historyDetail;

  @override
  void initState() {
    super.initState();

    historyModel = Provider.of<HistoryModel>(context, listen: false);
    historyDetail = historyModel.getDetailHistory();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                  padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    color: AppColors.help,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.date}',
                        style: CustomFontStyle.getTextStyle(
                          context,
                          CustomFontStyle.yeonSung70_white,
                        ),
                      ),
                      Text(
                        '${widget.time}',
                        style: CustomFontStyle.getTextStyle(
                          context,
                          CustomFontStyle.yeonSung60_white,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEBF5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.basicgreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        FontAwesomeIcons.circleXmark,
                        size: 40,
                        color: Color(0xFFEEEBF5),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(color: Colors.black),
              child: Text('$historyDetail', style: CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung50_white),),
            ),
          ],
        ),
      ),
      // actions: <Widget>[
      //   GreenButton(
      //     "취소",
      //     onPressed: () => Navigator.of(context).pop(), // 모달 닫기
      //   ),
      //   RedButton(
      //     "종료",
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //       onConfirm();
      //     },
      //   ),
      // ],
    );
    ;
  }
}
