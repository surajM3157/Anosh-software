import 'package:flutter/material.dart';
import 'invoice_preview_screen.dart'; // Adjust the path if needed.

void main() {
  // Disable debug banner
  WidgetsFlutterBinding.ensureInitialized();
  // Set this flag to false to hide the debug banner
  bool debug = false;
  runApp(MyInvoicePage());
}

class MyInvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // This removes the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Invoice Preview'),
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvoicePreviewScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('PDF Preview'),
                SizedBox(width: 8),
                Icon(Icons.print),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
