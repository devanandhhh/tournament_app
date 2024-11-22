import 'package:hive/hive.dart';
import 'package:tournament_creator/database/hive_model/notes.dart';
import 'package:tournament_creator/main.dart';

void update(Notes note){
  final hivebox= Hive.box(hivekey);
  final key=note.key;
  hivebox.put(key, note);
}
 savedata(Notes? notes){
 final akey = DateTime.now().millisecondsSinceEpoch.toString();
 notes?.key=akey;
 final databox=Hive.box(hivekey);
 databox.put(akey, notes);
  }