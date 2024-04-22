import SwiftUI
import MAUL

struct StatusPlayground: View {

  @State var status: MAULStatus = .positive
  @State var disabled: Bool = false

  @ViewBuilder func buildComponent() -> some View {
    status.icon(disabled: disabled)
  }

  func buildCode() -> String {
    let disabledCode = disabled ? "(disabled: true)" : ""
    return """
        MAULStatus.\(status.rawValue).icon\(disabledCode)
        """
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {

      HStack {
        Text("Status")
        Spacer()
        Picker("", selection: $status) {
          ForEach(MAULStatus.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }

      Toggle("Disabled", isOn: $disabled).toggleStyle(.maul())

    }
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      StatusScreen()
    }
    .navigationTitle("Status")
  }
}

struct StatusPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StatusPlayground()
    }
    .setupMAULForPreviews()
  }
}
