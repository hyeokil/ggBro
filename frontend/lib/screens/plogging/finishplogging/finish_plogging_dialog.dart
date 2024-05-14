import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/models/plogging_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/plogging/finishplogging/component/finish_clear_monster_content.dart';
import 'package:frontend/screens/plogging/finishplogging/component/finish_clear_monster_title.dart';
import 'package:provider/provider.dart';

class FinishPloggingDialog extends StatefulWidget {
  final int totalDistance, plastic, can, glass, normal, value, box;
  final List<Map<String, double>> path;

  const FinishPloggingDialog({
    super.key,
    required this.path,
    required this.totalDistance,
    required this.box,
    required this.can,
    required this.glass,
    required this.normal,
    required this.plastic,
    required this.value,
  });

  @override
  State<FinishPloggingDialog> createState() => _FinishPloggingDialogState();
}

class _FinishPloggingDialogState extends State<FinishPloggingDialog> {
  late UserProvider userProvider;
  late PloggingModel ploggingModel;
  late String accessToken;
  bool isLoadingData = false;
  late Map<String, dynamic> response;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    ploggingModel = Provider.of<PloggingModel>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    ploggingModel
        .finishPlogging(accessToken, widget.path, widget.totalDistance)
        .then((value) => {
              if (value == 'Success')
                {
                  setState(() {
                    response = ploggingModel.getFinishData();
                    isLoadingData = true;
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min, // 컬럼이 전체 다 차지 안하게
        children: [
          isLoadingData
              ? SizedBox(
                  // color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.37,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FinishClearMonsterTitle(
                        time: response['time'],
                      ),
                      FinishClearMonsterContent(
                        color: AppColors.basicpink,
                        content: '플라몽',
                        count: widget.plastic,
                      ),
                      FinishClearMonsterContent(
                        color: AppColors.basicgray,
                        content: '포캔몽',
                        count: widget.can,
                      ),
                      FinishClearMonsterContent(
                          color: AppColors.basicgreen,
                          content: '율몽',
                          count: widget.glass),
                      FinishClearMonsterContent(
                        color: AppColors.basicnavy,
                        content: '미쪼몬',
                        count: widget.normal,
                      ),
                      GestureDetector(
                        onTap: () {
                          var main =
                              Provider.of<MainProvider>(context, listen: false);
                          main.setIsTutorialPloggingFinish();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            color: AppColors.readyButton,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 3, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.basicgray.withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '확 인',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung80_white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
