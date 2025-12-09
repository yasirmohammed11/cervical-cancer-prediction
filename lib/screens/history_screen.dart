import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uterine_cancer_flutter_app/services/auth_service.dart';
import 'package:uterine_cancer_flutter_app/services/prediction_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<dynamic>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    final authService = Provider.of<AuthService>(context, listen: false);
    final predictionService = PredictionService();
    if (authService.userId != null) {
      _historyFuture = predictionService.getHistory(authService.userId!);
    } else {
      _historyFuture = Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'سجل التنبؤات',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'عرض جميع التنبؤات السابقة التي قمت بإجرائها.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Divider(height: 32),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _historyFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('لا يوجد سجل تنبؤات.'));
                } else {
                  final history = snapshot.data!;
                  return ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final record = history[index];
                      final isPositive = record['result'] == 'إيجابي';
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: isPositive ? Colors.red.shade50 : Colors.green.shade50,
                        child: ListTile(
                          leading: Icon(
                            isPositive ? Icons.warning : Icons.check_circle,
                            color: isPositive ? Colors.red : Colors.green,
                          ),
                          title: Text(
                            'النتيجة: ${record['result']}',
                            style: TextStyle(fontWeight: FontWeight.bold, color: isPositive ? Colors.red.shade900 : Colors.green.shade900),
                          ),
                          subtitle: Text(
                            'التاريخ: ${record['date']}\nالاحتمالية: ${record['probability']}%',
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // يمكن إضافة شاشة تفاصيل لعرض بيانات الإدخال
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تفاصيل التنبؤ رقم ${record['id']}')),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
