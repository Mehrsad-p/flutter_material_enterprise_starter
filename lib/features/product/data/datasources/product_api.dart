import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/product_dto.dart';
import '../dto/create_product_request_dto.dart';

part 'product_api.g.dart';

@RestApi()
abstract class ProductApi {
  factory ProductApi(Dio dio, {String baseUrl}) = _ProductApi;

  @GET('/products/{id}')
  Future<ProductDto> getProduct(@Path('id') String id);

  @POST('/products')
  Future<ProductDto> createProduct(@Body() CreateProductRequestDto request);
}
