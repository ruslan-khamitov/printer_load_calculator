class Printer {
  /// Название принтера
  String name;

  /// Кол-во листов в минуту
  int lpm;

  /// Ресурс картриджа (кол-во страниц)
  int cartridgeResource;

  /// Цена картриджа
  double cartridgePrice;

  /// Название картинки
  String img;

  Printer({
    this.name,
    this.lpm,
    this.cartridgeResource,
    this.cartridgePrice,
    this.img,
  })  : assert(name != null),
        assert(lpm != null && lpm > 0),
        assert(cartridgeResource != null && cartridgeResource > 0),
        assert(cartridgePrice != null && cartridgePrice > 0);

  /// Расчёт количества картриджей, в зависимости от
  /// количества печатаемых страниц в месяц
  int getCartridgeQuantity(int paperPerMonth) =>
      (paperPerMonth / cartridgeResource).ceil();

  /// Минимально выгодная цена на 1 страницу печати
  /// для того чтобы окупить покупку картриджей в месяц
  double getPreferedPrice(int paperPerMonth) {
    double cartrigePrice = getCartridgeQuantity(paperPerMonth) * cartridgePrice;
    return (cartrigePrice / paperPerMonth).ceil().toDouble();
  }

  /// Расчет количества прибыли
  double getProfit(int paperPerMonth, double price) {
    return -(getCartridgeQuantity(paperPerMonth) * cartridgePrice) + (paperPerMonth * price);
  }
}
