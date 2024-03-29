import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          'Time-Gallery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add),
          )
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ProductCard(
            index: index,
            name: watchNames[index],
            description: watchDescriptions[index],
            price: getRandomPrice(index),
            discount: getRandomDiscount(index),
            stars: getRandomStars(index),
          );
        },
      ),
    );
  }

  double getRandomPrice(int index) {
    return (5000 + (1000 * index)).toDouble();
  }

  double getRandomDiscount(int index) {
    return (20 + index).toDouble();
  }

  int getRandomStars(int index) {
    return 3 + index % 3;
  }

  static List<String> watchNames = [
    "Rado",
    "Neviforce",
    "Citizen",
    "Seiko",
    "Casio",
    "Orient",
    "Fastrack",
    "Fossil",
    "Titan",
    "ROLEX",
  ];

  static List<String> watchDescriptions = [
    "Luxury watch with exquisite design.",
    "Perfect for adventure and style.",
    "Elegant and sophisticated timepiece.",
    "Japanese precision and craftsmanship.",
    "Classic and reliable timekeeping.",
    "Innovative and stylish design.",
    "Sporty and youthful appeal.",
    "Fashion-forward with a vintage touch.",
    "Premium quality with timeless style.",
    "The epitome of luxury and prestige.",
  ];
}

class ProductCard extends StatelessWidget {
  final int index;
  final String name;
  final String description;
  final double price;
  final double discount;
  final int stars;

  const ProductCard({
    Key? key,
    required this.index,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.stars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Image.asset(
                  'images/watch${index + 1}.jpeg',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0),
                ),
                Positioned(
                  bottom: 13,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white70,
                    ),
                    child: Row(
                      children: [
                        Text(
                          stars.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(Icons.star, size: 13),
                        const SizedBox(width: 4),
                        Text(
                          "${(1000 * stars)}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "\u{09F3} ${price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text("\u{09F3} ${(price - (price * discount / 100)).toStringAsFixed(2)}"),
                          const SizedBox(width: 4),
                          Text(
                            "$discount% off",
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BuyNowPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text('Buy Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuyNowPage extends StatefulWidget {
  const BuyNowPage({Key? key}) : super(key: key);

  @override
  _BuyNowPageState createState() => _BuyNowPageState();
}

class _BuyNowPageState extends State<BuyNowPage> {
  String selectedPaymentType = 'Online Payment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Buy Now'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown button
            const Text(
              'Select Payment Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedPaymentType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentType = newValue!;
                });
              },
              items: <String>[
                'Online Payment',
                'Cash on Delivery',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            // "Choose Payment Method" section
            const Text(
              'Choose Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PaymentMethodButton(imageAsset: 'images/BKash.jpeg', label: 'bKash'),
                PaymentMethodButton(imageAsset: 'images/rocket.jpeg', label: 'Rocket'),
                PaymentMethodButton(imageAsset: 'images/visa.jpeg', label: 'Visa'),
                PaymentMethodButton(imageAsset: 'images/mastercard.jpeg', label: 'Mastercard'),
                // Add more payment method buttons as needed
              ],
            ),
            const SizedBox(height: 32),
            // "Buy" button
            ElevatedButton(
              onPressed: () {
                // Handle the "Buy" button click
                // This functionality is currently empty and should be implemented as needed
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodButton extends StatefulWidget {
  final String imageAsset;
  final String label;

  const PaymentMethodButton({Key? key, required this.imageAsset, required this.label})
      : super(key: key);

  @override
  _PaymentMethodButtonState createState() => _PaymentMethodButtonState();
}

class _PaymentMethodButtonState extends State<PaymentMethodButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.green : Colors.transparent,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.asset(
              widget.imageAsset,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.label,
            style: TextStyle(
              color: isSelected ? Colors.green : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
