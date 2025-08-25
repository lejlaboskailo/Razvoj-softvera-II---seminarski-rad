import 'package:badges/badges.dart' as custom_badges;
import 'package:erestoran_mobile/screens/cart_screen.dart';
import 'package:erestoran_mobile/screens/home_screen.dart';
import 'package:erestoran_mobile/screens/korisnik_profile_screen.dart';
import 'package:erestoran_mobile/screens/meni_screen.dart';
import 'package:erestoran_mobile/screens/preporuceni_screen.dart';
import 'package:erestoran_mobile/screens/recenzija_screen.dart';
import 'package:flutter/material.dart';

import 'package:erestoran_mobile/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:erestoran_mobile/models/korpa.dart';
import 'package:erestoran_mobile/models/search_result.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget? child;
  final String? title;
  final Widget? title_widget;
  const MasterScreenWidget({this.child, this.title, this.title_widget, Key? key})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  int _selectedIndex = 0;

  late CartProvider _cartProvider;
  Future<int>? _cartCountFuture;

  final List<Widget> _mainScreens =  [
    HomeScreen(),
    MeniScreen(),
    RecommendedJeloScreen(),
    CartScreen(),
  ];

  final Map<String, Widget> _moreOptions = const {
    'Recenzija': RecenzijaScreen(),
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartProvider = context.read<CartProvider>();
    _refreshCartCount();
  }

  void _refreshCartCount() {
    _cartCountFuture = _loadCartCount();
    if (mounted) setState(() {});
  }

  Future<int> _loadCartCount() async {
    try {
      final SearchResult<Korpa> data = await _cartProvider.get();
      int totalQty = 0;
      for (final item in data.result) {
        totalQty += item.kolicina ?? 0;
      }
      return totalQty;
    } catch (_) {
      return 0;
    }
  }

  void _onMainItemTapped(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => _mainScreens[index]),
    );
  }

  void _onMoreOptionSelected(String key) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => _moreOptions[key]!),
    ).then((_) => _refreshCartCount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 184, 178, 60),
        title: widget.title_widget ??
            Text(
              widget.title ?? "",
              style: const TextStyle(color: Colors.white),
            ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const KorisnikProfileScreen()),
              );
            },
          ),

          FutureBuilder<int>(
            future: _cartCountFuture,
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;
              return custom_badges.Badge(
                badgeContent: Text('$count', style: const TextStyle(color: Colors.white)),
                badgeColor: Colors.red,
                position: custom_badges.BadgePosition.topEnd(top: 0, end: 3),
                child: IconButton(
                  icon: const Icon(Icons.shopping_basket),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) =>  CartScreen()))
                        .then((_) => _refreshCartCount());
                  },
                ),
              );
            },
          ),
        ],
      ),

      body: widget.child ?? _mainScreens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) {
          _onMainItemTapped(i);
          _refreshCartCount();
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Početna'),
          const BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Meni'),
          const BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: 'Preporučena jela'),
          const BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Korpa'),
          BottomNavigationBarItem(
            icon: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: _onMoreOptionSelected,
              itemBuilder: (context) => _moreOptions.keys
                  .map((key) => PopupMenuItem<String>(value: key, child: Text(key)))
                  .toList(),
            ),
            label: 'Više',
          ),
        ],
        backgroundColor: Colors.blueGrey[900],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
      ),
    );
  }
}
