import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/login_signup_feature/signup_form/first_form/cubit/first_form_cubit.dart';
import 'package:health_coach/theme/theme.dart';
import 'package:sizer/sizer.dart';

class SignupFirstFormScreen extends StatelessWidget {
  const SignupFirstFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirstFormCubit(),
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
                            child: AvatarSelect(),
                          ),
                          BlocProvider.value(
                            value: context.read<FirstFormCubit>(),
                            child: GallerySelect(),
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
                      child: FadeIn(child: AvatarSelectionDialog()));
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

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w, top: 2.h),
              child: Text(
                'We need to know about You!',
                style: themeData.textTheme.headlineMedium!
                    .copyWith(color: commonBlack),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  context.read<FirstFormCubit>().selectAvatarGalleryDialog();
                },
                child: Stack(
                  children: [
                    ImageSelector(),
                    Positioned(
                      left: 35.w,
                      top: 18.h,
                      child: _EditIconStack(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
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
          imagePath = state.imagePath;
          isGallery = state.isGallery;
        }
        return isGallery!
            ? Container(
                height: 23.h,
                width: 23.h,
                decoration: BoxDecoration(
                  border: Border.all(color: commonGreen, width: 3),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                height: 23.h,
                width: 23.h,
                decoration: BoxDecoration(
                    border: Border.all(color: commonGreen, width: 3),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(imagePath),
                        filterQuality: FilterQuality.high)),
              );
      },
    );
  }
}

class AvatarSelect extends StatelessWidget {
  const AvatarSelect({
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

class GallerySelect extends StatelessWidget {
  const GallerySelect({
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

class AvatarShow extends StatelessWidget {
  final String imagePath;

  const AvatarShow({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.5.h,
      width: 8.5.h,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(imagePath), filterQuality: FilterQuality.high)),
    );
  }
}

class _EditIconStack extends StatelessWidget {
  const _EditIconStack({
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
