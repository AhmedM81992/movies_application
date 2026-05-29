import 'package:flutter/material.dart';
import 'package:movies_app/core/shared_widgets/app_bar_widget.dart';

class UnDefinedRoute extends StatelessWidget {
  const UnDefinedRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          const AppBarWidget(title: "DefinedRoute"),
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
