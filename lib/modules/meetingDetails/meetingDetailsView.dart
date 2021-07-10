import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/meetingDetails/meetingDetailsModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:flutter/material.dart';

class MeetingDetailsView extends StatefulWidget {
  @override
  _MeetingDetailsViewState createState() => _MeetingDetailsViewState();
}

class _MeetingDetailsViewState extends State<MeetingDetailsView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<MeetingDetailsModel>(
      model: MeetingDetailsModel(),
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              appBar: AppAppBar(
                backgroundColor: AppColor.primary,
                allowBack: true,
              ),
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, MeetingDetailsModel model) {
    return Container(
      color: AppColor.primary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              model.meetingDetails.title,
              style: AppStyle.title1White,
            ),
          ),
          Text(
            model.meetingDetails.room,
            style: AppStyle.title1White,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.meetingDetails.start,
                  style: AppStyle.h0White,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColor.white,
                  ),
                ),
                Text(
                  model.meetingDetails.end,
                  style: AppStyle.h0White,
                ),
              ],
            ),
          ),
          Text(
            model.meetingDetails.time,
            style: AppStyle.title2White,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Người đặt: ${model.meetingDetails.title}',
              style: AppStyle.title2White,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: Text(
              model.meetingDetails.status,
              style: AppStyle.h1White,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              width: ScreenUtil.width,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Người tham gia (${model.meetingDetails.participants.length})',
                        style: AppStyle.h4,
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CircleAvatar(),
                            ),
                            Text(model.meetingDetails.participants[index])
                          ],
                        ),
                      ),
                      itemCount: model.meetingDetails.participants.length,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
