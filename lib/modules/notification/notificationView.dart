import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/notification/notification_bloc.dart';
import '../../models/notification/notification_api.dart';
import '../../utils/screenUtil.dart';
import '../../utils/toast.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  int currentPage = 1;
  int maxPage = 0;
  final lsData = <NotificationModel>[];
  final _scrollController = ScrollController();
  BuildContext currentContext;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocProvider(
      create: (context) =>
          NotificationBloc()..add(NotificationFetchEvent(page: currentPage)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Scaffold(
            body: _buildView(context),
          ),
        ],
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('Load more data...');
      if (currentPage < maxPage) {
        currentPage += 1;
        print('currentPage = $currentPage');
        if (currentContext != null) {
          BlocProvider.of<NotificationBloc>(currentContext)
              .add(NotificationFetchEvent(page: currentPage));
        }
      }
    }
  }

  _setSetData() {
    maxPage = 0;
    currentPage = 1;
    lsData.clear();
    if (currentContext != null) {
      BlocProvider.of<NotificationBloc>(currentContext)
          .add(NotificationFetchEvent(page: currentPage));
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  Widget _buildView(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationFetchDoneState) {
          lsData.addAll(state.data.data);
          maxPage = state.data?.metaData?.totalPages ?? 0;
        }
        if (state is NotificationFetchFailState) {
          Toast.error(message: state.message ?? '');
        }
        if (state is NotificationExceptionState) {
          Toast.error(message: state.message ?? '');
        }
      },
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          currentContext = context;
          return Container(
            child: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    _setSetData();
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: List.generate(
                        lsData.length,
                        (index) {
                          final item = lsData[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.notifications),
                                title: Text(item?.title ?? ''),
                                subtitle: Text(
                                  item?.body ?? '',
                                ),
                                /* trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20.0,
                                ), */
                              ),
                              Divider()
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: (state is NotificationWaitingState)
                      ? Center(child: CupertinoActivityIndicator())
                      : SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
