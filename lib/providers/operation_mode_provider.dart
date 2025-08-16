import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/battle/operation_mode.dart';

/// 戰鬥模式顯示切換
class OperationModeNotifier extends StateNotifier<OperationMode> {
  OperationModeNotifier() : super(OperationMode.commonMode); // 預設一般模式

  void switchMode() {
    // 在commonMode和skillMode之間切換
    state = state == OperationMode.commonMode
        ? OperationMode.skillMode
        : OperationMode.commonMode;
  }
}

final operationModeProvider =
    StateNotifierProvider<OperationModeNotifier, OperationMode>((ref) {
      return OperationModeNotifier();
    });
