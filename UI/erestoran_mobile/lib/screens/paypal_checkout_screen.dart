// lib/screens/paypal_checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/payment_provider.dart';

class PayPalCheckoutScreen extends StatefulWidget {
  final double amount;
  final int korisnikId;
  const PayPalCheckoutScreen({super.key, required this.amount, required this.korisnikId});

  @override
  State<PayPalCheckoutScreen> createState() => _PayPalCheckoutScreenState();
}

class _PayPalCheckoutScreenState extends State<PayPalCheckoutScreen> {
  WebViewController? _controller;
  String? _orderId;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      final payment = context.read<PaymentProvider>();
      final created = await payment.createPayPalOrder(widget.amount);
      _orderId = created['orderId'];
      final approveUrl = created['approveUrl']!;

      final c = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onNavigationRequest: (req) async {
            final url = req.url;
            // Backend je postavio ReturnUrl/CancelUrl:
            if (url.contains('/payments/paypal/success') && _orderId != null) {
              final narudzbaId = await payment.capturePayPalOrder(_orderId!, widget.korisnikId);
              if (!mounted) return NavigationDecision.prevent;
              Navigator.pop(context, narudzbaId); // vrati ID narudžbe roditelju
              return NavigationDecision.prevent;
            }
            if (url.contains('/payments/paypal/cancel')) {
              if (mounted) Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ))
        ..loadRequest(Uri.parse(approveUrl));

      setState(() => _controller = c);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Greška pri inicijalizaciji PayPala: $e')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayPal')),
      body: (_controller == null)
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _controller!),
    );
  }
}
