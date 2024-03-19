import 'package:image_picker/image_picker.dart';

ImagePickers obj=ImagePickers();
ImagePicker2 obj2=ImagePicker2();

class ImagePickers {
  String imageLink = '';
  
  Future<void> imagePicking() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageLink = image.path.toString();
      print(imageLink);
    }
  }
}

class ImagePicker2 {
  String imagelink2= ''; 
  Future<void>imagePicking2()async{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image !=null){
      imagelink2=image.path.toString();
      print( imagelink2);
    }
  }
}
