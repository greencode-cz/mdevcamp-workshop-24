import SwiftUI
import MAUL

struct SnackbarPlayground: View {

  let defaultMessage = "One line text string with one.\nTwo lines text string with two."
  let defaultActionLabel = "Action"

  @State var message = ""
  @State var actionLabel = ""
  @State var action = true

  @ViewBuilder func buildComponent() -> some View {
    if action {
      MAULSnackbar(message: (message.isEmpty ? defaultMessage : message), primaryButton: .init(actionLabel.isEmpty ? defaultActionLabel : actionLabel, action: {}))
        .padding()
    } else {
      MAULSnackbar(message: (message.isEmpty ? defaultMessage : message), primaryButton: nil)
        .padding()
    }
  }

  func buildCode() -> String {
    if action {
      return "MAULSnackbar(\"\(message.isEmpty ? defaultMessage : message)\", \"\(actionLabel.isEmpty ? defaultActionLabel : actionLabel)\") {}"
    } else {
      return "MAULSnackbar(\"\(message.isEmpty ? defaultMessage : message)\")"
    }
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      TextField(defaultMessage, text: $message)
      Toggle(defaultActionLabel, isOn: $action)
        .toggleStyle(.maul())
      if action {
        TextField(defaultActionLabel, text: $actionLabel)
      }
    }
    .textFieldStyle(.maul)
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      SnackBarScreen()
    }
    .navigationTitle("Snackbar")
  }
}

struct SnackbarPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SnackbarPlayground()
    }
    .setupMAULForPreviews()
  }
}
