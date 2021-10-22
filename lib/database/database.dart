import '../models/models.dart';

class Database {
  static const List<Category> categories = [
    Category(
      id: 1,
      name: "Headache",
      imageURL: "assets/images/headache.jpeg",
    ),
    Category(
      id: 2,
      name: "Supplements",
      imageURL: "assets/images/headache.jpeg",
    ),
    Category(
      id: 3,
      name: "Infants",
      imageURL: "assets/images/headache.jpeg",
    ),
    Category(
      id: 4,
      name: "Cough",
      imageURL: "assets/images/headache.jpeg",
    ),
  ];

  static const List<Product> products = [
    Product(
      id: 1,
      name: "Paracetamol",
      imageURL: "assets/images/headache.jpeg",
      type: "Tablet",
      size: 500,
      price: 350.25,
      categoryId: 1,
      requiresPrescription: false,
      soldBy: "Emzor Pharmacueticals",
      soldByImageURL: "assets/images/headache.jpeg",
      constituents: "Paracetamol",
      description:
          "1 pack of Emzor Paracetamol (500mg) contains 8 units of 12 tablets.",
      dispensedIn: "Pack(s)",
      isFavourite: false,
      packSize: "8 x 12 tablets (96)",
      productId: "PRO23648856",
    ),
    Product(
      id: 2,
      name: "Doliprane",
      imageURL: "assets/images/headache.jpeg",
      type: "Capsule",
      size: 1000,
      price: 350.0,
      categoryId: 2,
      requiresPrescription: false,
      soldBy: "Doliprane Pharmacueticals",
      soldByImageURL: "assets/images/headache.jpeg",
      constituents: "Doliprane",
      description:
          "1 pack of Doliprane (100mg) contains 8 units of 12 capsules.",
      dispensedIn: "Pack(s)",
      isFavourite: false,
      packSize: "8 x 12 capsules (96)",
      productId: "PRO23648858",
    ),
    Product(
      id: 3,
      name: "Paracetamol",
      imageURL: "assets/images/headache.jpeg",
      type: "Tablet",
      size: 500,
      price: 350.0,
      categoryId: 1,
      requiresPrescription: true,
      soldBy: "Emzor Pharmacueticals",
      soldByImageURL: "assets/images/headache.jpeg",
      constituents: "Paracetamol",
      description:
          "1 pack of Emzor Paracetamol (500mg) contains 8 units of 12 tablets.",
      dispensedIn: "Pack(s)",
      isFavourite: false,
      packSize: "8 x 12 tablets (96)",
      productId: "PRO23648836",
    ),
    Product(
      id: 4,
      name: "Ibuprofen",
      imageURL: "assets/images/headache.jpeg",
      type: "Tablet",
      size: 200,
      price: 350.0,
      categoryId: 3,
      requiresPrescription: false,
      soldBy: "Ibuprofen Pharmacueticals",
      soldByImageURL: "assets/images/headache.jpeg",
      constituents: "Ibuprofen",
      description:
          "1 pack of Ibuprofen (200mg) contains 8 units of 12 tablets.",
      dispensedIn: "Pack(s)",
      isFavourite: false,
      packSize: "8 x 12 tablets (96)",
      productId: "PRO23348856",
    ),
    Product(
      id: 5,
      name: "Paracetamol",
      imageURL: "assets/images/headache.jpeg",
      type: "Tablet",
      size: 500,
      price: 350.0,
      categoryId: 2,
      requiresPrescription: false,
      soldBy: "Emzor Pharmacueticals",
      soldByImageURL: "assets/images/headache.jpeg",
      constituents: "Ibuprofen",
      description:
          "1 pack of Emzor Paracetamol (500mg) contains 8 units of 12 tablets.",
      dispensedIn: "Pack(s)",
      isFavourite: false,
      packSize: "8 x 12 tablets (96)",
      productId: "PRO23368856",
    ),
    Product(
      id: 4,
      name: "Ibuprofen",
      imageURL: "assets/images/headache.jpeg",
      type: "Tablet",
      size: 200,
      price: 350.0,
      categoryId: 4,
      requiresPrescription: false,
      soldBy: "Ibuprofen Pharmacueticals",
      soldByImageURL: "assets/images/headache.jpeg",
      constituents: "Ibuprofen",
      description:
          "1 pack of Ibuprofen (200mg) contains 8 units of 12 tablets.",
      dispensedIn: "Pack(s)",
      isFavourite: false,
      packSize: "8 x 12 tablets (96)",
      productId: "PRO23348056",
    ),
    Product(
      id: 4,
      name: "Ibuprofen",
      imageURL: "assets/images/headache.jpeg",
      type: "Tablet",
      size: 200,
      price: 350.0,
      categoryId: 3,
      requiresPrescription: false,
      soldBy: "Ibuprofen Pharmacueticals",
      soldByImageURL: "assets/images/headache.jpeg",
      constituents: "Ibuprofen",
      description:
          "1 pack of Ibuprofen (200mg) contains 8 units of 12 tablets.",
      dispensedIn: "Pack(s)",
      isFavourite: false,
      packSize: "8 x 12 tablets (96)",
      productId: "PRO23348956",
    ),
  ];
}