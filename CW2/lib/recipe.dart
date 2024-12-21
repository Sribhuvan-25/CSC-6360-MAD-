class Recipe {
  final String name;
  final String ingredients;
  final String instructions;

  Recipe(this.name, this.ingredients, this.instructions);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Recipe &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          ingredients == other.ingredients &&
          instructions == other.instructions;

  @override
  int get hashCode =>
      name.hashCode ^ ingredients.hashCode ^ instructions.hashCode;
}
