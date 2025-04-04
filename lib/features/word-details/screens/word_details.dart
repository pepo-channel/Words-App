import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/cubits/read%20cubit/cubit/read_word_cubit.dart';
import 'package:word_app/cubits/write%20cubit/cubit/write_word_cubit.dart';
import 'package:word_app/features/word-details/widgets/dialog_widget.dart';
import 'package:word_app/models/word_model.dart';

class WordDetails extends StatefulWidget {
  const WordDetails({super.key, required this.word});

  final WordModel word;

  @override
  State<WordDetails> createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {

  late WordModel word;

  @override
  void initState() {
    word = widget.word;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),

        child: BlocBuilder<ReadWordCubit, ReadWordState>(

          builder: (context, state) {
            if(state is ReadWordSuccess){
              int currentindex = state.words.indexWhere((element) => element.indexAtdata == word.indexAtdata); // to know word index in database
              word = state.words[currentindex];
            }

            return ListView(
              children: [

                SizedBox(height: 30),

                _Type_Text((word.isArabic ? 'الكلمة' : 'Word'), word.isArabic),

                SizedBox(height: 10),

                _Word_Method(
                  isarabic: word.isArabic,
                  text: word.text,
                  context: context,
                  candelete: false,
                ),

                SizedBox(height: 30),

                _Type_Header(
                  (word.isArabic ? 'كلمات مشابهة' : 'Similar Words'),
                  () => showDialog(
                    context: context,
                    builder:
                        (context) => DialogAddSimilarOrExampleWidget(
                          colorcode: word.colorcode,
                          indexAtdata: word.indexAtdata,
                          isExample: false,
                        ),
                  ),
                ),

                for (var i = 0; i < word.ArabicSimilarWords.length; i++) // arabic similar
                  _Word_Method(
                    context: context,
                    isarabic: true,
                    text: word.ArabicSimilarWords[i],
                    candelete: true,
                    isExample: false,
                    index: i ,
                    indexAtdata: word.indexAtdata,
                  ),
                  
                for (var i = 0; i < word.EnglishSimilarWords.length; i++) // english similar
                  _Word_Method(
                    context: context,
                    isarabic: false,
                    text: word.EnglishSimilarWords[i],
                    candelete: true,
                    isExample: false,
                    index: i,
                    indexAtdata: word.indexAtdata,
                  ),

                SizedBox(height: 30),

                _Type_Header(
                  (word.isArabic ? 'أمثلة' : 'Examples'),
                  () => showDialog(
                    context: context,
                    builder:
                        (context) => DialogAddSimilarOrExampleWidget(
                          colorcode: word.colorcode,
                          indexAtdata: word.indexAtdata,
                          isExample: true,
                        ),
                  ),
                ),

                for (var i = 0; i < word.ArabicExamples.length; i++) // arabic example
                  _Word_Method(
                    context: context,
                    isarabic: true,
                    text: word.ArabicExamples[i],
                    candelete: true,
                    isExample: true,
                    index: i,
                    indexAtdata: word.indexAtdata,
                  ),
                  
                for (var i = 0; i < word.EnglishExamples.length; i++) // english example
                  _Word_Method(
                    context: context,
                    isarabic: false,
                    text: word.EnglishExamples[i],
                    candelete: true,
                    isExample: true,
                    index: i,
                    indexAtdata: word.indexAtdata,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Row _Type_Header(String text, void Function()? ontap) {
    return Row(
      textDirection: word.isArabic ? TextDirection.rtl : TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Type_Text(text, false),
        InkWell(
          onTap: ontap,
          child: Container(
            width: 80,
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(word.colorcode),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(Icons.add, size: 25, color: colorsdata.BaisicColor),
            ),
          ),
        ),
      ],
    );
  }

  Text _Type_Text(String text, bool isArabic) {
    return Text(
      textAlign: isArabic? TextAlign.right : TextAlign.left,
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Color(word.colorcode),
      ),
    );
  }

  Container _Word_Method({
    int? indexAtdata,
    int? index,
    bool? isExample,
    required bool isarabic,
    required String text,
    required context,
    required bool candelete,
  }) {
    // print(isarabic);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(word.colorcode),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        textDirection: word.isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: colorsdata.BaisicColor,
            child: Text(
              isarabic ? 'Ar' : 'En',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(word.colorcode),
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            alignment: isarabic? Alignment.topRight : Alignment.topLeft,
            width: MediaQuery.of(context).size.width - 200,
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: colorsdata.BaisicColor,
              ),
            ),
          ),
          candelete ? Spacer() : SizedBox(),
          candelete
              ? InkWell(
                onTap: () {
                  if(isExample == true){
                    WriteWordCubit.get(context).DeleteExample(indexAtdata!, index!, isarabic);
                  }
                  else if(isExample == false){
                    WriteWordCubit.get(context).DeleteSimilarWord(indexAtdata!, index!, isarabic);
                  }
                  ReadWordCubit.get(context).GetWords();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deleted')),
                  );
                },
                child: Icon(
                  Icons.delete,
                  color: colorsdata.BaisicColor,
                  size: 30,
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }

  AppBar _appbar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      backgroundColor: colorsdata.BaisicColor,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(word.colorcode), width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Color(word.colorcode),
              ),
            ),
            Text(
              'Word Details',
              style: TextStyle(
                color: Color(word.colorcode),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            InkWell(
              onTap: () async{
                WriteWordCubit.get(context).DeleteWord(word.indexAtdata);
                Navigator.pop(context);
              },
              child: Icon(Icons.delete, color: Color(word.colorcode), size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
