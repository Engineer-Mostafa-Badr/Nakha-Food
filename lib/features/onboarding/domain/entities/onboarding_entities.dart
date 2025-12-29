import 'package:equatable/equatable.dart';

class OnboardingEntities extends Equatable {
  final String imagePath;
  final String firstTitle;
  final String description;

  const OnboardingEntities({
    required this.imagePath,
    required this.firstTitle,
    required this.description,
  });

  @override
  List<Object?> get props => [imagePath, firstTitle, description];
}
