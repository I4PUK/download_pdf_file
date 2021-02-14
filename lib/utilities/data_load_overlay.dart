import 'dart:async';

import 'package:flutter/material.dart';

class DataLoadOverlay {
  static Future<T> loadData<T>({
    @required BuildContext context,
    @required Future<T> futureFunc,
  }) async {
    final dialog = showDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(16),
              ),
              width: 56,
              height: 56,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            ),
          ),
        );
      },
    );

    try {
      final res = await futureFunc;
      await _closeOverlay(context, dialog);
      return res;
    } catch (error) {
      await _closeOverlay(context, dialog);
      rethrow;
    }
  }

  static Future<void> _closeOverlay(
      BuildContext context, Future<void> dialog) async {
    Navigator.pop(context);
    await dialog;
  }
}
