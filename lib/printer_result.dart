import 'package:flutter/material.dart';
import 'package:printer_calculator/models/printer.dart';

class PrinterResult extends StatefulWidget {
  final Printer printer;

  PrinterResult({this.printer});

  @override
  _PrinterResultState createState() => _PrinterResultState();
}

class _PrinterResultState extends State<PrinterResult> {
  final Printer printer;
  final ppmController = TextEditingController(text: '1000');
  int paperPerMonth = 1000;
  double price = 0;
  double minPrice = 0;

  _PrinterResultState({this.printer});

  Widget textRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text('$name: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text('$value', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (price == 0 && minPrice == 0) {
      double newPrice = widget.printer.getPreferedPrice(paperPerMonth);
      setState(() {
        price = newPrice;
        minPrice = newPrice;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Загрузка принтера'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          widget.printer.img != null
              ? Image.asset(
                  widget.printer.img,
                  height: 100,
                )
              : Container(),
          textRow('Принтер', widget.printer.name),
          textRow('Скорость печати', '${widget.printer.lpm} страниц в минуту'),
          textRow('Ресурс картриджа', '${widget.printer.cartridgeResource}'),
          textRow('Цена картриджа', '${widget.printer.cartridgePrice}'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: ppmController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Кол-во печатаемых листов в месяц',
              ),
              onSubmitted: (String value) {
                int num = int.parse(value);
                double newPrice = widget.printer.getPreferedPrice(num);
                setState(() {
                  paperPerMonth = num;
                  minPrice = newPrice;
                  price = newPrice;
                });
              },
            ),
          ),
          Wrap(
            children: <Widget>[
              textRow('Требуемое кол-во картриджей в 1 мес',
                  '${widget.printer.getCartridgeQuantity(paperPerMonth)}'),
              textRow('Затраты на картриджи в 1 мес',
                '${widget.printer.getCartridgeQuantity(paperPerMonth) * widget.printer.cartridgePrice} руб'),
              textRow('Мин. прибыльная цена на 1 лист',
                  '${widget.printer.getPreferedPrice(paperPerMonth)}'),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              children: <Widget>[
                Text(
                  'Установите цену, чтобы посмотреть размер прибыли',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Slider(
            min: minPrice.toDouble(),
            max: (minPrice + 15).toDouble(),
            divisions: 15,
            label: '$price',
            value: price,
            onChanged: (double newPrice) {
              setState(() {
                price = newPrice;
              });
            },
          ),
          textRow(
              'Прибыль', '${widget.printer.getProfit(paperPerMonth, price)} руб'),
          Container(
            height: 100,
          )
        ],
      ),
    );
  }
}
