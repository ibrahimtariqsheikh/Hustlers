import 'package:synew_gym/models/products.dart';
import 'package:synew_gym/constants/sanity_commands.dart';
import 'package:synew_gym/blocs/product/services/sanity_api_services.dart';

class ShopRepository {
  final SanityApiServices sanityApiServices;
  ShopRepository({
    required this.sanityApiServices,
  });

  // Future<List<Product>> fetchAll() async {
  //   List<Product> products = await sanityApiServices.fetchData(fetchAllQuery);
  //   return products;
  // }

  Future<List<Product>> fetchMensApparel() async {
    List<Product> products =
        await sanityApiServices.fetchData(mensApparelQuery);
    return products;
  }

  Future<List<Product>> fetchWomensApparel() async {
    List<Product> products =
        await sanityApiServices.fetchData(womensApparelQuery);
    return products;
  }

  Future<List<Product>> fetchMensFootwear() async {
    List<Product> products =
        await sanityApiServices.fetchData(mensFootWearQuery);
    return products;
  }

  Future<List<Product>> fetchWomensFootwear() async {
    List<Product> products =
        await sanityApiServices.fetchData(womensFootWearQuery);
    return products;
  }

  Future<List<Product>> fetchNutrition() async {
    List<Product> products = await sanityApiServices.fetchData(nutritionQuery);
    return products;
  }

  Future<List<Product>> fetchAccessories() async {
    List<Product> products =
        await sanityApiServices.fetchData(accessoriesQuery);
    return products;
  }
}
