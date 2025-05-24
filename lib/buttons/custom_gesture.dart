import 'package:flutter/material.dart'; 
 
class CustomGestureScreen extends StatelessWidget { 
  void showMessage(String message) { 
    print(message); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Custom Gesture Demo')), 
      body: Center( 
        child: GestureDetector( 
          onTap: () => showMessage('Tap detected!'), 
          onDoubleTap: () => showMessage('Double tap detected!'), 
          onLongPress: () => showMessage('Long press detected!'), 
          child: Container( 
            padding: EdgeInsets.all(20), 
            decoration: BoxDecoration( 
              color: Colors.blue, 
              borderRadius: BorderRadius.circular(10), 
            ), 
            child: Text( 
              'Tap, Double Tap, or Long Press', 
              style: TextStyle(color: Colors.white), 
              textAlign: TextAlign.center, 
            ), 
          ), 
        ), 
      ), 
    ); 
  } 
} 