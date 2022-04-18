import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainHomeState();
}

class _MainHomeState extends State<HomePage> {
  final df = DateFormat('dd-MM-yyyy hh:mm a');
  int myvalue = 1558432747;

  static final List<Map<String, dynamic>> _allProtocolos = [
    {
      "id": 2589,
      "dataInicio": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      "dataFinal": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      "motorista": 'Joziel',
      "veiculo": 'CNH1817'
    },
    {
      "id": 9854,
      "dataInicio": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      "dataFinal": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      "motorista": 'Mauro',
      "veiculo": 'CNH1817'
    },
    {
      "id": 4578,
      "dataInicio": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      "dataFinal": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      "motorista": 'Ronildo',
      "veiculo": 'PTE2117'
    },
    {
      "id": 3654,
      "dataInicio": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      "dataFinal": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      "motorista": 'Jackson',
      "veiculo": 'POO9874'
    },
  ];

  List<Map<String, dynamic>> _foundProtocolos = [];

 

  @override
  void initState() {
    // TODO: implement initState
    _foundProtocolos = _allProtocolos;
    super.initState();
  }

  void _protocoloFilter(String keyword) {
    List<Map<String, dynamic>> results = [];
    if (keyword.isEmpty) {
      results = _allProtocolos;
    } else {
      results = _allProtocolos
          .where((protocolo) => (protocolo['motorista'] +
                  ' - ' +
                  protocolo['id'].toString() +
                  ' - ' +
                  protocolo['dataInicial'].toString() +
                  ' - ' +
                  protocolo['dataFinal'].toString() +
                  ' - ' +
                  protocolo['veiculo'])
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundProtocolos = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: ((value) => _protocoloFilter(value)),
            decoration: const InputDecoration(
              labelText: 'Pesquisar',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: _foundProtocolos.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundProtocolos.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundProtocolos[index]['id']),
                        color: Colors.lightGreen,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundProtocolos[index]['id'].toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundProtocolos[index]['motorista']),
                          subtitle: Text(_foundProtocolos[index]['veiculo']),
                          trailing: Text('Início: ' +
                              _foundProtocolos[index]['dataInicio'].toString() +
                              '\n\n' 'Final: ' +
                              _foundProtocolos[index]['dataFinal'].toString()),
                        ),
                      ),
                    )
                  : const Text(
                      'Protocolo não encontrado',
                      style: TextStyle(fontSize: 24),
                    ))
        ]),
      ),
    );
  }
}
