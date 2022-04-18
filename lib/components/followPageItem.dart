import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/gameModel.dart';
import 'package:like_button/like_button.dart';

// --------READ ME! READ ME!--------
// Currently makes errors because a lot of changes are needed for this to be re-useable.
// The whole FollowItem class will be commented out until it can be properly used in the follow_pages files
// This video can be used for reference: https://www.youtube.com/watch?v=jAxNZYX7mHM
// This as well, though I haven't watched this and it only has 1 like and 500 views: https://youtu.be/TQVzZZnYkTo 

// class FollowItem extends StatelessWidget {
//   // const FollowItem({ Key? key }) : super(key: key);

//   final Item item;
//   FollowItem ({ this.item });


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),  // Space between each list item
      
//       child: Row(
//         children: <Widget>[
//           // Card widget displays the image
//           Card(
//             clipBehavior: Clip.antiAlias,
            
//             // This changes the shape that the image is in
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),  
            
//             // This displays the image
//             child: AspectRatio(
//                 aspectRatio: 1,
//                 child: Image.network(
//                   item.backgroundImage,
//                   fit: BoxFit.cover,
//                 )),   
//           ),
          
//           // SizedBox widget acts as a spacer between image and game title
//           SizedBox(width: 8),
          
//           // Flexible widget to print out game titles
//           Flexible(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
              
//               // Game Title
//               children: <Widget>[
//                 Flexible(
//                   child: Text(
//                     item.name,
//                     // overflow: TextOverflow.ellipsis,  // This is to make the 2nd line of the name turned into ... instead of showing everything. Commented it out for now since it looks ugly.
                    
//                     style: listTextStyle,

//                   ),

//                 ),

//               ],

//             ),

//           ),

//           // Follow button
//           IconButton(
//             icon: Icon(icon),
//             color: accentColor,
//             onPressed: () {
//               setState( () {
//                 isSelected = !isSelected;
//                 icon = isSelected ? Icons.favorite : Icons.favorite_border;
//               });
//             }, 
//           ),

//         ],

//       ),

//     );
//   }
// }
