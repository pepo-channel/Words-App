import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/models/word_model.dart';

part 'write_word_state.dart';

class WriteWordCubit extends Cubit<WriteWordState> {
  WriteWordCubit() : super(WriteWordInitial());
  static get(context) => BlocProvider.of(context); // to get access

  final Box<List<WordModel>> _box = Hive.box(kHiveBox);

  String text = '';
  bool isArabic = true;
  int colorcode = 0XFF1f1f1f;

  UpdateText(String text){
    this.text = text;
  }

  UpdateIsArabic(bool isArabic){
    this.isArabic = isArabic;
  }

  UpdateColorCode(int colorcode){
    this.colorcode = colorcode;
  }


  AddWord(){
    List<WordModel> words = _GetListFromBox();
    _TryAndCatch(
      words: words,
      errmsg: 'add this word',
      function: () {
        words.add(WordModel(
        indexAtdata: words.length, 
        text: text, 
        colorcode: colorcode, 
        isArabic: isArabic,
      ));
      },
    );
  }

  DeleteWord(int indexAtdata){
    List<WordModel> words = _GetListFromBox();
    _TryAndCatch(
      errmsg: 'delete this word',
      words: words,
      function: () {
        words.removeAt(indexAtdata);
        for(var i = indexAtdata; i < words.length; i++){
          words[i] = words[i].get_words_after_decrement();
        }
      },
    );
  }

  AddSimilarWrod(int indexAtdata){
    List<WordModel> words = _GetListFromBox();
    _TryAndCatch(
      words: words,
      errmsg: 'add this similar word',
      function: () {
        words[indexAtdata] = words[indexAtdata].AddSimilarWrod(isArabic, text);
      },
    );
  }

  DeleteSimilarWord(int indexAtdata, int IndexAtSimilarWords, bool isArabicSimilar){
    List<WordModel> words = _GetListFromBox();
    _TryAndCatch(
      words: words,
      errmsg: 'delete this similar word',
      function: () {
        words[indexAtdata] = words[indexAtdata].DeleteSimilarWords(isArabicSimilar, IndexAtSimilarWords);
      },
    );
  }

  AddExample(int indexAtdata, int IndexAtExamples, bool isArabicExample){
    List<WordModel> words = _GetListFromBox();
    _TryAndCatch(
      words: words,
      errmsg: 'add this example',
      function: () {
        words[indexAtdata] = words[indexAtdata].AddExamples(isArabicExample, text);
      },
    );
  }

  DeleteExample(int indexAtdata, int indexAtExamples, bool isArabicExample){
    List<WordModel> words = _GetListFromBox();
    _TryAndCatch(
      words: words,
      errmsg: 'delete this example',
      function: () {
        words[indexAtdata] = words[indexAtdata].DeleteExamples(isArabicExample, indexAtExamples);
      },
    );
  }

  _TryAndCatch({required VoidCallback? function, required String? errmsg, required List<WordModel> words}){
    emit(WriteWordLoading());
    try {
      function?.call();
      _box.put(kListWrods, words);
      emit(WriteWordSuccess());
    } catch (e) {
      emit(WriteWordFailed(message: 'there is a problem when $errmsg'));
    }
  }

  _GetListFromBox() =>List.from(_box.get(kListWrods, defaultValue: [])!).cast<WordModel>();
}
