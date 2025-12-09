import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'عن البرنامج',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'تطبيق التنبؤ بسرطان الرحم هو أداة ذكية تهدف إلى مساعدة الأطباء والباحثين في تقييم احتمالية إصابة المريضة بسرطان عنق الرحم بناءً على مجموعة واسعة من البيانات السريرية والديموغرافية.',
            style: TextStyle(fontSize: 16),
          ),
          const Divider(height: 30),
          
          _InfoTile(
            icon: Icons.model_training,
            title: 'النموذج المستخدم',
            subtitle: 'يعتمد التطبيق على نموذج تعلم آلي متقدم (تم تدريبه باستخدام مكتبة scikit-learn) تم تطويره وتحسينه باستخدام مجموعة بيانات شاملة تتضمن ميزات إضافية حديثة لزيادة دقة التنبؤ.',
          ),
          _InfoTile(
            icon: Icons.security,
            title: 'الخصوصية والأمان',
            subtitle: 'يتم التعامل مع بيانات المستخدمين بسرية تامة. يتم تخزين سجلات التنبؤات في قاعدة بيانات آمنة ومرتبطة بحساب المستخدم لتمكينه من تتبع تاريخه الطبي.',
          ),
          _InfoTile(
            icon: Icons.warning_amber,
            title: 'إخلاء المسؤولية الطبية',
            subtitle: 'النتائج المقدمة من هذا التطبيق هي لأغراض إحصائية ومعلوماتية فقط، ولا تشكل تشخيصًا طبيًا. يجب دائمًا استشارة طبيب مختص لاتخاذ القرارات الطبية.',
          ),
          _InfoTile(
            icon: Icons.code,
            title: 'تقنية التطوير',
            subtitle: 'تم تطوير هذا التطبيق باستخدام إطار عمل فلاتر (Flutter) لتوفير تجربة مستخدم سلسة ومتعددة المنصات، مع واجهة برمجية خلفية (API) مبنية على Flask و Python.',
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              'assets/images/app_logo.png',
              height: 80,
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'الإصدار 1.0.0',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: Theme.of(context).primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
