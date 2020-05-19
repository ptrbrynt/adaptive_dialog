import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/modal_action_sheet/material_modal_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_modal_action_sheet.dart';

export 'sheet_action.dart';

/// Show modal action sheet, whose appearance is adaptive according to platform

/// The [isDismissible] parameter only works for material style and it specifies
/// whether the bottom sheet will be dismissed when user taps on the scrim.
Future<T> showModalActionSheet<T>({
  @required BuildContext context,
  String title,
  String message,
  List<SheetAction<T>> actions = const [],
  String cancelLabel,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
  bool isDismissible = true,
  bool useRootNavigator = true,
}) {
  void pop(T key) => Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).pop(key);
  final theme = Theme.of(context);
  return style.isCupertinoStyle(theme)
      ? showCupertinoModalPopup(
          context: context,
          useRootNavigator: useRootNavigator,
          builder: (context) => CupertinoModalActionSheet(
            onPressed: pop,
            title: title,
            message: message,
            actions: actions,
            cancelLabel: cancelLabel,
          ),
        )
      : showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: isDismissible,
          useRootNavigator: useRootNavigator,
          clipBehavior: Clip.antiAlias,
          enableDrag: true,
          builder: (context) => MaterialModalActionSheet(
            onPressed: pop,
            title: title,
            message: message,
            actions: actions,
            cancelLabel: cancelLabel,
          ),
        );
}
