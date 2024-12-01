import 'package:get/get.dart';
import '../models/invoice_item.dart';

class InvoiceController extends GetxController {
  static RxList<InvoiceItem> items = List.generate(
      12,
      (index) => InvoiceItem(
          srNo: 1,
          description: "ABCDEFGHIJKLMN",
          quantity:99,
          unitPrice: 9999999.99,
          gst: 18)).obs;

  static double get totalGst {
    return items.fold(0, (sum, item) => sum + item.gstAmount);
  }

  static double get totalAmount {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  static List<InvoiceItem> get invoiceItems => items;
}
