import 'package:flutter/material.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/cubits/write%20cubit/cubit/write_word_cubit.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isArabic = WriteWordCubit.get(context).isArabic;
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _text_field(isArabic),
          SizedBox(height: 10,),
          _done_button(context, isArabic),
        ],
      ),
    );
  }

  TextFormField _text_field(bool isArabic) {
    return TextFormField(
          textDirection: isArabic? TextDirection.rtl : TextDirection.ltr,
          controller: _text,
          validator: (value) =>  _validat_method(value),
          style: TextStyle(color: colorsdata.WhiteColor),
          cursorColor: colorsdata.WhiteColor,
          decoration: InputDecoration(
            label: Text(isArabic? 'اكتب كلمة' : 'input word', style: TextStyle(color: colorsdata.WhiteColor, fontWeight: FontWeight.bold),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: colorsdata.WhiteColor)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colorsdata.WhiteColor)),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            errorStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
  }

  InkWell _done_button(BuildContext context, bool isArabic) {
    return InkWell(
          onTap: () {
            if(_formkey.currentState?.validate() == true){
              WriteWordCubit.get(context).AddWord();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Success')),
              );
            }
          },
          child: Container(
            width: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorsdata.WhiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(isArabic? 'تأكيد' : 'Done', style: TextStyle(
                color: Color(WriteWordCubit.get(context).colorcode),
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
        );
  }

  dynamic _validat_method(String? value) {
    bool isArabic = WriteWordCubit.get(context).isArabic;
    if(value == null || value.isEmpty){
      if(isArabic){
        return '!الحقل فارغ';
      }
      return 'the field is empty';
    }
    List text = value.split('');
    for(String char in text){
      int charCode = char.codeUnitAt(0);
      if((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122)){ // english
        if(isArabic)  return 'ليس عربي " ${char} " هذا الحرف';

      }
      else if((charCode >= 1569 && charCode <= 1610)){ // arabic
        if(!isArabic) return 'the character " ${char} " is not an english character';
      }
      else {
        if(isArabic){
          return '!هذا الحرف " ${char} " غير مقبول';
        }
        return 'the character ${char} not avalaible!';
      }
    }
  }
}