import SwiftUI
import MAUL

struct SnackBarScreen: View {
  var body: some View {
    let view = ScrollView {
      MAULSnackbar(
        message: "One line text string with one.",
        primaryButton: nil
      )
      MAULSnackbar(
        message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eui mod tristique auctor. Maecenas sollicitudin, lectus at ullamcorper auctor.",
        primaryButton: nil
      )
      MAULSnackbar(
        message: "One line text string with one.\nTwo lines text string with two.",
        primaryButton: .init("Action", action: {})
      )
    }
      .padding(.MAUL.S)
      .background(Color.MAUL.Background.primary)

    view.environment(\.colorScheme, .light)
    view.environment(\.colorScheme, .dark)
  }
}

struct SnackBarScreen_Previews: PreviewProvider {
  static var previews: some View {
    SnackBarScreen()
      .setupMAULForPreviews()
  }
}
