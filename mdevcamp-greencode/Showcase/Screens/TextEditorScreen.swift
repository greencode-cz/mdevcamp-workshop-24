import SwiftUI
import MAUL

struct TextEditorScreen: View {
  @State private var fullText: String = "This is some editable text..."

  private let title: String = "Title"
  private let helperText: String = "Helper text"
  private let numberOfCharacters = 30

  var body: some View {
    let view = VStack {

      MAULTextEditor(
        text: $fullText,
        titleConfiguration: .init(
          title: title
        )
      )

      MAULTextEditor(
        state: .constant(.error),
        text: $fullText,
        titleConfiguration: .init(title: title, isFloating: false),
        footerConfiguration: .init(helperText: helperText)
      )

      MAULTextEditor(
        text: $fullText,
        titleConfiguration: .init(
          title: title
        ),
        footerConfiguration: .init(
          helperText: helperText,
          numberOfCharacters: numberOfCharacters
        )
      )
    }
      .padding(.MAUL.S)
      .background(Color.MAUL.Background.primary)

    ScrollView {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct TextEditorScreen_Previews: PreviewProvider {
  static var previews: some View {
    TextEditorScreen()
      .setupMAULForPreviews()
  }
}
