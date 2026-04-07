import 'package:ai_setu/modules/inventory/recipe/controllers/recipe_controller.dart';
import 'package:get/get.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeController>(() => RecipeController());
  }
}
