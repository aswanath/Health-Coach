part of 'coach_learner_cubit.dart';

@immutable
abstract class CoachLearnerState {}

class CoachLearnerInitial extends CoachLearnerState {
  final Color containerColor;
  final Color textColor;
  CoachLearnerInitial({required this.textColor,required this.containerColor});
}

class CoachSelectedState extends CoachLearnerState{}

class LearnerSelectedState extends CoachLearnerState{}

class NotSelectedState extends CoachLearnerState{}

