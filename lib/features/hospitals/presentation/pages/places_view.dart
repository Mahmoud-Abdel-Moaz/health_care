import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/compnents.dart';
import 'package:health_care/features/hospitals/presentation/pages/locations_view.dart';
import 'package:health_care/features/hospitals/presentation/widgets/hospital_item_view.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/place.dart';
import '../bloc/place_cubit.dart';

class PlacesTypeScreen extends StatelessWidget {
  final String type, title;

  const PlacesTypeScreen({Key? key, required this.type, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Place>? places;
    PlaceCubit placeCubit = PlaceCubit.get(context);
    placeCubit.getPlaces(type);
    return Scaffold(
      backgroundColor: lotion,
      appBar: defaultAppBar(title: title, context: context, withBack: true),
      body: BlocConsumer<PlaceCubit,PlaceState>(
  listener: (context, state) {
    if(state is LoadedPlacesState){
      places=state.places;
    }
  },
  builder: (context, state) {
    return ConditionalBuilder(
          condition: places != null,
          fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),
          builder: (context) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      4.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: brightGray,
                          blurRadius: 6,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Center(
                    child: defaultButton(
                      onTap: () => navigateTo(
                          context,
                          LocationsScreen(
                              places: places!, type: type, title: title)),
                      text: 'Get Locations',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ListView.separated(
                  itemBuilder: (context, index) =>
                      HospitalItemView(place: places![index],type:type),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.h,
                  ),
                  itemCount: places!.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            );
          });
  },
),
    );
  }
}
