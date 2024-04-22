import SwiftUI
import MAUL

struct TextFieldScreen: View {
  @State private var error = ""
  @State private var text = "Text"
  @FocusState private var focused

  private let title = "Title"

  var body: some View {
    // TODO: solve behaviour when it is in form instead of list
    // MacOS in list has native textfield background ok when it is not focused. It is not ok when in anything else
    let view = VStack {
      Group {
        TextField("Title", text: $text)
          .withMAULStyle

        MAULTextField(
          state: .constant(.active),
          text: $text,
          titleConfiguration: .init(title: "Title")
        )

        MAULTextField(
          state: .constant(.active),
          text: $text,
          titleConfiguration: .init(title: "Title", isFloating: false)
        )

        MAULTextField(
          state: .constant(.active),
          text: $text,
          titleConfiguration: .init(title: "Title"),
          icon: Image.MAUL.heart
        )

        MAULTextField(
          state: .constant(.active),
          text: $text,
          titleConfiguration: .init(title: "Title"),
          footerConfiguration: .init(helperText: "Helper text")
        )

        MAULTextField(
          state: .constant(.active),
          text: $text,
          titleConfiguration: .init(title: "Title"),
          action: .init(icon: Image.MAUL.camera, action: {})
        )

        MAULTextField(
          state: .constant(.active),
          text: $text,
          titleConfiguration: .init(title: "Title"),
          footerConfiguration: .init(numberOfCharacters: 10)
        )

        MAULTextField(
          state: .constant(.active),
          text: $text,
          titleConfiguration: .init(title: "Title"),
          icon: Image.MAUL.heart,
          action: .init(icon: Image.MAUL.camera, action: {}),
          footerConfiguration: .init(helperText: "Helper text", numberOfCharacters: 20)
        )

        MAULTextField(
          state: .constant(.default),
          text: .constant(""),
          titleConfiguration: .init(title: "Title"),
          icon: Image.MAUL.heart,
          action: .init(icon: Image.MAUL.camera, action: {}),
          footerConfiguration: .init(helperText: "Helper text", numberOfCharacters: 20)
        )

        MAULTextField(
          state: .constant(.focused),
          text: $text,
          titleConfiguration: .init(title: "Title"),
          icon: Image.MAUL.heart,
          action: .init(icon: Image.MAUL.camera, action: {}),
          footerConfiguration: .init(helperText: "Helper text", numberOfCharacters: 20)
        )
      }
      MAULTextField(
        state: .constant(.error),
        text: $text,
        titleConfiguration: .init(title: "Title"),
        icon: Image.MAUL.heart,
        action: .init(icon: Image.MAUL.camera, action: {}),
        footerConfiguration: .init(helperText: "Helper text", numberOfCharacters: 20)
      )
    }
      .padding(.MAUL.S)
      .background(Color.MAUL.Background.primary)
    
    ScrollView {
      view
        .environment(\.colorScheme, .light)

      view
        .environment(\.colorScheme, .dark)
    }
  }
}

struct TextFieldScreen_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldScreen()
      .setupMAULForPreviews()
  }
}
