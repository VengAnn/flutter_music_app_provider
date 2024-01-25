import 'package:flutter/material.dart';
import 'package:music_player/themes/themes_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          // darker shadow on bottom right
          BoxShadow(
            color: isDarkMode ? Colors.black : Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(2, 2),
          ),

          // lighter shawdow on top left
          BoxShadow(
            color: isDarkMode ? Colors.grey.shade700 : Colors.white,
            blurRadius: 10,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: child,
    );
  }
}
