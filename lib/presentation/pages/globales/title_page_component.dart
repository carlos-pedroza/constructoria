import 'package:flutter/material.dart';

class TitlePageComponent extends StatelessWidget {
  const TitlePageComponent({super.key, required this.onClose});

  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height:50,
            child: Image.asset('assets/images/logo_small.png', fit: BoxFit.fitHeight)
          ),
          IconButton(
            onPressed: onClose, 
            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}