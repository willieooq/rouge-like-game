// // 檔案位置: lib/widgets/character_card.dart
// // 顯示單一角色信息的UI組件
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// // ConsumerWidget = 可以使用Riverpod的Widget
// // 類似在Java Spring中注入@Autowired的Component
// class CharacterCard extends ConsumerWidget {
//   const CharacterCard({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // ref.watch() = 訂閱狀態變化，當Character改變時自動重建UI
//     final character = ref.watch(characterProvider);
//     final notifier = ref.read(characterProvider.notifier);
//
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 角色名稱
//             Text(
//               character.name,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//
//             // 攻擊力顯示
//             Text('攻擊力: ${character.attackPower}'),
//             const SizedBox(height: 16),
//
//             // 技能按鈕區域
//             const Text('技能:', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 // 斬擊技能按鈕 (Cost: 2)
//                 // Expanded(
//                 //   child: ElevatedButton(
//                 //     onPressed: notifier.canUseSkill(2)
//                 //         ? () => notifier.useSkill(2)
//                 //         : null, // null = 按鈕禁用
//                 //     child: const Text('斬擊 (2)'),
//                 //   ),
//                 // ),
//                 // const SizedBox(width: 8),
//                 // // 重擊技能按鈕 (Cost: 4)
//                 // Expanded(
//                 //   child: ElevatedButton(
//                 //     onPressed: notifier.canUseSkill(4)
//                 //         ? () => notifier.useSkill(4)
//                 //         : null,
//                 //     child: const Text('重擊 (4)'),
//                 //   ),
//                 // ),
//               ],
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }
