import SwiftUI
import MAUL

struct DialogScreen: View {

  var body: some View {
    let title = "Title"
    let message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi egestas, eros ut efficitur bibendum, ipsum nunc lacinia urna, sit amet bibendum nisi diam at orci."
    let simpleDialog = MAULDialog(title: title, message: message, primaryButton: .init("Dismiss", action: {
    }))

    let dialog = MAULDialog(title: title, message: message, primaryButton: .init("Dismiss", action: {

    }), secondaryButton: .init("Confirm") {})

    let view = VStack {
      simpleDialog
      dialog
    }

    ScrollView {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct DialogScreen1_Previews: PreviewProvider {
  static var previews: some View {
    DialogScreen()
      .setupMAULForPreviews()
  }
}
