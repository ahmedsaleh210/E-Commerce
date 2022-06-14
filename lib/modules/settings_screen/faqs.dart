import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/faqs_model.dart';

class FaqsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
      listener: (context,state) {},
      builder: (context,state) => Scaffold(
        appBar: AppBar(
          title: Text('Help Center'),
        ),
        backgroundColor: Colors.white,
        body: BuildCondition(
          condition: HomeCubit.get(context).faqsModel?.data != null,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) => Column(
                children: [
                  buildFaqs(HomeCubit.get(context).faqsModel!.data!.data![index]),
                ],
              ) ,
              separatorBuilder: (context,index) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 3,
                  color: Colors.grey[300],
                  width: double.infinity,
                ),
              ),
              itemCount:HomeCubit.get(context).faqsModel!.data!.data!.length ),
          fallback: (context) => Center(child: RefreshProgressIndicator()),
        ),
      ),
    );
  }

  Widget buildFaqs(FaqsDataData? model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model!.question}:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Text(
                      '${model.answer}',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
