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

  static const String PAYPAL_CLIENT_ID =
      "AQN5aMhuwAxbyotTYqQDTYNBtW3W2loVRijMYLQwEjWAiacQ0qRECCkssxAPZjuHQOpBrCwYIHZP2tk9";
  static const String PAYPAL_SECRET_KEY =
      "EAWqFWQuvAWmSh8hQL2Fn0v-T7uvFepO6BKEzqzkNaSncZa8BiE9EHXIOzj4ZDYgs5BeOWi-I5e8cFfq";
  static const bool PAYPAL_SANDBOX = true;

  static const String PAYPAL_CURRENCY = "EUR";
  static const double BAM_PER_EUR = 1.95583;
  static const double EUR_PER_BAM = 1 / BAM_PER_EUR;

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
      debugPrint("Error loading data: $e");
      setState(() => _isLoading = false);
      _toast('Greška pri učitavanju podataka.');
    }
  }

  Future<void> _fetchInitialData() async {
    try {
      final data = await _cartProvider.get();
      setState(() {
        _korpa = data;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching cart data: $e');
      setState(() => _isLoading = false);
      _toast('Greška pri dohvatu korpe.');
    }
  }

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  double _calcSubtotalBAM() {
    if (_korpa == null) return 0;
    double sum = 0;
    for (final item in _korpa!.result) {
      final qty = (item.kolicina ?? 0);
      final price = (item.cijena ?? 0);
      sum += price * qty;
    }
    return sum;
  }

  String _to2(double v) => v.toStringAsFixed(2);
  String _bamToEurStr(double bam) => _to2(bam * EUR_PER_BAM);

  int _eurCentsFromBAM(double bam) => ((bam * EUR_PER_BAM) * 100).round();
  String _eurStrFromCents(int cents) => _to2(cents / 100.0);

  List<Map<String, dynamic>> _buildPaypalTransactions() {
    final subtotalBAM = _calcSubtotalBAM();
    if (subtotalBAM <= 0) {
      throw Exception('Korpa je prazna ili iznosi nisu postavljeni.');
    }

    int subtotalEurCents = 0;

    final items = _korpa!.result.map((item) {
      final jelo =
          _jeloProvider.items.firstWhere((x) => x.jeloId == item.jeloId);
      final int qty = (item.kolicina ?? 0);
      final double unitBAM = (item.cijena ?? 0);

      final unitEurCents = _eurCentsFromBAM(unitBAM);
      subtotalEurCents += unitEurCents * qty;

      return {
        "name": jelo.naziv ?? "Nepoznato jelo",
        "quantity": qty,
        "price": _eurStrFromCents(unitEurCents),
        "currency": PAYPAL_CURRENCY
      };
    }).toList();

    final int shippingEurCents = 0;
    final int discountCents = 0;

    final int totalEurCents =
        subtotalEurCents + shippingEurCents - discountCents;

    final subtotalStr = _eurStrFromCents(subtotalEurCents);
    final shippingStr = _eurStrFromCents(shippingEurCents);
    final totalStr = _eurStrFromCents(totalEurCents);

    return [
      {
        "amount": {
          "total": totalStr,
          "currency": PAYPAL_CURRENCY,
          "details": {
            "subtotal": subtotalStr,
            "shipping": shippingStr,
            "shipping_discount": 0
          }
        },
        "description": "Plaćanje narudžbe u eRestoran aplikaciji",
        "item_list": {
          "items": items,
        }
      }
    ];
  }

  Future<void> _startPaypalCheckout() async {
    if (_korpa == null || _korpa!.result.isEmpty) {
      _toast('Korpa je prazna.');
      return;
    }

    final subtotalBAM = _calcSubtotalBAM();
    if (subtotalBAM <= 0) {
      _toast('Ukupno je 0. Dodaj artikle ili postavi cijene.');
      return;
    }

    late final List<Map<String, dynamic>> transactions;
    try {
      transactions = _buildPaypalTransactions();
    } catch (e) {
      _toast(e.toString());
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: PAYPAL_SANDBOX,
        clientId: PAYPAL_CLIENT_ID,
        secretKey: PAYPAL_SECRET_KEY,
        transactions: transactions,
        note: "Hvala što koristite našu aplikaciju!",
        onSuccess: (Map params) async {
          final paymentId =
              (params['data']?['id'] ?? params['id'] ?? params['paymentId'])
                  ?.toString();
          final id = await _cartProvider.checkoutFromCart(
              Authorization.userId!, paymentId);
          if (!mounted) return;
          _toast('Narudžba #$id kreirana!');
          await _fetchInitialData();
          Navigator.pop(context);
        },
        onError: (error) {
          debugPrint("PayPal onError: $error");
          _toast('Greška u plaćanju: $error');
          if (mounted) Navigator.pop(context);
        },
        onCancel: () {
          debugPrint('PayPal cancelled');
          _toast('Plaćanje otkazano');
          if (mounted) Navigator.pop(context);
        },
      ),
    ));
  }

  Future<void> _startCashCheckout() async {
    if (_korpa == null || _korpa!.result.isEmpty) {
      _toast('Korpa je prazna.');
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Plaćanje gotovinom'),
        content:
            const Text('Želite li potvrditi narudžbu sa plaćanjem gotovinom?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Odustani')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Potvrdi')),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final id = await _cartProvider.checkoutFromCart(
          Authorization.userId!, null );
      if (!mounted) return;
      _toast('Narudžba #$id kreirana (gotovina).');
      await _fetchInitialData();
    } catch (e) {
      _toast('Greška pri kreiranju narudžbe: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtotalBAM = _calcSubtotalBAM();
    final subtotalEUR = _bamToEurStr(subtotalBAM);

    return WillPopScope(
      onWillPop: () async => false,
      child: MasterScreenWidget(
        title: "Moja korpa",
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : (_korpa == null || _korpa!.result.isEmpty)
                ? const Center(child: Text("Vasa korpa je prazna"))
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

                            final qty = (item.kolicina ?? 0);
                            final unitBAM = (item.cijena ?? 0);
                            final lineTotalBAM = unitBAM * qty;

                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            jelo.naziv ?? "Nepoznato jelo",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Cijena: ${unitBAM.toStringAsFixed(2)} KM',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Količina: $qty',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            nazivPriloga,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Ukupno za stavku: ${lineTotalBAM.toStringAsFixed(2)} KM',
                                            style: const TextStyle(
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
                                            await _fetchInitialData();
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: const BoxDecoration(
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
                                const Text(
                                  'Ukupno:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${subtotalBAM.toStringAsFixed(2)} KM',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '≈ u EUR (za PayPal):',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                Text(
                                  '$subtotalEUR EUR',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _startCashCheckout,
                                child: const Text('Plati gotovinom'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _startPaypalCheckout,
                                child: const Text('Plati sa PayPal'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
