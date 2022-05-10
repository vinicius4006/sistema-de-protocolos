import 'package:flutter/material.dart';

class ScrollTop extends StatefulWidget {
  const ScrollTop({ Key? key }) : super(key: key);

  @override
  State<ScrollTop> createState() => _ScrollTopState();
}

class _ScrollTopState extends State<ScrollTop> with TickerProviderStateMixin{

   bool _showBackToTopButton = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()..addListener(() { 
      setState(() {
        if(_scrollController.offset >= 100){
          _showBackToTopButton = true;
        } else {
          _showBackToTopButton = false;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToTop(){
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Testando aplicação'),),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              height: 600,
              color: Colors.amber,
            ),
            Container(
              height: 600,
              color: Colors.blue[100],
            ),
            Container(
              height: 600,
              color: Colors.red[200],
            ),
            Container(
              height: 600,
              color: Colors.orange,
            ),
            Container(
              height: 600,
              color: Colors.yellow,
            ),
            Container(
              height: 1200,
              color: Colors.lightGreen,
            ),
          
          ],
          
        ),
        
      ),
      floatingActionButton: _showBackToTopButton == false ? null : FloatingActionButton(onPressed: _scrollToTop, child: const Icon(Icons.arrow_upward),),
    );
  }
}