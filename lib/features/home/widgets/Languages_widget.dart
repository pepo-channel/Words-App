
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/cubits/write%20cubit/cubit/write_word_cubit.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({super.key, required this.textcolor});

  final List languages = const ['Ar', 'En'];
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WriteWordCubit, WriteWordState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: languages.length,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              return LanguageItem(
                languages[index],
                context,
                WriteWordCubit.get(context).isArabic, //
              );
            },
          ),
        );
      },
    );
  }

  Widget LanguageItem(String langtype, context, bool isArabic) {
    return InkWell(
      onTap: () {
        bool check = true;
        langtype == 'Ar' ? check = true : check = false;
        WriteWordCubit.get(context).UpdateIsArabic(check);//
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: (langtype == 'Ar' && isArabic == true) || (langtype == 'En' && isArabic == false) ? colorsdata.WhiteColor : Colors.transparent,//
          border: Border.all(width: 2, color: colorsdata.WhiteColor),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            langtype,
            style: TextStyle(
              color: (langtype == 'Ar' && isArabic == true) || (langtype == 'En' && isArabic == false) ? textcolor : colorsdata.WhiteColor,//
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
