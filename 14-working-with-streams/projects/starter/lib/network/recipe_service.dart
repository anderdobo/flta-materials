// 1
import 'package:chopper/chopper.dart';
import 'recipe_model.dart';
import 'model_response.dart';
import 'model_converter.dart';
import 'service_interface.dart';
part 'recipe_service.chopper.dart';

// 2
const String apiKey = '13a052bb0ed69c91b4986f72a629cb08';
const String apiId = '430c5ea4';
// 3
final apiUrl = Uri(
  scheme: 'https',
  host: 'api.edamam.com',
);

// 1
@ChopperApi()
// 2
abstract class RecipeService extends ChopperService
    implements ServiceInterface {
// 3
  @override
  @Get(path: 'search')
// 4
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
// 5
      @Query('q') String query,
      @Query('from') int from,
      @Query('to') int to);
  static RecipeService create() {
// 1
    final client = ChopperClient(
// 2
      baseUrl: apiUrl,
// 3
      interceptors: [_addQuery, HttpLoggingInterceptor()],
// 4
      converter: ModelConverter(),
// 5
      errorConverter: const JsonConverter(),
// 6
      services: [
        _$RecipeService(),
      ],
    );
// 7
    return _$RecipeService(client);
  }
}

Request _addQuery(Request req) {
// 1
  final params = Map<String, dynamic>.from(req.parameters);
// 2
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
// 3
  return req.copyWith(parameters: params);
}
