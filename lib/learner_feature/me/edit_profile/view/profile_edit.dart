import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_classes/validator_mixin.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/custom_widgets/form_field.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/login_signup_feature/bloc/login_signup_bloc.dart';
import 'package:health_coach/login_signup_feature/signup_form/cubit/first_form_cubit.dart';
import 'package:health_coach/login_signup_feature/signup_form/first_form/view/first_form_screen.dart';
import 'package:health_coach/repository/repository.dart';
import 'package:hidable/hidable.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FirstFormCubit>(create: (context)=> FirstFormCubit()),
        BlocProvider<LoginSignupBloc>(create: (context)=> LoginSignupBloc(repository: context.read<Repository>())),
      ],
      child: BlocListener<FirstFormCubit, FirstFormState>(
        listener: (context, state) {
          if (state is ShowAvatarGalleryPopup) {
            showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    child: SizedBox(
                      height: 11.h,
                      width: 50.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BlocProvider.value(
                            value: context.read<FirstFormCubit>(),
                            child: const AvatarOption(),
                          ),
                          BlocProvider.value(
                            value: context.read<FirstFormCubit>(),
                            child: const GalleryOption(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
            return;
          }
          if (state is ShowSelectAvatarPopup) {
            showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                      value: context.read<FirstFormCubit>(),
                      child: FadeIn(child: const AvatarSelectionDialog()));
                });
            return;
          }
          if (state is ImageUpdateState) {
            if (state.isGallery) {
              Navigator.pop(context);
              return;
            }
            Navigator.pop(context);
            Navigator.pop(context);
            return;
          }
        },
        child: _Scaffold(),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget with InputValidatorMixin{
  _Scaffold({
    Key? key,
  }) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(100.w, 7.h),
            child: Hidable(
              controller: _scrollController,
              child: AppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w, vertical: 1.h),
                    child: CustomElevatedButton(
                      voidCallback: () {},
                      text: 'Save',
                      backgroundColor: Colors.transparent,
                      foregroundColor: commonGreen,
                      borderColor: commonGreen,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            controller: _scrollController,
            children: [
              Align(
                child: GestureDetector(
                  onTap: () {
                    context.read<FirstFormCubit>().selectAvatarGalleryDialog();
                  },
                  child: Stack(
                    children: [
                      ImageSelector(),
                      Positioned(
                        left: 31.w,
                        top: 15.h,
                        child: const EditIconStack(),
                      )
                    ],
                  ),
                ),
              ),
              Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      head: 'Name',
                      hintText: 'John',
                      icon: const Iconify(
                        CustomIcons.nameIcon,
                        color: commonGreen,
                      ),
                      delay: 100,
                      validator: (val) {
                        context.read<FirstFormCubit>().checkName(val);
                        return isNameValid(val);
                      },
                    ),
                    CustomTextField(
                      delay: 200,
                      validator: (val) {
                        context.read<FirstFormCubit>().checkEmail(val);
                        return isEmailValid(val);
                      },
                      head: 'Email',
                      hintText: 'john123@gmail.com',
                      icon: const Iconify(
                        CustomIcons.emailIcon,
                        color: commonGreen,
                      ),
                    ),
                    CustomTextField(
                      delay: 300,
                      validator: (val) {
                        context.read<FirstFormCubit>().checkMobile(val);
                        return isMobileValid(val);
                      },
                      head: 'Mobile',
                      hintText: '9876543210',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      icon: const Iconify(
                        CustomIcons.mobileIcon,
                        color: commonGreen,
                      ),
                      textInputType: TextInputType.number,
                    ),
                    CustomTextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputType: TextInputType.number,
                      validator: (val) {
                        context.read<FirstFormCubit>().checkAge(val);
                        return isAgeValid(val);
                      },
                      delay: 400,
                      head: 'Age',
                      hintText: '24',
                      icon: const Iconify(
                        CustomIcons.ageIcon,
                        color: commonGreen,
                      ),
                    ),
                    CustomTextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputType: TextInputType.number,
                      validator: (val) {
                        context.read<FirstFormCubit>().checkHeight(val);
                        return isHeightValid(val);
                      },
                      delay: 500,
                      head: 'Height',
                      hintText: '172 cm',
                      icon: const Iconify(
                        CustomIcons.heightIcon,
                        color: commonGreen,
                      ),
                    ),
                    CustomTextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputType: TextInputType.number,
                      validator: (val) {
                        context.read<FirstFormCubit>().checkWeight(val);
                        return isWeightValid(val);
                      },
                      delay: 600,
                      head: 'Weight',
                      hintText: '68 kg',
                      icon: const Iconify(
                        CustomIcons.weightIcon,
                        color: commonGreen,
                      ),
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.done,
                      height: 19.94.h,
                      validator: (val) {
                        return null;
                      },
                      delay: 700,
                      head: 'Health Condition',
                      hintText: 'low sugar , no health issues, etc.',
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h,)
            ],
          ),
        ));
  }
}
