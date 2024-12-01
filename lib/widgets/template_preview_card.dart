import 'package:flutter/material.dart';
import '../models/invoice_template.dart';

class TemplatePreviewCard extends StatelessWidget {
  final InvoiceTemplate template;
  final bool isSelected;
  final VoidCallback onSelect;

  const TemplatePreviewCard({
    Key? key,
    required this.template,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Icon(Icons.description, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              template.name,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
