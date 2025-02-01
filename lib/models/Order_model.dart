
class OrderModel {
  String cardnumber;
  String category;
  String cvc;
  String date;
  String expiredate;
  String invoicePrice;
  String location;
  String productname;
  String status;
  String image;
  String time;

  // Constructor
  OrderModel({
    required this.cardnumber,
    required this.category,
    required this.cvc,
    required this.date,
    required this.expiredate,
    required this.invoicePrice,
    required this.location,
    required this.productname,
    required this.status,
    required this.time,
    required this.image,
  });

  factory OrderModel.fromjson(
      {required Map<String, dynamic> jsondata, String? id}) {
    return OrderModel(
      cardnumber: jsondata['card_number'],
      category: jsondata['category'],
      cvc: jsondata['cvc'],
      date: jsondata['date'],
      expiredate: jsondata['expire_date'],
      invoicePrice: jsondata['invoice_price'],
      location: jsondata['location'],
      productname: jsondata['product_name'],
      status: jsondata['status'],
      time: jsondata['time'],
      image: jsondata['image'],
    );
  }
}
