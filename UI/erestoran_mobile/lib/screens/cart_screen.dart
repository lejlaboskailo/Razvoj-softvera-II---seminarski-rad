import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:erestoran_mobile/models/jelo.dart';
import 'package:erestoran_mobile/models/search_result.dart';
import 'package:erestoran_mobile/providers/jelo_provider.dart';
import 'package:erestoran_mobile/providers/prilozi_provider.dart';
import 'package:erestoran_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:provider/provider.dart';
import 'package:erestoran_mobile/providers/cart_provider.dart';
import '../models/korpa.dart';
import '../widgets/master_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider _cartProvider;
  late ProductProvider _jeloProvider;
  late PriloziProvider _priloziProvider;

  SearchResult<Korpa>? _korpa;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cartProvider = context.read<CartProvider>();
    _jeloProvider = context.read<ProductProvider>();
    _priloziProvider = context.read<PriloziProvider>();

    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await _jeloProvider.fetchAll();
      await _priloziProvider.fetchAll();

      await _fetchInitialData();
    } catch (e) {
      print("Error loading data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _cartProvider.get();
      setState(() {
        _korpa = data;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching cart data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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

                            final jelo = _jeloProvider.items.firstWhere(
                              (x) => x.jeloId == item.jeloId,
                            );
                            final prilog = (item.prilogId != null)
                                ? _priloziProvider.items.firstWhereOrNull(
                                    (x) => x.prilogId == item.prilogId)
                                : null;

                            final nazivPriloga =
                                prilog?.nazivPriloga ?? "Bez priloga";
                            print('korpa item prilogId=${item.prilogId}');
                            print(
                                'prilozi loaded ids: ${_priloziProvider.items.map((e) => e.prilogId).toList()}');

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
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            jelo.naziv ?? "Nepoznato jelo",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '${item.cijena?.toStringAsFixed(2) ?? "-"} KM',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            nazivPriloga, 
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.green),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Total: ${((item.cijena ?? 0) * (item.kolicina ?? 0)).toStringAsFixed(2)} KM',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            await _cartProvider
                                                .delete(item.korpaId);
                                            _fetchInitialData();
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: Text(
                                            "Izbriši iz korpe",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${_cartProvider.totalPrice.toStringAsFixed(2)} KM',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PaypalCheckoutView(
                              sandboxMode: true,
                              clientId: "",
                              secretKey: "",
                              transactions: const [
                                {
                                  "amount": {
                                    "total": '70',
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": '70',
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  "item_list": {
                                    "items": [
                                      {
                                        "name": "Apple",
                                        "quantity": 4,
                                        "price": '5',
                                        "currency": "USD"
                                      },
                                      {
                                        "name": "Pineapple",
                                        "quantity": 5,
                                        "price": '10',
                                        "currency": "USD"
                                      }
                                    ],

                                  }
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                print("onSuccess: $params");
                              },
                              onError: (error) {
                                print("onError: $error");
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                print('cancelled:');
                              },
                            ),
                          ));
                          try {
                            final id = await _cartProvider
                                .checkoutFromCart(Authorization.userId!);
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Narudžba #$id kreirana!')));
                            await _fetchInitialData();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Greška: $e')));
                          }
                        },
                        child: const Text('Pošalji narudžbu'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
