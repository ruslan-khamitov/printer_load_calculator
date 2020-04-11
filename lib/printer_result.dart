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

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title:
              Text('Неправильное число', style: TextStyle(color: Colors.white)),
          content: const Text('Пожалуйста введите правильно число',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget textRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            foregroundDecoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
            ),
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.printer.img != null
                    ? Image.asset(
                        widget.printer.img,
                        height: 100,
                      )
                    : Container(),
                textRow('Принтер', widget.printer.name),
                textRow('Скорость печати',
                    '${widget.printer.lpm} страниц в минуту'),
                textRow(
                    'Ресурс картриджа', '${widget.printer.cartridgeResource}'),
                textRow('Цена картриджа', '${widget.printer.cartridgePrice}'),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Укажите кол-во печатаемых листов в месяц:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: ppmController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Кол-во печатаемых листов в месяц',
                    ),
                    onSubmitted: (String value) {
                      try {
                        int num = int.parse(value);
                        double newPrice = widget.printer.getPreferedPrice(num);
                        setState(() {
                          paperPerMonth = num;
                          minPrice = newPrice;
                          price = newPrice;
                        });
                      } catch (err) {
                        _ackAlert(context);
                      }
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Для $paperPerMonth страниц:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Будет необходимо ${widget.printer.getCartridgeQuantity(paperPerMonth)} картриджей'
                        ),
                        Text(
                          'Расходы на картриджи составят ${widget.printer.getCartridgeQuantity(paperPerMonth) * widget.printer.cartridgePrice} руб.'
                        ),
                        Text(
                          'Исходя из этого, минимальная цена за один лист, должна составить ${widget.printer.getPreferedPrice(paperPerMonth)} руб'
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          'Потяните слайдер, чтобы посмотреть размер прибыли в зависимости от цены',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                    activeColor: Colors.indigo,
                    onChanged: (double newPrice) {
                      setState(() {
                        price = newPrice;
                      });
                    },
                  ),
                  textRow('Прибыль',
                      '${widget.printer.getProfit(paperPerMonth, price)} руб'),
              ],
            ),
          ),
          Container(
            height: 100,
          )
        ],
      ),
    );
  }
}
