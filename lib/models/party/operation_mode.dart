/// 切換戰鬥顯示
enum OperationMode {
  commonMode, // 一般模式：角色立繪顯示
  skillMode, // 技能模式：技能顯示
}

// 切換單一角色顯示
enum CharacterDisplayMode {
  common, // 角色一般顯示
  skill, // 角色技能顯示
}

bool isCommonMode({required OperationMode mode}) {
  if (mode == OperationMode.commonMode) {
    return true;
  } else {
    return false;
  }
}
