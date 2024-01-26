import 'package:flutter/material.dart';
import 'dart:math';

class GroceryItem {
  final String name;
  final double price;
  final String imageAssetPath;

  GroceryItem({required this.name, required this.price, required this.imageAssetPath});

  void addToCart(BuildContext context) {
    Cart.instance.add(this);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name added to cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class Cart {
  List<GroceryItem> _items = [];

  Cart._privateConstructor();

  static final Cart _instance = Cart._privateConstructor();

  static Cart get instance => _instance;

  void add(GroceryItem item) {
    _items.add(item);
  }

  void remove(GroceryItem item) {
    _items.remove(item);
  }

  List<GroceryItem> get items => _items;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superb Savers',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Color(0xFFF5F5DC), // Custom beige color
      ),
      home: const MyHomePage(title: 'Superb Savers'),
      routes: {
        '/category1': (context) => CategoryPage(category: 'Category 1'),
        '/category2': (context) => CategoryPage(category: 'Category 2'),
        '/category3': (context) => CategoryPage(category: 'Category 3'),
        '/category4': (context) => CategoryPage(category: 'Category 4'),
        '/cart': (context) => CartPage(),
        '/signup': (context) => SignUpPage(),
        '/signin': (context) => SignInPage(),
      },

    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _titleAnimation;
  late Animation<double> _adsAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(); // Repeat the animation continuously

    _titleAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 1,
      ),
    ]).animate(_animationController);

    _adsAnimation = Tween<double>(begin: 0, end: 360).animate(_animationController);

    // Automatically start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToCategory(String category) {
    Navigator.pushNamed(context, '/$category');
  }

  String randomGroceryStoreBackground() {
    final List<String> backgrounds = [
      'Welcome to Superb Savers! Find the best deals on fresh fruits and vegetables.',
      'Discover a wide range of dairy products at Superb Savers.',
      'Meat lovers rejoice! We have the finest selection of meat at unbeatable prices.',
      'Get your hands on organic and locally-sourced groceries at Superb Savers.',
      ' Juan is best app creator for sure :)!',
    ];
    final random = Random();
    return backgrounds[random.nextInt(backgrounds.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: _titleAnimation.value,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 30,
                  ),
                ),
                Text(
                  ' ${widget.title} ',
                  style: TextStyle(
                    fontSize: 30 * _titleAnimation.value,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.scale(
                  scale: _titleAnimation.value,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 30,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.yellow, // Add a yellow background color
                    height: 150, // Smaller height for the carousel container
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return PageView.builder(
                          itemCount: 3, // Number of images
                          controller: PageController(
                            viewportFraction: 0.8,
                            initialPage: (_animationController.value * 100).toInt() % 3, // Start with the current animation value
                          ),
                          itemBuilder: (context, index) {
                            return Transform.rotate(
                              angle: _adsAnimation.value * (3.14159 / 180),
                              child: Image.asset('assets/deal_image${index + 1}.jpg'),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.yellow, // Add a yellow background color
                      child: Center(
                        child: Text(
                          randomGroceryStoreBackground(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white, // Add a white background color
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => _navigateToCategory('category1'),
                          child: Text('Fruits'),
                        ),
                        ElevatedButton(
                          onPressed: () => _navigateToCategory('category2'),
                          child: Text('Vegetables'),
                        ),
                        ElevatedButton(
                          onPressed: () => _navigateToCategory('category3'),
                          child: Text('Meat'),
                        ),
                        ElevatedButton(
                          onPressed: () => _navigateToCategory('category4'),
                          child: Text('Dairy'),
                        ),
                      ],
                    ),
                  ),

                  // Container for sign up and sign in buttons
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.white, // Add a white background color
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text('Sign Up'),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: Text('Sign In'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        label: Text('View Cart'),
        icon: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String category;

  CategoryPage({required this.category});

  List<GroceryItem> _getGroceryItems() {
    if (category == 'Category 1') {
      return [
        GroceryItem(name: 'Apple', price: 1.99, imageAssetPath: 'assets/apple.png'),
        GroceryItem(name: 'Banana', price: 0.99, imageAssetPath: 'assets/banana.png'),
        GroceryItem(name: 'Orange', price: 1.49, imageAssetPath: 'assets/orange.png'),
      ];
    } else if (category == 'Category 2') {
      return [
        GroceryItem(name: 'Carrot', price: 1.29, imageAssetPath: 'assets/carrot.png'),
        GroceryItem(name: 'Broccoli', price: 2.49, imageAssetPath: 'assets/broccoli.png'),
        GroceryItem(name: 'Tomato', price: 0.79, imageAssetPath: 'assets/tomato.png'),
      ];
    } else if (category == 'Category 3') {
      return [
        GroceryItem(name: 'Chicken', price: 5.99, imageAssetPath: 'assets/chicken.png'),
        GroceryItem(name: 'Beef', price: 7.49, imageAssetPath: 'assets/beef.png'),
        GroceryItem(name: 'Pork', price: 4.99, imageAssetPath: 'assets/pork.png'),
      ];
    } else if (category == 'Category 4') {
      return [
        GroceryItem(name: 'Milk', price: 2.49, imageAssetPath: 'assets/milk.png'),
        GroceryItem(name: 'Cheese', price: 3.99, imageAssetPath: 'assets/cheese.png'),
        GroceryItem(name: 'Yogurt', price: 1.79, imageAssetPath: 'assets/yogurt.png'),
      ];
    } else {
      return []; // Return an empty list for unknown category
    }
  }

  @override
  Widget build(BuildContext context) {
    List<GroceryItem> groceryItems = _getGroceryItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(groceryItems[index].imageAssetPath),
            title: Text(groceryItems[index].name),
            subtitle: Text('Price: \$${groceryItems[index].price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                groceryItems[index].addToCart(context);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Contact us at 1 (800) 839 8188'),
              duration: Duration(seconds: 3),
            ),
          );
        },
        label: Text('Contact Us'),
        icon: Icon(Icons.phone),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GroceryItem> cartItems = Cart.instance.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text('Your cart is empty.'),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(cartItems[index].imageAssetPath),
            title: Text(cartItems[index].name),
            subtitle: Text('Price: \$${cartItems[index].price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                Cart.instance.remove(cartItems[index]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${cartItems[index].name} removed from cart'),
                    duration: Duration(seconds: 2),

                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignIn(BuildContext context) {

    String email = _emailController.text;
    String password = _passwordController.text;


    print('Email: $email');
    print('Password: $password');


    Navigator.pop(context); // Go back to the previous page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _handleSignIn(context),
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _handleSignUp(BuildContext context) {

    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;


    print('Email: $email');
    print('Password: $password');
    print('Confirm Password: $confirmPassword');


    Navigator.pop(context); // Go back to the previous page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _handleSignUp(context),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());}
