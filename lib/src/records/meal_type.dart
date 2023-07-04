enum MealType {
  unknown,
  breakfast,
  lunch,
  dinner,
  snack;

  @override
  String toString() {
    switch (this) {
      case MealType.unknown:
        return 'unknown';
      case MealType.breakfast:
        return 'breakfast';
      case MealType.lunch:
        return 'lunch';
      case MealType.dinner:
        return 'dinner';
      case MealType.snack:
        return 'snack';
    }
  }
}
