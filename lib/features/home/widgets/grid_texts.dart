import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/cubits/read%20cubit/cubit/read_word_cubit.dart';
import 'package:word_app/features/word-details/screens/word_details.dart';
import 'package:word_app/models/word_model.dart';

class GridTexts extends StatelessWidget {
  const GridTexts({super.key});

  @override
  Widget build(BuildContext context) {
   List<WordModel> words = [];
    return BlocBuilder<ReadWordCubit, ReadWordState>(
      builder: (context, state) {
        if (state is ReadWordLoading) {
          return _Loading_Method();
        } else if (state is ReadWordSuccess) {
          if(state.words.isEmpty){
            return _Empty_Method();
          }
          words = List.from(state.words);
        } else if (state is ReadWordFailed) {
          return _Failed_Method(state);
        }
        return Expanded(
          child: GridView.builder(
            itemCount: words.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder:
                (context, index) => _wordItem(words[index], context),
          ),
        );
      },
    );
  }

  Widget _wordItem(WordModel word, context) => InkWell(
    onTap:
        () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WordDetails(word: word)),
        ).then((e)async{
          Future.delayed(Duration(milliseconds: 500)).then((e){
            ReadWordCubit.get(context).GetWords();
          });
        }); 
        },
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(word.colorcode),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          word.text,
          style: TextStyle(
            color: colorsdata.WhiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    ),
  );

  Widget _Failed_Method(ReadWordFailed state) {
    return Expanded(
      child: ListView(
        children: [
          SizedBox(height: 100,),
          SvgPicture.asset('assets/error.svg'),
          Text(
            textAlign: TextAlign.center,
            state.errormsg+'!',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _Loading_Method() {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text(
              'Loading',
              style: TextStyle(
                color: colorsdata.WhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Empty_Method() {
    return Expanded(
      child: ListView(
        children: [
          SizedBox(height: 100,),
          SvgPicture.asset('assets/empty.svg'),
          Text(
            'Empty!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
