import 'package:flutter/material.dart';

class MaterialEntidadPage extends StatefulWidget {
  const MaterialEntidadPage({super.key});

  @override
  State<MaterialEntidadPage> createState() => _MaterialEntidadPageState();
}

class _MaterialEntidadPageState extends State<MaterialEntidadPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Material Page')),
          ],
        )),
      ],
    );
  }
}