import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
         backgroundColor:Color(0xff06d6a0),
        title: Text("عن التطبيق"),
       
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            height: 180,
            color: Theme.of(context).cardColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 95,
                  child: Image.asset("assets/playstore.png"),
                ),
                Text(
                  "اغاثة",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 23),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              """هذا المشروع بالتعاون مع أكاديمية الكفيل للإسعاف والتدريب الطبي ومبادرة البرمجة من اجل العراق""",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              """هدف المشروع: وهو لتسهيل عملية اسعاف المرضى او المصابين من خلال تحديد موقع المسعف وايصاله الى أقرب سيارة اسعاف عليه او بفريق طبي إذا اطرت الحالة.
عمل المشروع: تحديد موقع المسعفين وسيارات الإسعاف لتوجيههم بشكل أفضل.""",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          DataTable(

            columns: [
              DataColumn(
                label: Text(
                  'الدور',
                  style: TextStyle(fontFamily: 'Tajawal'),
                ),
              ),
              DataColumn(
                label: Text(
                  'الاسم',
                  style: TextStyle(fontFamily: 'Tajawal'),
                ),
              ),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(
                    Text(
                    'مدير مشروع',
                    
                    style: TextStyle(fontFamily: 'Tajawal',),
                  )),
                  DataCell(Text(
                    'محمد منتظر جلال حسين',
                    style: TextStyle(fontFamily: 'Tajawal'),
                  )),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text(
                    'مبرمج ويب',
                    style: TextStyle(fontFamily: 'Tajawal'),
                  )),
                  DataCell(Text(
                    'براق نزار',
                    style: TextStyle(fontFamily: 'Tajawal'),
                  )),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text(
                    'مبرمج تطبيقات',
                    style: TextStyle(fontFamily: 'Tajawal'),
                  )),
                  DataCell(Text(
                    'فهد محفوظ محمد',
                    style: TextStyle(fontFamily: 'Tajawal'),
                  )),
                ],
              ),
              
            ],
          ),
         
        ],
      ),
    );
  }
}
