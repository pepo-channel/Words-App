import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/cubits/read%20cubit/cubit/read_word_cubit.dart';
import 'package:word_app/cubits/write%20cubit/cubit/write_word_cubit.dart';
import 'package:word_app/features/home/widgets/Languages_widget.dart';
import 'package:word_app/features/home/widgets/colors_widget.dart';
import 'package:word_app/features/home/widgets/form_widget.dart';
import 'package:word_app/features/home/widgets/grid_texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbar(context),
        floatingActionButton: _FloatingActionButton(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [SizedBox(height: 20), GridTexts()]),
        ),
      ),
    );
  }

  FloatingActionButton _FloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed:
          () => showDialog(
            context: context,
            builder: (context) => _dialog(context),
          ),
      child: Container(
        decoration: BoxDecoration(
          color: colorsdata.ButtonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(Icons.add, color: colorsdata.WhiteColor, size: 40),
        ),
      ),
    );
  }

  Widget _dialog(context) => Dialog(
    child: BlocBuilder<WriteWordCubit, WriteWordState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 750),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(WriteWordCubit.get(context).colorcode),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LanguagesWidget(textcolor: Color(WriteWordCubit.get(context).colorcode),),
              SizedBox(height: 10),
              ColorsWidget(),
              SizedBox(height: 10),
              FormWidget(
                donetextcolor: WriteWordCubit.get(context).colorcode,
                formkey: _formkey,
                text: _text,
                Ontap: (){
                  if(_formkey.currentState?.validate() == true){
                    WriteWordCubit.get(context).UpdateText(_text.text);
                    WriteWordCubit.get(context).AddWord();
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
        );
      },
    ),
  );

  AppBar _appbar(context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: colorsdata.BaisicColor,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: colorsdata.WhiteColor, width: 2),
          ),
        ),
        child: BlocBuilder<ReadWordCubit, ReadWordState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ReadWordCubit.get(
                    context,
                  ).languageFilter.name, // deal with this
                  style: TextStyle(
                    color: colorsdata.WhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => _Filter_Dialog(context),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorsdata.ButtonColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.sort_by_alpha,
                        color: colorsdata.WhiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Dialog _Filter_Dialog(context) => Dialog(
    child: BlocBuilder<ReadWordCubit, ReadWordState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorsdata.BaisicColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _Label_text('Language'),
              SizedBox(height: 5),
              _Button_Method(
                labels: ['Arabic', 'English', 'All'],
                isactive: [
                  ReadWordCubit.get(context).languageFilter ==
                      LanguageFilter.ArabicOnly,
                  ReadWordCubit.get(context).languageFilter ==
                      LanguageFilter.EnglishOnly,
                  ReadWordCubit.get(context).languageFilter ==
                      LanguageFilter.AllWords,
                ],
                ontaps: [
                  () => ReadWordCubit.get(
                    context,
                  ).UpdateLanguageFilter(LanguageFilter.ArabicOnly),
                  () => ReadWordCubit.get(
                    context,
                  ).UpdateLanguageFilter(LanguageFilter.EnglishOnly),
                  () => ReadWordCubit.get(
                    context,
                  ).UpdateLanguageFilter(LanguageFilter.AllWords),
                ],
              ),
              SizedBox(height: 15),
              _Label_text('Sorted By'),
              SizedBox(height: 5),
              _Button_Method(
                labels: ['Time', 'Word Length'],
                isactive: [
                  ReadWordCubit.get(context).sortedBy == SortedBy.Time,
                  ReadWordCubit.get(context).sortedBy == SortedBy.TextLength,
                ],
                ontaps: [
                  () =>
                      ReadWordCubit.get(context).UpdateStoredBy(SortedBy.Time),
                  () => ReadWordCubit.get(
                    context,
                  ).UpdateStoredBy(SortedBy.TextLength),
                ],
              ),
              SizedBox(height: 15),
              _Label_text('Sorting type'),
              SizedBox(height: 5),
              _Button_Method(
                labels: ['Ascending', 'Descending'],
                isactive: [
                  ReadWordCubit.get(context).sortingType ==
                      SortingType.accending,
                  ReadWordCubit.get(context).sortingType ==
                      SortingType.deaccending,
                ],
                ontaps: [
                  () => ReadWordCubit.get(
                    context,
                  ).UpdateSortingType(SortingType.accending),
                  () => ReadWordCubit.get(
                    context,
                  ).UpdateSortingType(SortingType.deaccending),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  Widget _Button_Method({
    required List<String> labels,
    required List<bool> isactive,
    required List<void Function()?> ontaps,
  }) {
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++)
          InkWell(
            onTap: ontaps[i],
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isactive[i] ? colorsdata.WhiteColor : Colors.transparent,
                border: Border.all(color: colorsdata.WhiteColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                labels[i],
                style: TextStyle(
                  color:
                      isactive[i]
                          ? colorsdata.BaisicColor
                          : colorsdata.WhiteColor,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Text _Label_text(String text) {
    return Text(
      text,
      style: TextStyle(
        color: colorsdata.WhiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }
}
