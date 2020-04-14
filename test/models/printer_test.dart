import 'package:flutter_test/flutter_test.dart';

import 'package:printer_calculator/models/printer.dart';

void main() {
  test('Printer test', () {
    final printer = Printer(
      name: 'Samsung XPRESS M2020W',
      cartridgePrice: 2000,
      lpm: 20,
      cartridgeResource: 1500,
    );

    final int paperPerMonth = 2000;

    expect(printer.getCartridgeQuantity(paperPerMonth), 2);

    expect(printer.getPreferedPrice(paperPerMonth), 2.0);

    expect(printer.getProfit(paperPerMonth, 3), 2000);
  });
}
