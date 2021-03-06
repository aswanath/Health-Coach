import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/form_field.dart';
import 'package:health_coach/custom_widgets/nextButton.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/login_signup_feature/bloc/login_signup_bloc.dart';
import 'package:health_coach/login_signup_feature/signup_form/coach_form/view/coach_form_screen.dart';
import 'package:health_coach/login_signup_feature/signup_form/cubit/first_form_cubit.dart';
import 'package:health_coach/login_signup_feature/signup_form/learner_form/view/learner_form_screen.dart';
import 'package:health_coach/repository/repository.dart';
import 'package:health_coach/theme/theme.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:health_coach/custom_classes/validator_mixin.dart';

class SignupFirstFormScreen extends StatelessWidget {
  const SignupFirstFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FirstFormCubit>(
          create: (context) => FirstFormCubit(),
        ),
        BlocProvider<LoginSignupBloc>(
          create: (context) => LoginSignupBloc(repository: context.read<Repository>()),
        ),
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
          if (state is NavigateToCoachFormScreen) {
            Navigator.push(
                context,
                PageTransition(
                    child: BlocProvider.value(
                      value: context.read<FirstFormCubit>(),
                      child: const CoachFormScreen(),
                    ),
                    type: PageTransitionType.fade));
            return;
          }
          if (state is NavigateToLearnerFormScreen) {
            Navigator.push(
                context,
                PageTransition(
                    child: MultiBlocProvider(providers: [
                      BlocProvider.value(value: context.read<FirstFormCubit>()),
                      BlocProvider.value(
                          value: context.read<LoginSignupBloc>()),
                    ], child: LearnerFormScreen()),
                    type: PageTransitionType.fade));
            return;
          }
        },
        child: _Scaffold(),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget with InputValidatorMixin {
  _Scaffold({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: ListView(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              'We need to know about You!',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: commonBlack),
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  context.read<FirstFormCubit>().selectAvatarGalleryDialog();
                },
                child: ImageSelector(),
              ),
            ),
            Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    onSaved: (val) {
                      context
                          .read<LoginSignupBloc>()
                          .add(FirstFormEvent(name: val));
                      return null;
                    },
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
                    onSaved: (val) {
                      context.read<LoginSignupBloc>().add(
                            FirstFormEvent(userName: val),
                          );
                      return null;
                    },
                    head: 'Username',
                    hintText: 'john123',
                    icon: const Iconify(
                      CustomIcons.nameIcon,
                      color: commonGreen,
                    ),
                    delay: 200,
                    validator: (val) {
                      context.read<FirstFormCubit>().checkUserName(val);
                      return isUserNameValid(val);
                    },
                  ),
                  CustomTextField(
                    onSaved: (val) {
                      context
                          .read<LoginSignupBloc>()
                          .add(FirstFormEvent(email: val));
                      return null;
                    },
                    delay: 300,
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
                    onSaved: (val) {
                      context
                          .read<LoginSignupBloc>()
                          .add(FirstFormEvent(phone: int.parse(val!)));
                      return null;
                    },
                    delay: 400,
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
                    onSaved: (val) {
                      context
                          .read<LoginSignupBloc>()
                          .add(FirstFormEvent(password: val));
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    delay: 500,
                    obscureText: true,
                    validator: (val) {
                      context.read<FirstFormCubit>().checkPassword(val);
                      return isPasswordValid(val);
                    },
                    head: 'Password',
                    hintText: 'John@123',
                    icon: const Iconify(
                      CustomIcons.passwordIcon,
                      color: commonGreen,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ZoomIn(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                    splashRadius: 0.01,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 1.w),
                  child: ZoomIn(
                      child: _NextIconButton(
                    formKey: _formKey,
                  )),
                )
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}

class _NextIconButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  _NextIconButton({
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstFormCubit, FirstFormState>(
      buildWhen: ((previous, current) {
        if (current is EnableNextButton || current is DisableNextButton) {
          return true;
        }
        return false;
      }),
      builder: (context, state) {
        Color containerColor = commonWhite;
        Color iconColor = commonGreen;
        double scale = .9;
        if (state is EnableNextButton) {
          containerColor = commonGreen;
          iconColor = commonWhite;
          scale = 1.1;
        } else if (state is DisableNextButton) {
          containerColor = commonWhite;
          iconColor = commonGreen;
          scale = .9;
        }
        return CustomNextButton(
            scale: scale,
            iconColor: iconColor,
            containerColor: containerColor,
            onPressed: () {
              if (state is EnableNextButton) {
                formKey.currentState!.save();
                context.read<FirstFormCubit>().navigateToNext();
              } else {
                formKey.currentState!.validate();
              }
            });
      },
    );
  }
}

class ImageSelector extends StatelessWidget {
  ImageSelector({
    Key? key,
  }) : super(key: key);
  String imagePath = '';
  bool? isGallery;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstFormCubit, FirstFormState>(
      builder: (context, state) {
        if (state is ImageInitialState) {
          imagePath = state.imagePath;
          isGallery = false;
        } else if (state is ImageUpdateState) {
          context.read<LoginSignupBloc>().add(FirstFormEvent(imagePath: state.imagePath,isGallery: state.isGallery));
          imagePath = state.imagePath;
          isGallery = state.isGallery;
        }
        return Hero(
          tag: 'edit',
          child: Stack(
            children: [
              isGallery!
                  ? Container(
                      height: 20.h,
                      width: 20.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: commonGreen, width: 3),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.file(
                          File(imagePath),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    )
                  : Container(
                      height: 20.h,
                      width: 20.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: commonGreen, width: 3),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(imagePath),
                              filterQuality: FilterQuality.high)),
                    ),
              Positioned(
                left: 31.w,
                top: 15.h,
                child: const EditIconStack(),
              )
            ],
          ),
        );
      },
    );
  }
}

///3 - avatar,avatar dialog, gallery
class AvatarOption extends StatelessWidget {
  const AvatarOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FirstFormCubit>().selectAvatar();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icons/avatar_icon.png',
            width: 10.w,
          ),
          Text(
            'Avatar',
            style: themeData.textTheme.headlineSmall!
                .copyWith(fontSize: 16.sp, color: commonBlack),
          )
        ],
      ),
    );
  }
}

class AvatarSelectionDialog extends StatelessWidget {
  const AvatarSelectionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SizedBox(
        height: 26.5.h,
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Select one avatar',
              style: themeData.textTheme.headlineSmall,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  4,
                  (index) => GestureDetector(
                      onTap: () {
                        context.read<FirstFormCubit>().updateAvatar(index);
                      },
                      child: AvatarShow(imagePath: avatarList[index]))),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  4,
                  (index) => GestureDetector(
                      onTap: () {
                        context.read<FirstFormCubit>().updateAvatar(index + 4);
                      },
                      child: AvatarShow(imagePath: avatarList[index + 4]))),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryOption extends StatelessWidget {
  const GalleryOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FirstFormCubit>().selectGallery();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icons/gallery_icon.png',
            width: 10.w,
          ),
          Text(
            'Gallery',
            style: themeData.textTheme.headlineSmall!
                .copyWith(fontSize: 16.sp, color: commonBlack),
          )
        ],
      ),
    );
  }
}

///2 - avatar widget,edit icon widget
class AvatarShow extends StatelessWidget {
  final String imagePath;

  const AvatarShow({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 8.h,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(imagePath), filterQuality: FilterQuality.high)),
    );
  }
}

class EditIconStack extends StatelessWidget {
  const EditIconStack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 4.h,
          width: 4.h,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: commonGreen),
        ),
        Icon(
          Icons.edit,
          color: commonWhite,
          size: 17.sp,
        )
      ],
    );
  }
}
