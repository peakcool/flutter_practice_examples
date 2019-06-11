import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_startup_logic/stateful_wrapper.dart';

void main() => runApp(MyApp());

enum StartupState { Busy, Success, Error }

class MyApp extends StatelessWidget {

  final StreamController<StartupState> _startupStatus = StreamController<StartupState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: StateFulWrapper(
          onInit: () => getImportantData(isError: true),
          child: StreamBuilder(
              stream: _startupStatus.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == StartupState.Busy) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Show your app logo here'),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('${snapshot.error} Retry?'),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            size: 55
                          ),
                          onPressed: () {
                            getImportantData();
                          },
                        )
                      ],
                    ),
                  );
                }

                return Container(color: Colors.yellow,);
              }
          ),
        ),
      ),
    );
  }

  Future getImportantData({bool isError = false}) async {
    _startupStatus.add(StartupState.Busy);

    await Future.delayed(Duration(seconds: 10));

    if (isError) {
      _startupStatus.add(StartupState.Error);
    } else {
      _startupStatus.add(StartupState.Success);
    }
  }
}