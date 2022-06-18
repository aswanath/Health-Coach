import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

part 'internet_event.dart';

part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  late StreamSubscription internetStream;
  OverlaySupportEntry? overlay;

  InternetBloc() : super(InternetInitial()) {
    internetStream = InternetConnectionChecker().onStatusChange.listen((event) {
      switch (event) {
        case InternetConnectionStatus.connected:
          if (overlay != null) {
            overlay!.dismiss();
          }
          if (sharedPreferences.getBool('isFirst') == false) {
            showSimpleNotification(
                Text(
                  "Your connection is back",
                  style: GoogleFonts.nunito(),
                ),
                background: commonGreen,
                elevation: 10);
          }
          break;
        case InternetConnectionStatus.disconnected:
          sharedPreferences.setBool('isFirst', false);
          overlay = showSimpleNotification(
              Text(
                "No internet available",
                style: GoogleFonts.nunito(),
              ),
              elevation: 10,
              background: commonBlack,
              autoDismiss: false);
          break;
      }
    });
  }

  @override
  Future<void> close() async {
    await internetStream.cancel();
    super.close();
  }
}
