import 'package:flutter/material.dart';
import 'package:word_app/cubits/read%20cubit/cubit/read_word_cubit.dart';
import 'package:word_app/cubits/write%20cubit/cubit/write_word_cubit.dart';
import 'package:word_app/features/home/widgets/Languages_widget.dart';
import 'package:word_app/features/home/widgets/form_widget.dart';

class DialogAddSimilarOrExampleWidget extends StatefulWidget {
  const DialogAddSimilarOrExampleWidget({
    super.key,
    required this.colorcode, 
    required this.isExample, 
    required this.indexAtdata, 
  });

  final int colorcode;
  final int indexAtdata;
  final bool isExample;

  @override
  State<DialogAddSimilarOrExampleWidget> createState() => _DialogAddSimilarOrExampleWidgetState();
}

class _DialogAddSimilarOrExampleWidgetState extends State<DialogAddSimilarOrExampleWidget> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(widget.colorcode),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LanguagesWidget(textcolor: Color(widget.colorcode),),
          SizedBox(height: 20,),
          FormWidget(
            donetextcolor: widget.colorcode,
            formkey: _formkey,
            text: _text,
            Ontap: () {
              if(_formkey.currentState?.validate() == true){
                WriteWordCubit.get(context).UpdateText(_text.text);
                if(widget.isExample){
                  WriteWordCubit.get(context).AddExample(widget.indexAtdata, WriteWordCubit.get(context).isArabic);
                }
                else {
                  WriteWordCubit.get(context).AddSimilarWrod(widget.indexAtdata, WriteWordCubit.get(context).isArabic);
                }
                ReadWordCubit.get(context).GetWords();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Success')),
                );
              }
            },  
          ),
        ],
      ),
    ),
    );
  }
}