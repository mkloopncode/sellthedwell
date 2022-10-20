import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellthedwell/models/meeting_list_model.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/enums.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../agora/pages/call.dart';
import '../agora/pages/index.dart';
import 'package:http/http.dart' as http;

class TourRequests extends StatefulWidget {
  final TourRequest type;
  const TourRequests({Key? key, required this.type}) : super(key: key);

  @override
  State<TourRequests> createState() => _TourRequestsState();
}

class _TourRequestsState extends State<TourRequests> {
  final List<MeetingListModel> meetings = [];
  bool _loading = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getMeetings();
    });

    super.initState();
  }


  void _getMeetings() async {
    try {
      setState(() {
        _loading = true;
      });
      final List<MeetingListModel> res = (widget.type == TourRequest.SEND)
          ? await NetworkService.getSendMeetingsList()
          : await NetworkService.getRecieveMeetingsList();
      meetings.clear();
      meetings.addAll(res);
    } catch (e) {
      toast(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(context: context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.tourRequests,
              style: TextStyles.bigTitle,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressWidget())
                  : meetings.isEmpty
                      ? Center(
                          child: Text(Strings.noData),
                        )
                      : ListView.separated(
                          itemBuilder: (_, index) {
                            return TourRequestItem(
                              model: meetings[index],
                            );
                          },
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: meetings.length,
                          separatorBuilder: (_, __) => const Divider(
                            thickness: 1,
                            height: 24,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourRequestItem extends StatefulWidget {
  final MeetingListModel model;
  const TourRequestItem({Key? key, required this.model}) : super(key: key);

  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }

  @override
  State<TourRequestItem> createState() => _TourRequestItemState();
}

class _TourRequestItemState extends State<TourRequestItem> {
  @override
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  String token = '';
  String channel_name = '';



  getToken(var meeting_id) async {
    var data = {
      "meeting_id" : meeting_id.toString(),
    };
    final response = await http.post(
      Uri.parse("https://sellthedwell.com/api/createtoken"),
      body:  data,
      headers: await TourRequestItem.getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      if (result['status']) {
        print("Hello world");
        print(result['data']['token']);
        print(result['data']['session_id']);
        channel_name = result['data']['session_id'];
        token = result['data']['token'];
        return result['data']['token'];
      } else {
        toast(result['message']);
        throw Exception(result['message']);
      }
    } else {
      toast(Strings.somethingWentWrong);
      throw Exception(Strings.somethingWentWrong);
    }
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
          // await for camera and mic permissions before pushing video page
        if(widget.model.button == 'Join') {
          await getToken(widget.model.id);
          await _handleCameraAndMic(Permission.camera);
          await _handleCameraAndMic(Permission.microphone);
          // push video page with given channel name
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CallPage(
                    channelName: channel_name,
                    role: ClientRole.Broadcaster,
                    token: token,
                  ),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.model.propertyDetails?.name}",
                        style: TextStyles.heading2,
                      ),
                      Text(
                        "${widget.model.meetingDate}",
                        style: TextStyles.body2.copyWith(
                          color: ColorUtils.primary,
                        ),
                      ),
                      Text(
                        "Message:",
                        style: TextStyles.labelTextStyle,
                      ),
                      Text(
                        "${widget.model.message}",
                        style: TextStyles.body2,
                      ),
                    ],
                  ),
                ),
              ),
              CachedNetworkImage(
                errorWidget: (context, url, error) => CachedNetworkImage(
                  imageUrl: Konstants.defaultHousePic,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                ),
                imageUrl: widget.model.propertyDetails?.listimage ?? "",
                height: 64,
                width: 64,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "To: ${widget.model.messageReceiveByName}",
                        style: TextStyles.body2,
                      ),
                      Text(
                        "Email: ${widget.model.messageReceiveByEmail}",
                        style: TextStyles.body2,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorUtils.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${widget.model.button}",
                  style: TextStyles.body2.copyWith(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
