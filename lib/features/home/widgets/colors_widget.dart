
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/cubits/write%20cubit/cubit/write_word_cubit.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({super.key});

  final List colors = const [
    0xFFCE4AC9,
    0xff2ea043,
    0xfffbc117,
    0xffc3441d,
    0xff9cdcfe,
    0xFF28B5F6,
    0xFF14BAB2,
    0xFF9928F6,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WriteWordCubit, WriteWordState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder:
                (context, index) => _colorItem(
                  colors[index],
                  WriteWordCubit.get(context).colorcode,
                  context,
                ),
          ),
        );
      },
    );
  }

  Widget _colorItem(int color, int activecolor, context) => InkWell(
    onTap: () {
      WriteWordCubit.get(context).UpdateColorCode(color);
    },
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(color),
        shape: BoxShape.circle,
        border: _check_border(color, activecolor),
      ),
      child:
          color == activecolor
              ? Center(child: Icon(Icons.done, color: colorsdata.WhiteColor))
              : null,
    ),
  );

  Border? _check_border(int color, int activecolor) {
    return color == activecolor
        ? Border.all(width: 2, color: colorsdata.WhiteColor)
        : null;
  }
}
