
import 'package:hive/hive.dart';

part 'notes.g.dart';
@HiveType(typeId: 1)
class Notes{
  @HiveField(0)
   String? title;
   @HiveField(1)
   String? content;
   @HiveField(2)
  String? key;
  Notes({required this.title,required this.content,this.key});
}