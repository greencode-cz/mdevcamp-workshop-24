import SwiftUI
import MAUL

struct DialogPlayground: View {

  let defaultMessage = "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua."
  let defaultTitle = "Title"
  let defaulPrimaryTitle = "Dismiss"
  let defaulSecondaryTitle = "Confirm"

  @State var title: String = ""
  @State var message: String = ""
  @State var primaryTitle = ""
  @State var secondaryTitle = ""
  @State var showSec = false
  @State var showLive = false
  @State var showDialog = false

  var dialog: MAULDialog {
    MAULDialog(
      title: title.isEmpty ? defaultTitle : title,
      message: message.isEmpty ? defaultMessage : message,
      primaryButton: .init(primaryTitle.isEmpty ? defaulPrimaryTitle : primaryTitle) { showDialog = false },
      secondaryButton: showSec
      ? .init(secondaryTitle.isEmpty ? defaulSecondaryTitle : secondaryTitle) { showDialog = false }
      : nil
    )
  }

  @ViewBuilder func buildComponent() -> some View {
    if showLive {
      Button("Show dialog") {
        showDialog = true
      }
    } else {
      dialog
    }
  }

  func buildCode() -> String {
    let primary = "primaryButton: .init(\"\(primaryTitle.isEmpty ? defaulPrimaryTitle : primaryTitle)\") { //primary button action \n}"

    return showLive
    ? """
        SomeView {
            //content of some view
        }
        .maulDialog(
            isPresented: $showDialog,
            content: MAULDialog( ... )
        )
        """
    : [
        """
        MAULDialog(
            title: "\(title.isEmpty ? defaultTitle : title)",
            message: "\(message.isEmpty ? defaultMessage : message)",
        """,
        showSec
        ? """
            \(primary),
            secondaryButton: .init("\(secondaryTitle.isEmpty ? defaulSecondaryTitle : secondaryTitle)") { //secondary button action
            }
        )
        """
        : "    "+primary+")"
    ]
      .compactMap { $0 }
      .joined(separator: "\n")
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      TextField(defaultTitle, text: $title)
      TextField(defaultMessage, text: $message)
      TextField(defaulPrimaryTitle, text: $primaryTitle)

      Toggle(defaulSecondaryTitle, isOn: $showSec)

      if showSec {
        TextField(defaulSecondaryTitle, text: $secondaryTitle)
      }

      Divider().withMAULStyle

      Text("Live control - on button click dialog is shown as popup. To apply color scheme changes, change scheme in mobile settings")

      Toggle("Live", isOn: $showLive)
    }
    .textFieldStyle(.maul)
    .toggleStyle(.maul())
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      DialogScreen()
    }
    .navigationTitle("Dialog")
    .maulDialog(isPresented: $showDialog, content: dialog)
  }
}

struct DialogPlayground1_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      DialogPlayground()
    }
    .setupMAULForPreviews()
  }
}
