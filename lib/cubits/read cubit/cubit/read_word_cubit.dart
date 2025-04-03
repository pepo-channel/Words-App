import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/models/word_model.dart';
part 'read_word_state.dart';

class ReadWordCubit extends Cubit<ReadWordState> {
  ReadWordCubit() : super(ReadWordInitial());
  static ReadWordCubit get(context) => BlocProvider.of(context); // to get access
  
  final Box<List<WordModel>> _box = Hive.box(kHiveBox);

  LanguageFilter languageFilter = LanguageFilter.AllWords;
  SortedBy sortedBy = SortedBy.Time;
  SortingType sortingType = SortingType.accending;

  UpdateLanguageFilter(LanguageFilter languageFilter){
    this.languageFilter = languageFilter;
  }

  UpdateStoredBy(SortedBy sortedBy){
    this.sortedBy = sortedBy;
  }

  UpdateSortingType(SortingType sortingType){
    this.sortingType = sortingType;
  }

  GetWords(){
    emit(ReadWordLoading());
    try {
      List<WordModel> words = List.from(_box.get(kListWrods, defaultValue: [])!).cast<WordModel>();
      _RemoveUnWantedWords(words);
      _ApplySorting(words);
      emit(ReadWordSuccess(words: words));
    } catch (e) {
      emit(ReadWordFailed(errormsg: 'there is a problem when get words'));
    }
  }

  _RemoveUnWantedWords(List<WordModel> words){
    if(languageFilter == LanguageFilter.AllWords){
      return ;
    }
    for(var i = 0; i < words.length; i++){
      if(
        (languageFilter == LanguageFilter.ArabicOnly && words[i].isArabic == false) ||
        (languageFilter == LanguageFilter.EnglishOnly && words[i].isArabic == true)
      ){
        words.removeAt(i);
        i--; //
      }
    }
  }

  _ApplySorting(List<WordModel> words){
    if(sortedBy == SortedBy.Time){
      if(sortingType == SortingType.accending){
        return ;
      } else {
        _Reverse(words);
      }
    }else{
      words.sort((WordModel a, WordModel b)=> a.text.length.compareTo(b.text.length));
      if(sortingType == SortingType.accending){
        return ;
      } else {
        _Reverse(words);
      }
    }
  }

  _Reverse(List<WordModel> words) {
    for(var i = 0; i < words.length / 2; i++){
      WordModel temp = words[i];
      words[i] = words[words.length - 1 - i];
      words[words.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter {
  AllWords,
  ArabicOnly,
  EnglishOnly,
}

enum SortedBy {
  Time,
  TextLength,
}

enum SortingType {
  accending,
  deaccending
}