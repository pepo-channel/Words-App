import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/cubits/read%20cubit/cubit/read_word_cubit.dart';
import 'package:word_app/cubits/write%20cubit/cubit/write_word_cubit.dart';
import 'package:word_app/features/home/widgets/Languages_widget.dart';
import 'package:word_app/features/home/widgets/colors_widget.dart';
import 'package:word_app/features/home/widgets/form_widget.dart';
import 'package:word_app/models/word_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbar(),
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
              LanguagesWidget(),
              SizedBox(height: 10),
              ColorsWidget(),
              SizedBox(height: 10),
              FormWidget(),
            ],
          ),
        );
      },
    ),
  );

  AppBar _appbar() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: colorsdata.BaisicColor,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: colorsdata.WhiteColor, width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'All Words',
              style: TextStyle(
                color: colorsdata.WhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            InkWell(
              onTap: () {
                //
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
        ),
      ),
    );
  }
}

class GridTexts extends StatelessWidget {
  const GridTexts({super.key});

  @override
  Widget build(BuildContext context) {
    late List words = [];
    return BlocBuilder<ReadWordCubit, ReadWordState>(
      builder: (context, state) {
        if(state is ReadWordInitial){
          
        }
        else if(state is ReadWordLoading){

        }
        else if(state is ReadWordSuccess){
          words = List.from(state.words);
        }
        else if(state is ReadWordFailed){
          _Failed_Method(state);
        }
        print(words);
        return Expanded(
          child: GridView.builder(
            itemCount: words.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => _wordItem(words[index]),
          ),
        );
      },
    );
  }

  Column _Failed_Method(ReadWordFailed state) {
    return Column(
          children: [
            Icon(Icons.report_problem_sharp, size: 30,),
            SizedBox(height: 10,),
            Text(
              state.errormsg,
              style: TextStyle(
                color: colorsdata.WhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        );
  }

  Widget _wordItem(WordModel word) => Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: colorsdata.RedColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        word.text,
        style: TextStyle(
          color: Color(word.colorcode),
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    ),
  );
  
}
