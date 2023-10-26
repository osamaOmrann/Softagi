import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softagi/core/commons/commons.dart';
import 'package:softagi/core/routes/routes.dart';
import 'package:softagi/core/utils/colors.dart';
import 'package:softagi/core/widgets/product_widget.dart';
import 'package:softagi/layout/products/data/models/product_model.dart';

class ProductsScreen extends StatefulWidget {
  static String? name;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height, width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductsScreen.name ?? 'User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<ProductModel>(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitSpinningLines(color: AppColors.primary,),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final productModel = snapshot.data!;
              return GridView.builder(
                itemCount: productModel.data?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = productModel.data!.data![index];
                  return ProductWidget(product);
                  /*ListTile(
                    title: Text(product.name ?? ''),
                    subtitle: Text(product.description ?? ''),
                    leading: Image.network(product.image ?? ''),
                  );*/
                }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: .7,
                  crossAxisCount: 2, mainAxisSpacing: height * .01, crossAxisSpacing: height * .01),
              );
            } else {
              return Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final SharedPreferences s = await SharedPreferences.getInstance();
          await s.setString('token', '');
          await s.setString('name', '');
          navigateAndFinish(context: context, route: Routes.login);
        },
        child: Icon(Icons.logout),
      ),
    );
  }

  Future<ProductModel> fetchProducts() async {
    final dio = Dio();
    final SharedPreferences s = await SharedPreferences.getInstance();
    String? token = await s.getString('token');
    dio.options.headers['Authorization'] = token;
    dio.options.headers['lang'] = 'ar';
    dio.options.headers['Content-Type'] = 'application/json';

    try {
      final response = await dio.get('https://student.valuxapps.com/api/products/');
      final productModel = ProductModel.fromJson(response.data);
      return productModel;
    } catch (error) {
      throw Exception('Failed to load products');
    }
  }
}