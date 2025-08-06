import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Providers/event_list_provider.dart';
import 'package:untitled15/ui/Login/Form_Fild_Widgit.dart';
import 'package:untitled15/ui/Widgit/Event_Item.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Style.dart';

class LoveTap extends StatefulWidget {
   LoveTap({super.key});

  @override
  State<LoveTap> createState() => _LoveTapState();
}

class _LoveTapState extends State<LoveTap> {
   TextEditingController controller=TextEditingController();
   late EventListProvider eventListProvider;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      eventListProvider.favoriteList;
    });
  }

  @override
  Widget build(BuildContext context) {
     eventListProvider=Provider.of<EventListProvider>(context);

    return SafeArea(
      child: Scaffold(
        body:Column(
      children: [
        FormFieldWidgit(
          onChanged: (text) {
            print(text);
          },
          controller: controller,
          colorSide: AppColors.primaryColor,
        textHint: 'Search for Event',
          iconPrefix: Icon(Icons.search,color: AppColors.primaryColor,),
          textStyle: AppStyle.midam20Primary.copyWith(fontSize: 16),
        ),
      SizedBox(height: 2,),
      Expanded(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            return EventItem(event: eventListProvider.favoriteList[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10,);
          },
          itemCount: eventListProvider.favoriteList.length),
      )
      ],
      ),
      ),
    );
  }

}
