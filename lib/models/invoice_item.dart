class InvoiceItem {
  final int srNo;
  final String description;
  final int quantity;
  final double unitPrice;
  final double gst;
  late double gstAmount;
  late double total;

  InvoiceItem({
    required this.srNo,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.gst,
  }) {
    gstAmount = (unitPrice * gst / 100) * quantity;
    total = (unitPrice * quantity) + gstAmount;
  }
}
