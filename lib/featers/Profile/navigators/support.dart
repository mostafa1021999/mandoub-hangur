import 'package:flutter/material.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/constants/constanat.dart';
import '../../../common/translate/strings.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> itemsAr=[
  Item(headerValue: 'ما هي الخدمات التي يقدّمها تطبيق تسلم؟',
    expandedValue: 'يعد تطبيق تسلم منصة متكاملة بها خدمتين رئيسيين وهما توصيل طلبات المطاعم والمتاجر بالإضافة إلى خدمة تسلم للتوصيل الخاص.',),
  Item(headerValue: 'أين يمكنني استخدام تطبيق تسلم؟',
    expandedValue: 'تغطي مناطق عمل التطبيق في الوقت الحالي مدينتيّ الرياض و جدة و مكة، ويتم العمل على خطة توسع لتغطية مناطق أكثر حول المملكة.',),
  Item(headerValue: 'ما الذي يميّز تسلم عن غيره من التطبيقات؟',
    expandedValue: 'يتيح لكم الانضمام إلى تسلم فرصاً أكبر لكسب دخل إضافي مع إمكانيّة اختيار ساعات العمل الأنسب لكم. كما يضع بين أيديكم فريق دعم متخصص للإجابة على استفساراتكم ودعمكم على مدار الساعة بشكل يدعم روح الفريق.',),
  Item(headerValue: 'من هو ممثل تسلم؟',
    expandedValue: 'ممثل تسلم هو الشخص الذي يقوم بتقديم خدمات توصيل الطلبات لكسب دخل إضافي مع تسلم. ولأننا نعتز بهؤلاء الأفراد ونتشارك مبدأ أهميّة العمل معهم، تم اختيار اسم ممثلي تسلم، حيث يلعب كل منهم دوراً مهماً في تقديم أفضل الخدمات وتمثيل صورة التطبيق للعملاء.',),
  Item(headerValue: 'ما هي ساعات العمل في تسلم؟',
    expandedValue: 'تقدّم خدمات تسلم على مدار الساعة لضمان تلبية احتياجات الجميع.',),
  Item(headerValue: 'موقع مكتب ممثلي تسلم بمدينه مكة',
    expandedValue: 'https://maps.app.goo.gl/5gZZ3mueaxQREL1cA',),
  Item(headerValue: 'موقع مكتب ممثلي تسلم بمدينه جدة',
    expandedValue: 'https://maps.app.goo.gl/t3y7VxpixrtQSZGm9',),
  Item(headerValue: 'ما هي متطلبات التسجيل؟',
    expandedValue: 'يجب توفير المتطلبات التالية للتسجيل كممثل لتوصيل الركاب: مستندات سارية الصلاحية(بطاقة الأحوال أو الإقامة لغير السعوديين، رخصة، استمارة، تأمين) - اللباس الرسمي - جوال أندرويد نسخة ٥.١ أو أحدث - سيارة نظيفة وبدون أضرار في الهيكل بموديل لا يتعدى خمس سنوات'),
  Item(headerValue: 'هل هناك جلسات تدريب للممثلين؟',
    expandedValue: 'يخضع كافة ممثلي تويو لجلسة تدريب مدتها ٤٥ دقيقة يتم خلالها شرح وتقديم أساسيات العمل في تسلم والمهارات التي يجب توفرها لدى الممثلين لضمان جودة الخدمة.',),
  Item(headerValue: 'كيف يتم ترتيب مواعيد جلسات التدريب؟',
    expandedValue: 'بعد إتمام عملية التسجيل، يقوم فريق النقليات بالتواصل مع المتقدمين وترتيب الموعد المناسب لحضور التدريب في مكتب تدريب الممثلين.',),
  Item(headerValue: 'هل يوجد رسوم للتسجيل في تسلم؟',
    expandedValue: 'لا يوجد اى رسوم تسجيل لممثلي توصيل طلبات المطاعم.',),
];
List<Item> itemsEn=[
  Item(headerValue: 'What are the services provided by Teslm?',
    expandedValue: 'Deliver is an integrated platform application with two main services: delivering orders from restaurants and stores, as well as a dedicated delivery service.',),
  Item(headerValue: 'In which cities does ToYou operate?',
    expandedValue: 'We currently operate in both Riyadh, Jeddah and Makkah, with a plan to expand steadily across the Kingdom.',),
  Item(headerValue: 'What makes Teslm a better choice?',
    expandedValue: 'Joining Deliver offers you greater opportunities to earn additional income, with the ability to choose the work hours most suitable for you. It also provides you with a specialized support team to answer your inquiries and support you around the clock in a way that fosters a team spirit.',),
  Item(headerValue: 'What is a “Representative”?',
    expandedValue: 'A Deliver representative is the individual who provides order delivery services to earn additional income with Deliver. As we take pride in these individuals and share the principle of the importance of working with them, the title "Deliver representatives" was chosen, where each of them plays an important role in providing the best services and representing the image of the application to customers.',),
  Item(headerValue: 'What are the operating hours for Teslm?',
    expandedValue: "Deliver provides 24/7 services to ensure meeting everyone's needs.",),
  Item(headerValue: 'Makkah Representative Office Location',
    expandedValue: 'https://maps.app.goo.gl/5gZZ3mueaxQREL1cA',),
  Item(headerValue: 'Jedda Representative Office Location',
    expandedValue: 'https://maps.app.goo.gl/t3y7VxpixrtQSZGm9',),
  Item(headerValue: 'What are the sign-up requirements?',
    expandedValue: "Here are the requirements that must be met to register as a passenger delivery representative: Valid documents (ID card or residence permit for non-Saudis, driver's license, registration form, insurance)Professional attire - Android mobile device with version 5.1 or newer - A clean car without structural damage and no more than 5 years old",),
  Item(headerValue: 'Do Representatives take training?',
    expandedValue: 'All our Representatives take a 45 min orientation session, where they are familiarized with all our quality standards, and work requirements.',),
  Item(headerValue: 'How are training sessions arranged?',
    expandedValue: 'After registration, our Fleet team members will contact the applicants and book an appointment for them at the ToYou Representative Training Center.',),
  Item(headerValue: 'Is there a registration fee?',
    expandedValue: 'There are no registration fees for restaurant delivery representatives.',),
];

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() =>
      _Support();
}

class _Support extends State<Support> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.helpSupport.tr(context)),),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(language=='en'? itemsEn:itemsAr),
        ),
      ),
    );
  }

  Widget _buildPanel(items) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          items[index].isExpanded = isExpanded;
        });
      },
      children: items.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader:true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,),),
            );
          },
          body: Container(
            child: Visibility(
              visible: item.isExpanded,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                opacity: item.isExpanded ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                child:Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: item.expandedValue=='https://maps.app.goo.gl/t3y7VxpixrtQSZGm9'?(){_launchUrl('https://maps.app.goo.gl/t3y7VxpixrtQSZGm9');}:item.expandedValue=='https://maps.app.goo.gl/5gZZ3mueaxQREL1cA'? (){_launchUrl('https://maps.app.goo.gl/5gZZ3mueaxQREL1cA');}:null,
                        child: Text(item.expandedValue,style: TextStyle(fontSize:16,fontWeight: FontWeight.w400,),)),
                  ),
                ),
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
  Future<void> _launchUrl(url) async {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
  }
}
