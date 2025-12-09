import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uterine_cancer_flutter_app/constants.dart';

class PredictionService {
  
  Future<Map<String, dynamic>> predict(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$kBaseUrl/api/predict'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      final responseData = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 && responseData['success']) {
        return {
          'success': true,
          'prediction': responseData['prediction'],
          'probability': responseData['probability'],
          'result_text': responseData['result_text'],
        };
      } else {
        return {
          'success': false,
          'error': responseData['error'] ?? 'فشل التنبؤ',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'حدث خطأ في الاتصال بالخادم: $e',
      };
    }
  }

  Future<List<dynamic>> getHistory(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$kBaseUrl/api/history/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 && responseData['success']) {
        return responseData['history'];
      } else {
        // يمكن التعامل مع الأخطاء هنا
        return [];
      }
    } catch (e) {
      // يمكن التعامل مع أخطاء الاتصال هنا
      return [];
    }
  }
}
