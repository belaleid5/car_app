import 'package:car_app/core/error/faliure.dart';
import 'package:dio/dio.dart'; // استيراد dio // كلاس الاستثناءات المخصص
import '../../../../core/shared/location_model.dart';

abstract class LocationsRemoteDataSource {
  Future<List<LocationModel>> getLocations(int page);
}

class LocationsRemoteDataSourceImpl implements LocationsRemoteDataSource {
  // غيّرنا التبعية من http.Client إلى Dio
  final Dio dio;

  // نقوم بتمرير Dio عبر الـ constructor
  LocationsRemoteDataSourceImpl({required this.dio} );

  @override
  Future<List<LocationModel>> getLocations(int page) async {
    try {
      // استخدم dio.get بدلاً من client.get
      // لا حاجة لوضع الرابط الكامل، فقط الـ endpoint لأن baseUrl موجود في DioClient
      final response = await dio.get(
        '/public/register_locations/', // فقط الـ endpoint
        queryParameters: {'page': page}, // طريقة dio لإضافة query params
      );

      // dio يتعامل مع response.statusCode تلقائيًا، وإذا لم يكن 2xx سيرمي DioException
      // والذي سيتم التقاطه بواسطة ErrorInterceptor الخاص بك أو في bloc الـ catch
      
      // الـ response.data يكون مفكوكًا (decoded) تلقائيًا بواسطة dio
      final List<dynamic> data = response.data['data'];
      
      // يمكنك أيضًا استخراج بيانات الـ meta إذا احتجت إليها في الـ Bloc
      // final Map<String, dynamic> meta = response.data['meta'];
      // final int lastPage = meta['last_page'];

      return data.map((item) => LocationModel.fromJson(item)).toList();

    } on DioException catch (e) {
      // يمكنك هنا التعامل مع أخطاء dio بشكل مخصص إذا أردت
      // أو يمكنك ترك ErrorInterceptor يقوم بالمهمة
      // على سبيل المثال، يمكنك تحويل DioException إلى ServerException المخصص
      print('DioException in DataSource: ${e.message}');
      throw ServerException('DioException in DataSource: ${e.message}'); // ارمِ الاستثناء المخصص الذي تفهمه طبقة الـ Repository
    } catch (e) {
      // للتعامل مع أي أخطاء أخرى غير متوقعة
      print('Unexpected error in DataSource: $e');
      throw ServerException('Unexpected error in DataSource: $e');
    }
  }
}
