// lib/widgets/enemy/enemy_renderer.dart
import 'package:flutter/material.dart';

import '../../constants/font_constants.dart';
import '../../models/enemy/enemy.dart';

/// 敵人渲染器工廠類 - 參考 CharacterRenderer 設計
class EnemyRenderer {
  static const double _defaultCardWidth = 150.0;
  static const double _defaultCardHeight = 200.0;

  /// 渲染敵人卡片 - 主要入口點
  static Widget renderEnemyCard({
    required Enemy enemy,
    required VoidCallback? onTap,
    double cardWidth = _defaultCardWidth,
    double cardHeight = _defaultCardHeight,
    bool showStats = true,
    bool showHpBar = true,
    bool isSelected = false,
    bool isTargeted = false,
  }) {
    return SizedBox(
      child: Expanded(
        child: _buildEnemyCard(
          enemy: enemy,
          onTap: onTap,
          cardWidth: cardWidth,
          cardHeight: cardHeight,
          showStats: showStats,
          showHpBar: showHpBar,
          isSelected: isSelected,
          isTargeted: isTargeted,
        ),
      ),
    );
  }

  /// 構建敵人卡片
  static Widget _buildEnemyCard({
    required Enemy enemy,
    required VoidCallback? onTap,
    required double cardWidth,
    required double cardHeight,
    required bool showStats,
    required bool showHpBar,
    required bool isSelected,
    required bool isTargeted,
  }) {
    return GestureDetector(
      onTap: enemy.isDead ? null : onTap,
      child: AnimatedContainer(
        width: cardWidth,
        height: cardHeight,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getBorderColor(enemy, isSelected, isTargeted),
            width: isSelected || isTargeted ? 3 : 1.5,
          ),
          boxShadow: [
            if (isSelected || isTargeted)
              BoxShadow(
                color: _getBorderColor(
                  enemy,
                  isSelected,
                  isTargeted,
                ).withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getCardGradient(enemy),
          ),
        ),
        child: Stack(
          children: [
            // 背景圖案
            _buildBackgroundPattern(enemy, cardWidth, cardHeight),

            // 主要內容
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 敵人圖標和名稱區域
                  _buildEnemyHeader(enemy, cardWidth),

                  // 中間部分：血量條和統計
                  Column(
                    children: [
                      if (showHpBar) _buildHpBar(enemy, cardWidth),
                      if (showHpBar && showStats) const SizedBox(height: 8),
                      if (showStats) _buildStatsSection(enemy, cardWidth),
                    ],
                  ),

                  // 底部：狀態效果
                  if (enemy.statusEffects.isNotEmpty)
                    _buildStatusEffects(enemy, cardWidth)
                  else
                    const SizedBox(height: 16),
                ],
              ),
            ),

            // 死亡遮罩
            if (enemy.isDead) _buildDeathOverlay(cardWidth, cardHeight),

            // 類型標籤
            _buildTypeLabel(enemy),
          ],
        ),
      ),
    );
  }

  /// 構建敵人頭部區域
  static Widget _buildEnemyHeader(Enemy enemy, double cardWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // 敵人圖標
          Container(
            width: cardWidth * 0.4,
            height: cardWidth * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(
                int.parse(enemy.primaryColor.replaceFirst('#', '0xFF')),
              ),
              border: Border.all(
                color: Color(
                  int.parse(enemy.secondaryColor.replaceFirst('#', '0xFF')),
                ),
                width: 2,
              ),
            ),
            child: Icon(
              _getEnemyIcon(enemy.type),
              color: Colors.white,
              size: cardWidth * 0.2,
            ),
          ),

          const SizedBox(height: 4),

          // 敵人名稱
          Text(
            enemy.name,
            style: TextStyle(
              fontSize: EnemyFontSizes.enemyNameFontFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// 構建血量條
  static Widget _buildHpBar(Enemy enemy, double cardWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: cardWidth * 0.1),
      child: Column(
        children: [
          // HP 文字
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HP',
                style: TextStyle(
                  fontSize: EnemyFontSizes.enemyHPFontRadio,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${enemy.currentHp}/${enemy.maxHp}',
                style: TextStyle(
                  fontSize: EnemyFontSizes.enemyHPFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 2),

          // HP 條
          Container(
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.black26,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: enemy.hpPercentage,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getHpBarColor(enemy.hpPercentage),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 構建統計信息
  static Widget _buildStatsSection(Enemy enemy, double cardWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: cardWidth * 0.1, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatIcon(
            icon: Icons.shelves,
            value: enemy.attack.toString(),
            color: Colors.red[300]!,
            cardWidth: cardWidth,
          ),
          _buildStatIcon(
            icon: Icons.shield,
            value: enemy.defense.toString(),
            color: Colors.blue[300]!,
            cardWidth: cardWidth,
          ),
          _buildStatIcon(
            icon: Icons.speed,
            value: enemy.speed.toString(),
            color: Colors.green[300]!,
            cardWidth: cardWidth,
          ),
        ],
      ),
    );
  }

  /// 構建統計圖標
  static Widget _buildStatIcon({
    required IconData icon,
    required String value,
    required Color color,
    required double cardWidth,
  }) {
    return Column(
      children: [
        Icon(icon, size: cardWidth * 0.12, color: color),
        Text(
          value,
          style: TextStyle(
            fontSize: UIFontSizes.battleStatFontSize,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// 構建狀態效果
  static Widget _buildStatusEffects(Enemy enemy, double cardWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Wrap(
        spacing: 2,
        children: enemy.statusEffects.take(3).map((effect) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: _getStatusEffectColor(effect),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              effect,
              style: TextStyle(
                fontSize: UIFontSizes.statusEffectsFontSize,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 構建背景圖案
  static Widget _buildBackgroundPattern(
    Enemy enemy,
    double cardWidth,
    double cardHeight,
  ) {
    return Positioned.fill(
      child: CustomPaint(
        painter: EnemyPatternPainter(
          type: enemy.type,
          primaryColor: Color(
            int.parse(enemy.primaryColor.replaceFirst('#', '0xFF')),
          ),
          secondaryColor: Color(
            int.parse(enemy.secondaryColor.replaceFirst('#', '0xFF')),
          ),
        ),
      ),
    );
  }

  /// 構建死亡遮罩
  static Widget _buildDeathOverlay(double cardWidth, double cardHeight) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(Icons.close, color: Colors.red, size: cardWidth * 0.3),
      ),
    );
  }

  /// 構建類型標籤
  static Widget _buildTypeLabel(Enemy enemy) {
    if (enemy.type == EnemyType.normal) return const SizedBox.shrink();

    return Positioned(
      top: 4,
      right: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: _getTypeLabelColor(enemy.type),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _getTypeLabelText(enemy.type),
          style: const TextStyle(
            fontSize: 8,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 輔助方法
  static Color _getBorderColor(Enemy enemy, bool isSelected, bool isTargeted) {
    if (enemy.isDead) return Colors.grey;
    if (isTargeted) return Colors.red;
    if (isSelected) return Colors.yellow;
    return Color(int.parse(enemy.secondaryColor.replaceFirst('#', '0xFF')));
  }

  static List<Color> _getCardGradient(Enemy enemy) {
    if (enemy.isDead) {
      return [Colors.grey[800]!, Colors.grey[900]!];
    }

    Color primary = Color(
      int.parse(enemy.primaryColor.replaceFirst('#', '0xFF')),
    );
    return [primary.withOpacity(0.8), primary.withOpacity(0.6)];
  }

  static IconData _getEnemyIcon(EnemyType type) {
    switch (type) {
      case EnemyType.normal:
        return Icons.pest_control;
      case EnemyType.elite:
        return Icons.dangerous;
      case EnemyType.boss:
        return Icons.casino;
    }
  }

  static Color _getHpBarColor(double hpPercentage) {
    if (hpPercentage > 0.6) return Colors.green;
    if (hpPercentage > 0.3) return Colors.orange;
    return Colors.red;
  }

  static Color _getStatusEffectColor(String effect) {
    switch (effect.toLowerCase()) {
      case 'poison':
        return Colors.purple;
      case 'burn':
        return Colors.orange;
      case 'freeze':
        return Colors.cyan;
      case 'stun':
        return Colors.yellow[700]!;
      default:
        return Colors.grey;
    }
  }

  static Color _getTypeLabelColor(EnemyType type) {
    switch (type) {
      case EnemyType.elite:
        return Colors.purple;
      case EnemyType.boss:
        return Colors.red[800]!;
      case EnemyType.normal:
        return Colors.grey;
    }
  }

  static String _getTypeLabelText(EnemyType type) {
    switch (type) {
      case EnemyType.elite:
        return 'ELITE';
      case EnemyType.boss:
        return 'BOSS';
      case EnemyType.normal:
        return '';
    }
  }
}

/// 敵人背景圖案繪製器
class EnemyPatternPainter extends CustomPainter {
  final EnemyType type;
  final Color primaryColor;
  final Color secondaryColor;

  EnemyPatternPainter({
    required this.type,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = secondaryColor.withOpacity(0.2);

    switch (type) {
      case EnemyType.normal:
        _drawDotPattern(canvas, size, paint);
        break;
      case EnemyType.elite:
        _drawDiamondPattern(canvas, size, paint);
        break;
      case EnemyType.boss:
        _drawSpikesPattern(canvas, size, paint);
        break;
    }
  }

  void _drawDotPattern(Canvas canvas, Size size, Paint paint) {
    const spacing = 20.0;
    paint.style = PaintingStyle.fill;

    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  void _drawDiamondPattern(Canvas canvas, Size size, Paint paint) {
    const spacing = 25.0;

    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        final path = Path()
          ..moveTo(x, y - 3)
          ..lineTo(x + 3, y)
          ..lineTo(x, y + 3)
          ..lineTo(x - 3, y)
          ..close();
        canvas.drawPath(path, paint);
      }
    }
  }

  void _drawSpikesPattern(Canvas canvas, Size size, Paint paint) {
    paint.strokeWidth = 2;

    for (double y = 15; y < size.height; y += 20) {
      final path = Path()..moveTo(0, y);

      for (double x = 0; x < size.width; x += 10) {
        path.lineTo(x + 5, y - 5);
        path.lineTo(x + 10, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
