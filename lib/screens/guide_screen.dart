import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'دليل استخدام التطبيق',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'هذا الدليل يوضح كيفية استخدام نموذج التنبؤ بالسرطان الرحمي بشكل فعال.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Divider(height: 30),
          
          _GuideSection(
            title: '1. البيانات الأساسية',
            content: 'تأكد من إدخال بيانات العمر، وعدد الشركاء الجنسيين، وسن أول علاقة جنسية، وعدد مرات الحمل بدقة. هذه البيانات هي أساس التنبؤ.',
          ),
          _GuideSection(
            title: '2. العادات الصحية',
            content: 'أدخل معلومات التدخين وموانع الحمل الهرمونية واللولب (IUD) بصدق. هذه العوامل تؤثر بشكل كبير على احتمالية الإصابة.',
          ),
          _GuideSection(
            title: '3. الأمراض المعدية الجنسية (STDs)',
            content: 'في حال وجود أي تاريخ للإصابة بأمراض معدية جنسياً، يرجى تحديدها. وجود فيروس الورم الحليمي البشري (HPV) ونوعه يعتبر معلومة حاسمة.',
          ),
          _GuideSection(
            title: '4. نتائج الفحوصات',
            content: 'أدخل نتائج الفحوصات المخبرية والسريرية السابقة مثل مسحة عنق الرحم، واختبارات Hinselmann، Schiller، Cytology، والخزعة (Biopsy).',
          ),
          _GuideSection(
            title: '5. الأعراض والمؤشرات الحيوية',
            content: 'قم بتحديد أي أعراض حالية مثل النزيف أو الإفرازات غير الطبيعية. كما يجب إدخال بيانات المؤشرات الحيوية مثل مستوى p16/ki-67 ودرجة الالتهاب إن وجدت.',
          ),
          _GuideSection(
            title: '6. النتيجة',
            content: 'بعد إدخال جميع البيانات، اضغط على "إجراء التنبؤ". ستظهر لك النتيجة (إيجابي/سلبي) مع نسبة الاحتمالية. هذه النتيجة هي تقييم إحصائي وليست تشخيصاً طبياً نهائياً.',
          ),
          SizedBox(height: 20),
          Text(
            'ملاحظة هامة: هذا التطبيق هو أداة مساعدة ولا يغني عن استشارة الطبيب المختص.',
            style: TextStyle(fontSize: 14, color: Colors.red, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _GuideSection extends StatelessWidget {
  final String title;
  final String content;

  const _GuideSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
