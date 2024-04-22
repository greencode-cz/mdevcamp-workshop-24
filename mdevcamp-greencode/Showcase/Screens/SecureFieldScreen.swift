import MAUL
import SwiftUI

struct SecureFieldScreen: View {
  @State private var password: String = ""
  @State private var helperText = "Helper text"

  var body: some View {
    let view = VStack {
      SecureField("Type your password", text: .constant("password"))
        .withMAULStyle

      MAULSecureField(
        state: .constant(.default),
        text: .constant("password"),
        titleConfiguration: .init(title: "Password"),
        icon: Image.MAUL.heart,
        action: .init(icon: Image.MAUL.hide, action: {}),
        footerConfiguration: .init(helperText: "Type your password", numberOfCharacters: 10)
      )

      MAULSecureField(
        state: .constant(.active),
        text: .constant("password"),
        titleConfiguration: .init(title: "Password"),
        icon: Image.MAUL.heart,
        action: .init(icon: Image.MAUL.hide, action: {}),
        footerConfiguration: .init(helperText: "Type your password")
      )

      MAULSecureField(
        state: .constant(.error),
        text: .constant("password"),
        titleConfiguration: .init(title: "Password"),
        icon: Image.MAUL.heart,
        action: .init(icon: Image.MAUL.hide, action: {}),
        footerConfiguration: .init(helperText: "Type your password")
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

struct SecureFieldScreen_Previews: PreviewProvider {
  static var previews: some View {
    SecureFieldScreen()
      .setupMAULForPreviews()
  }
}
