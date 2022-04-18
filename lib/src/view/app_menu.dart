import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.panorama_fish_eye,
              size: 15.0,
            ),
            label: const Text("Iniciar"),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              size: 15.0,
            ),
            label: const Text("Finalizar"),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.local_print_shop,
              size: 15.0,
            ),
            label: const Text("Imprimir Termo"),
          )
        ],
      );
  }
}