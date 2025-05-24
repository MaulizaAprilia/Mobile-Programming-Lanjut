import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Styling Text App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Styling Text'),
//           backgroundColor: Colors.blue,
//         ),
//         body: const Center(
//           child: Text(
//             'Hello Mauliza Aprilia',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//               decoration: TextDecoration.underline,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//  @override 
//   Widget build(BuildContext context) { 
//     return MaterialApp( 
//       title: 'Styling Text App', 
//       home: Scaffold( 
//         appBar: AppBar( 
//           title: const Text('Styling Text'), 
//           backgroundColor: Colors.blue, 
//         ), 
//         body: const Center( 
//           child: Text( 
//             'Hello Mauliza Aprilia', 
//             style: TextStyle( 
//               fontSize: 24, 
//               fontStyle: FontStyle.italic, // garis miring 
//               fontWeight: FontWeight.bold, 
//               color: Colors.red, // ubah warna menjadi merah 
//               decoration: TextDecoration.underline, 
//             ), 
//           ), 
//         ), 
//       ), 
//     ); 
//   } 
// } 


//  @override 
//   Widget build(BuildContext context) { 
//     return MaterialApp( 
//       title: 'Container Decorations Demo', 
//       home: Scaffold( 
//         appBar: AppBar( 
//           title: const Text('Container & Decorations'), 
//           backgroundColor: Colors.orange, 
//         ), 
//         body: Center( 
//           child: Container( 
//             margin: const EdgeInsets.all(20), 
//             padding: const EdgeInsets.all(20), 
//             decoration: BoxDecoration( 
//               color: Colors.amber, 
//               borderRadius: BorderRadius.circular(12), 
//               boxShadow: [ 
//                 const BoxShadow( 
//                   color: Colors.grey, 
//                   blurRadius: 5, 
//                 ), 
//               ], 
//             ), 
//             child: const Text('Ini Container dengan dekorasi'), 
//           ), 
//         ), 
//       ), 
//     ); 
//   } 
// } 



//  @override 
//   Widget build(BuildContext context) { 
//     return MaterialApp( 
//       title: 'Container Decorations Demo', 
//       home: Scaffold( 
//         appBar: AppBar( 
//           title: const Text('Container & Decorations'), 
//           backgroundColor: Colors.orange, 
//         ), 
//         body: Center( 
//           child: Container( 
//             margin: const EdgeInsets.all(20), 
//             padding: const EdgeInsets.all(20), 
//             decoration: BoxDecoration( 
//               color: Colors.amber, 
//               borderRadius: BorderRadius.circular(20), // radius diubah jadi 20 
//               border: Border.all( // border biru ditambahkan 
//                 color: Colors.blue, 
//                 width: 2, 
//               ), 
//               boxShadow: [ 
//                 const BoxShadow( 
//                   color: Colors.grey, 
//                   blurRadius: 5, 
//                 ), 
//               ], 
//             ), 
//             child: const Text('Ini Container dengan dekorasi'), 
//           ), 
//         ), 
//       ), 
//     ); 
//   } 
// } 



// @override 
//   Widget build(BuildContext context) { 
//     return MaterialApp( 
//       title: 'Stack Widget Demo', 
//       home: Scaffold( 
//         appBar: AppBar( 
//           title: const Text('Stack Widget'), 
//           backgroundColor: Colors.green, 
//         ), 
//         body: Center( 
//           child: Stack( 
//             alignment: Alignment.center, 
//             children: [ 
//               Container( 
//                 width: 200, 
//                 height: 200, 
//                 color: Colors.green, 
//               ), 
//               const Text( 
//                 'Di Atas Kotak', 
//                 style: TextStyle( 
//                   color: Colors.white, 
//                   fontSize: 20, 
//                 ), 
//               ), 
//             ], 
//           ), 
//         ), 
//       ), 
//     ); 
//   } 
// } 


// @override 
//   Widget build(BuildContext context) { 
//     return MaterialApp( 
//       title: 'Stack Widget Demo', 
//       home: Scaffold( 
//         appBar: AppBar( 
//           title: const Text('Stack Widget'), 
//           backgroundColor: Colors.green, 
//         ), 
//         body: Center( 
//           child: Stack( 
//             alignment: Alignment.center, 
//             children: [ 
//               Container( 
//                 width: 200, 
//                 height: 200, 
//                 color: Colors.green, 
//               ), 
//               const Text( 
//                 'Di Atas Kotak', 
//                 style: TextStyle( 
//                   color: Colors.white, 
//                   fontSize: 20, 
//                 ), 
//               ), 
//               const Positioned( 
//                 bottom: 8, 
//                 right: 8, 
//                 child: Icon( 
//                   Icons.star, 
//                   color: Colors.yellow, 
//                   size: 30, 
//                 ), 
//               ), 
//             ], 
//           ), 
//         ), 
//       ), 
//     ); 
//   } 
// }


//  @override 
//   Widget build(BuildContext context) { 
//     return MaterialApp( 
//       title: 'Card Widget Demo', 
//       home: Scaffold( 
//         appBar: AppBar( 
//           title: const Text('Card Widget'), 
//           backgroundColor: Colors.teal, 
//         ), 
//         body: Center( 
//           child: Card( 
//             elevation: 4, 
//             margin: const EdgeInsets.all(16), 
//             child: ListTile( 
//               leading: const Icon(Icons.person), 
//               title: const Text('Mauliza Aprilia'), 
//               subtitle: const Text('Informatika'), 
//             ), 
//           ), 
//         ), 
//       ), 
//     ); 
//   } 
// } 



// @override 
//   Widget build(BuildContext context) { 
//     return MaterialApp( 
//       title: 'Card Widget Demo', 
//       home: Scaffold( 
//         appBar: AppBar( 
//           title: const Text('Card Widget'), 
//           backgroundColor: Colors.teal, 
//         ), 
//         body: Center( 
//           child: Card( 
//             elevation: 4, 
//             margin: const EdgeInsets.all(16), 
//             child: Column( 
//               mainAxisSize: MainAxisSize.min, 
//               children: [ 
//                 const ListTile( 
//                   leading: Icon(Icons.person), 
//                   title: Text('Mauliza Aprilia'), 
//                   subtitle: Text('Informatika'), 
//                 ), 
//                 ButtonBar( 
//                   alignment: MainAxisAlignment.end, 
//                   children: [ 
//                     ElevatedButton( 
//                       onPressed: () { 
//                         // Aksi ketika tombol ditekan 
//                         print('Lihat Profil ditekan'); 
//                       }, 
//                       child: const Text('Lihat Profil'), 
//                     ), 
//                   ], 
//                 ), 
//               ], 
//             ), 
//           ), 
//         ), 
//       ), 
//     ); 
//   } 
// } 


// @override 
//   Widget build(BuildContext context) { 
//     return MaterialApp( 
//       title: 'Card Widget Demo', 
//       home: Scaffold( 
//         appBar: AppBar( 
//           title: const Text('Card Widget'), 
//           backgroundColor: Colors.teal, 
//         ), 
//         body: Center( 
//           child: Card( 
//             elevation: 4, 
//             margin: const EdgeInsets.all(16), 
//             child: Column( 
//               mainAxisSize: MainAxisSize.min, 
//               children: [ 
//                 const ListTile( 
//                   leading: Icon(Icons.person), 
//                   title: Text('Mauliza Aprilia'), 
//                   subtitle: Text('Informatika'), 
//                 ), 
//                 ButtonBar( 
//                   alignment: MainAxisAlignment.end, 
//                   children: [ 
//                     ElevatedButton( 
//                       onPressed: () { 
//                         // Aksi ketika tombol ditekan 
//                         print('Lihat Profil ditekan'); 
//                       }, 
//                       child: const Text('Lihat Profil'), 
//                     ), 
//                   ], 
//                 ), 
//               ], 
//             ), 
//           ), 
//         ), 
//       ), 
//     ); 
//   } 
// } 



 @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Theme Demo', 
      theme: ThemeData.dark().copyWith( 
        primaryColor: Colors.teal, // Ganti warna utama untuk tema gelap 
        appBarTheme: const AppBarTheme( 
          backgroundColor: Colors.teal, // Ubah warna AppBar 
        ), 
        textTheme: const TextTheme( 
          bodyLarge: TextStyle( 
            fontSize: 25, 
            color: Colors.white, // Ubah warna teks menjadi putih agar terbaca di dark mode 
          ), 
        ), 
      ), 
      home: const MyHomePage(), 
    ); 
  } 
} 
 
class MyHomePage extends StatelessWidget { 
  const MyHomePage({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Theme with Theme'), 
      ), 
      body: Center( 
        child: Text( 
          'Ini teks dengan tema!', 
          style: Theme.of(context).textTheme.bodyLarge, 
        ), 
     ), 
   ); 
  } 
}