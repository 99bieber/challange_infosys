import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';
import '../providers/auth_provider.dart';
import '../providers/product_provider.dart';
import '../shared/theme.dart';
import '../widgets/product_tile.dart';

FocusNode searchFocusNode = FocusNode();
bool isActiveSearch = false;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

var id = '';

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController searchController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProviders authProvider = Provider.of<AuthProviders>(context);
    UserModel profile = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Future getId() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getInt('id').toString();

      if (id != '') {
        authProvider.getUser(id: id);
      }
      return pref.getInt('id');
    }

    setState(() {
      getId();
      Provider.of<ProductProvider>(context, listen: false).getProducts();
      // super.initState();
    });

    Widget header() {
      return Container(
        color: c3,
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${profile.firstName} ${profile.lastName}',
                    style:
                        whiteTextStyle.copyWith(fontWeight: bold, fontSize: 24),
                  ),
                  Text(
                    '${profile.email}',
                    style: whiteTextStyle.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget productTitle() {
      return Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Text(
          'New Arrivals',
          style: c3TextStyle.copyWith(fontWeight: semiBold, fontSize: 22),
        ),
      );
    }

    Widget listProduct() {
      return Container(
        margin: const EdgeInsets.only(top: 14),
        child: Column(
          children: 
          productProvider.products
              .map(
                (product) => ProductTile(product),
              )
              .toList(),
        ),
      );
    }

    return ListView(
      children: [header(), productTitle(), listProduct()],
    );
  }
}
