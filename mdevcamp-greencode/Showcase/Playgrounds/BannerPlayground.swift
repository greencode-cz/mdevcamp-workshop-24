import SwiftUI
import MAUL

enum Illustration: String, CaseIterable {

  case empty
  case icon
  case progressIndeterminate
  case progressDeterminate

  var codeString: String? {
    switch self {
    case .icon:
      return ".icon(Image.MAUL.circleInformationFill)"
    case .progressIndeterminate:
      return ".progress()"
    case .progressDeterminate:
      return ".progress(value: 100, total: 100)"
    default:
      return nil
    }
  }

  var bannerIllustation: MAULBanner.Illustration? {
    switch self {
    case .icon:
      return .icon(Image.MAUL.circleInformationFill)
    case .progressIndeterminate:
      return .progress()
    case .progressDeterminate:
      return .progress(value: 100, total: 100)
    case .empty:
      return nil
    }
  }
}

struct BannerPlayground: View {

  let defaultMessage = "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua."
  let primaryButtonTitle = "First"
  let secondaryyButtonTitle = "Second"

  @State var icon: Image = Image.MAUL.circleInformationFill
  @State var message: String = ""
  @State var actionLabel: String = ""
  @State var showSecondActionLabel: Bool = false
  @State var secondActionLabel: String = ""
  @State var illustration: Illustration = .empty

  @ViewBuilder func buildComponent() -> some View {
    let primaryButtonCongig = MAULButtonConfig(
      actionLabel.isEmpty ? primaryButtonTitle : actionLabel
    ) { print("tap \(actionLabel)") }

    let secondaryButtonCongig = MAULButtonConfig(
      secondActionLabel.isEmpty ? secondaryyButtonTitle : secondActionLabel
    ) { print("tap \(secondActionLabel)") }

    if let content =  illustration.bannerIllustation {
      MAULBanner(
        message: message.isEmpty ? defaultMessage : message,
        primaryButton: primaryButtonCongig,
        secondaryButton: showSecondActionLabel ? secondaryButtonCongig : nil,
        illustration: content
      )
    } else {
      MAULBanner(
        message: message.isEmpty ? defaultMessage : message,
        primaryButton: primaryButtonCongig,
        secondaryButton: showSecondActionLabel ? secondaryButtonCongig : nil
      )
    }
  }

  func buildCode() -> String {
    var code =
        """
        MAULBanner(
            message: "\(message.isEmpty ? defaultMessage : message)",
            primaryButton: .init("\(actionLabel.isEmpty ? primaryButtonTitle : actionLabel)") {}
        """
    if showSecondActionLabel {
      code += """
            ,\n    secondaryButton: .init("\(secondActionLabel.isEmpty ? secondaryyButtonTitle : secondActionLabel)") {}
            """
    }

    if let illustrationCode = illustration.codeString {
      code += ",\n    illustration: \(illustrationCode)"
    }

    code += "\n)"

    return code
  }
  
  var controls: some View {
    VStack(spacing: .MAUL.S) {
      TextField(defaultMessage, text: $message)
      TextField(primaryButtonTitle, text: $actionLabel)
      Toggle("show second label",
             isOn: $showSecondActionLabel)
      .toggleStyle(.maul())
      TextField(secondaryyButtonTitle, text: $secondActionLabel)

      HStack {
        Text("Illustation")
        Spacer()
        Picker("", selection: $illustration) {
          ForEach(Illustration.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }
      .toggleStyle(.maul())
    }
    .textFieldStyle(.maul)
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      BannerScreen()
    }
    .navigationTitle("Banner")
  }
}

struct BannerPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BannerPlayground()
    }
    .setupMAULForPreviews()
  }
}
