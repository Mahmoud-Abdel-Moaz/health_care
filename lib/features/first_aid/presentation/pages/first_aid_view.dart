import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/features/first_aid/presentation/widgets/first_aid_item_view.dart';

import '../../../../core/colors.dart';
import '../../../../core/compnents.dart';
import '../../domain/entities/first_aid.dart';
import '../bloc/first_aid_cubit.dart';

class FirstAidScreen extends StatelessWidget {
  const FirstAidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FirstAid>? firstAids;
    FirstAidCubit firstAidCubit = FirstAidCubit.get(context);
    firstAidCubit.getFirstAids();
    return Scaffold(
      backgroundColor: lotion,
      appBar:
          defaultAppBar(title: 'First Aids', context: context, withBack: true),
      body: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: BlocConsumer<FirstAidCubit, FirstAidState>(
              listener: (context, state) {
                if (state is LoadedFirstAidsState) {
                  firstAids = state.firstAids;
                }
              },
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: firstAids != null,
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(
                      color: defaultColor,
                    ),
                  ),
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) =>
                        FirstAidItemView(firstAid: firstAids![index]),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.h,
                    ),
                    itemCount: firstAids!.length,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
