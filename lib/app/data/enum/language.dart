enum Language { English, Vietnamese }

extension LanguageEx on Language {
  String get displayText {
    switch (this) {
      case Language.English:
        return "English";
      case Language.Vietnamese:
        return "Tiếng Việt";
    }
  }

  String get code {
    switch (this) {
      case Language.English:
        return "en";
      case Language.Vietnamese:
        return "vi";
    }
  }
}
