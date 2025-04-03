import 'package:hive_flutter/adapters.dart';
import 'package:word_app/models/word_model.dart';

class WordTypeadapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
      indexAtdata: reader.readInt(), 
      text: reader.readString(), 
      colorcode: reader.readInt(), 
      isArabic: reader.readBool(),
      ArabicSimilarWords: reader.readStringList(),
      EnglishSimilarWords: reader.readStringList(),
      ArabicExamples: reader.readStringList(),
      EnglishExamples: reader.readStringList(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeInt(obj.indexAtdata);
    writer.writeString(obj.text);
    writer.writeInt(obj.colorcode);
    writer.writeBool(obj.isArabic);
    writer.writeStringList(obj.ArabicSimilarWords);
    writer.writeStringList(obj.EnglishSimilarWords);
    writer.writeStringList(obj.ArabicSimilarWords);
    writer.writeStringList(obj.EnglishExamples);
  }
  
}