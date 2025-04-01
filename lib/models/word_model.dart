class WordModel {
  final int indexAtdata;
  final String text;
  final int colorcode;
  final bool isArabic;
  final List<String> ArabicSimilarWords;
  final List<String> EnglishSimilarWords;
  final List<String> ArabicExamples;
  final List<String> EnglishExamples;

  const WordModel({
    required this.indexAtdata,
    required this.text,
    required this.colorcode,
    required this.isArabic,
    this.ArabicSimilarWords = const [],
    this.EnglishSimilarWords = const [],
    this.ArabicExamples = const [],
    this.EnglishExamples = const [],
  });

  List<String> _get_initialize_similar_word(bool isArabicSimilar) {
    if(isArabicSimilar){
      return List.from(ArabicSimilarWords);
    } else {
      return List.from(EnglishSimilarWords);
    }
  }

  WordModel _get_word_after_check_similar(bool isArabicSimilar, List<String> newSimilarwords) {
    return WordModel(
    indexAtdata: indexAtdata,
    text: text, 
    colorcode: colorcode, 
    isArabic: isArabic,
    ArabicSimilarWords: isArabicSimilar ? newSimilarwords : ArabicSimilarWords, //
    EnglishSimilarWords: ! isArabicSimilar ? newSimilarwords : EnglishSimilarWords, //
    ArabicExamples: ArabicExamples,
    EnglishExamples: EnglishExamples,
    );
  }

  WordModel AddSimilarWrod(bool isArabicSimilar, String similarword){
    List<String> newSimilarwords = _get_initialize_similar_word(isArabicSimilar);
    newSimilarwords.add(similarword);
    return _get_word_after_check_similar(isArabicSimilar, newSimilarwords);
  }

  WordModel DeleteSimilarWords(bool isArabicSimilar, int IndexAtSimilarWords){
    List<String> newSimilarwords = _get_initialize_similar_word(isArabicSimilar);
    newSimilarwords.removeAt(IndexAtSimilarWords);
    return _get_word_after_check_similar(isArabicSimilar, newSimilarwords);
  }

  List<String> _get_initialize_example_word(bool isArabicExample) {
    if(isArabicExample){
      return List.from(ArabicExamples);
    } else {
      return List.from(EnglishExamples);
    }
  }

  WordModel _get_word_after_check_example(bool isArabicExample, List<String> newexamples) {
    return WordModel(
    indexAtdata: indexAtdata, 
    text: text, 
    colorcode: colorcode, 
    isArabic: isArabic,
    ArabicSimilarWords: ArabicSimilarWords,
    EnglishSimilarWords: EnglishSimilarWords,
    ArabicExamples: isArabicExample ? newexamples : ArabicExamples, //
    EnglishExamples: ! isArabicExample ? newexamples : EnglishExamples, //
  );
  }

  WordModel AddExamples(bool isArabicExample, String example){

    List<String> newExamples = _get_initialize_example_word(isArabicExample);
    newExamples.add(example);

    return _get_word_after_check_example(isArabicExample, newExamples);
  }

  WordModel DeleteExamples(bool isArabicExample, int indexAtExamples){

    List<String> newExamples = _get_initialize_example_word(isArabicExample);
    newExamples.removeAt(indexAtExamples);

    return WordModel(indexAtdata: indexAtdata, text: text, colorcode: colorcode, isArabic: isArabic);
  }

  WordModel get_words_after_decrement (){
    return WordModel(
      indexAtdata: indexAtdata - 1, //
      text: text, 
      colorcode: colorcode, 
      isArabic: isArabic,
      ArabicSimilarWords: ArabicSimilarWords,
      EnglishSimilarWords: EnglishSimilarWords,
      ArabicExamples: ArabicExamples,
      EnglishExamples: EnglishExamples,
      );
  }
}