import 'package:flutter/material.dart';

class Busca extends StatelessWidget {
  const Busca({ Key? key }) : super(key: key);

  static const List<String> _kOptions = <String>[
    'exemplo 1',
    'exemplo 2',
    'exemplo 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: ((textEditingValue) {
        if(textEditingValue.text == ''){
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String element) => element.contains(textEditingValue.text.toLowerCase()));
      }),
      onSelected: (String selection) {
        debugPrint('Opção selecionada $selection');
      },
    );
  }
}