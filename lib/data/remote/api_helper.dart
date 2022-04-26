import 'package:dio/dio.dart';
import 'package:fa_flutter_api_client/fa_flutter_api_client.dart';

abstract class ApiHelper extends ApiService {}

class ApiHelperImpl extends ApiServiceImpl implements ApiHelper {
  ApiHelperImpl({
    required String baseUrl,
    required List<Interceptor> interceptors,
  }) : super(
          baseUrl: baseUrl,
          interceptors: interceptors,
        );
}
