
import 'package:pos/model/categorymodel.dart';
import 'package:pos/model/productmodel.dart';

List<Category> categories = [
    Category(id: 1, name: "Beverages", image: "images/bev.webp"),
    Category(id: 2, name: "Snacks", image: "images/bakery.avif"),
    Category(id: 3, name: "Desserts", image: "images/dessert.jpg"),
    Category(id: 4, name: "Salads", image: "images/salad.webp"),
Category(id: 5, name: "Soups", image: "images/soup.jpg"),
Category(id: 6, name: "Main Course", image: "images/main.webp"),
Category(id: 7, name: "Seafood", image: "images/sea.avif"),

  ];

  // Products
  List<Product> allProducts = [
    Product(
        id: 1, categoryId: 1, title: "Coffee", price: 10, image: "images/coffee.jpg"),
    Product(
        id: 2, categoryId: 1, title: "Matcha Latte", price: 20, image: "images/matcha.jpg"),
    Product(
        id: 3, categoryId: 1, title: "Iced Coffee", price: 15, image: "images/iced.jpg"),
        Product(
        id: 4, categoryId: 1, title: "Mojito", price: 35, image: "images/mojito.jpg"),
        Product(
        id: 5, categoryId: 1, title: "Hot Chocolate", price: 20, image: "images/hot.jpg"),
        Product(
        id: 6, categoryId: 1, title: "Capuccino", price: 15, image: "images/cappu.webp"),
        Product(
        id: 7, categoryId: 1, title: "Smoothie", price: 45, image: "images/smoothie.webp"),
        Product(
        id: 8, categoryId: 1, title: "Black Tea", price: 10, image: "images/black.webp"),
        Product(
        id: 9, categoryId: 1, title: "Fresh Juice", price: 15, image: "images/fresh.jpg"),
    Product(
        id: 10, categoryId: 2, title: "Fries", price: 50, image: "images/fries.webp"),
    Product(
        id: 11, categoryId: 2, title: "Cookies", price: 80, image: "images/cookies.jpeg"),
    Product(
        id: 12, categoryId: 3, title: "Cake", price: 25, image: "images/cake.jpeg"),
        Product(
        id: 13, categoryId: 3, title: "Kunafa", price: 25, image: "images/kunafa.jpg"),
  ];
