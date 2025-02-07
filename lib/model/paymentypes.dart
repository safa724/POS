import 'package:flutter/material.dart';

class PaymentOption {
  final String title;
  final Image image;

  PaymentOption({required this.title, required this.image});
}

final List<PaymentOption> paymentOptions = [
  PaymentOption(title: "Cash", image: Image.asset('images/cash.webp', height: 30)),
  PaymentOption(title: "Debit Card", image: Image.asset('images/debit.png', height: 30)),
  PaymentOption(title: "Credit Card", image: Image.asset('images/debit.png', height: 30)),
  PaymentOption(title: "Store Credit", image: Image.asset('images/store.webp', height: 30)),
];
