import 'package:erestoran_mobile/models/korpa.dart';
import 'package:erestoran_mobile/models/search_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erestoran_mobile/providers/cart_provider.dart';
import 'package:erestoran_mobile/widgets/master_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider _cartProvider;
  SearchResult<Korpa>? _korpa;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cartProvider = context.read<CartProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _cartProvider.get();
      setState(() {
        _korpa = data;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Sprečava povratak sa ekrana
        return false;
      },
      child: MasterScreenWidget(
        title: "My Cart",
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : (_korpa == null || _korpa!.result.isEmpty)
                ? Center(child: Text("Your cart is empty"))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _korpa!.result.length,
                          itemBuilder: (context, index) {
                            final item = _korpa!.result[index];

                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Slika proizvoda
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "https://via.placeholder.com/100", // Zameni pravim URL-om slike
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    // Informacije o proizvodu
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.proizvodId.toString(), // Zameni sa stvarnim nazivom proizvoda
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '${item.cijena!.toStringAsFixed(2)} RSD',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.green),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Total: ${(item.cijena! * item.kolicina!).toStringAsFixed(2)} RSD',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Dugmad za + i -
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline,
                                              color: Colors.blue),
                                          onPressed: () async {
                                            await _cartProvider.insert(item);
                                            _fetchInitialData();
                                          },
                                        ),
                                        Text(
                                          item.kolicina.toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.remove_circle_outline,
                                              color: Colors.red),
                                          onPressed: () async {
                                            await _cartProvider
                                                .delete(item.korpaId);
                                            _fetchInitialData();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Ukupna cena i dugme za narudžbu
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${_cartProvider.totalPrice.toStringAsFixed(2)} RSD',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            /*ElevatedButton(
                              onPressed: _korpa != null &&
                                      _korpa!.result.isNotEmpty
                                  ? () => _placeOrder()
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.blue,
                              ),
                              child: Text("Place Order",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  /*void _placeOrder() {
    print("Order placed!");
    _cartProvider.clearCart();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Your order has been placed!")),
    );
    setState(() {
      _korpa = null;
    });
  }*/
}
