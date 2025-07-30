import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/model.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Style.dart';
import '../../Providers/event_list_provider.dart';

class EventItem extends StatelessWidget {
  Event event;
   EventItem({super.key,required this.event});

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(event.imagePath),fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white
            ),
            child: Column(
              children: [
                Text(event.dateTime.day.toString(),
                  style: AppStyle.midam20Primary,),
                Text(DateFormat('MMM').format(event.dateTime),
                  style: AppStyle.midam20Primary,)
              ],
            )
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 1,horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 5
                    ,child: Text(event.title)),
                Expanded(child: IconButton(
                  onPressed: (){
                    eventListProvider.updateIsFavorite(event);
                  },
                  icon:Icon(event.isFavorite?
                  Icons.favorite:
                  Icons.favorite_border,color: AppColors.primaryColor,))),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
