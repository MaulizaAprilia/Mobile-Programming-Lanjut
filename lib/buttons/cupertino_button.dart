import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart'; 
 
class CupertinoButtonScreen extends StatelessWidget { 
  void showMessage(String message) { 
    print(message); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return CupertinoPageScaffold( 
      navigationBar: CupertinoNavigationBar( 
        middle: Text('Cupertino Button Demo'), 
      ), 
      child: Center( 
        child: CupertinoButton( 
          onPressed: () => showMessage('Cupertino Button Clicked!'), 
          color: CupertinoColors.activeBlue, 
          child: Text('Cupertino Button'), 
        ), 
      ), 
    ); 
  } 
}