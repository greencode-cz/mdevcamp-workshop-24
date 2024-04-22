import SwiftUI
import MAUL

struct ToggleSwitchPlayground: View {

  @State private var selected = false
  @State private var disabled: Bool = false

  @ViewBuilder private func buildToggleSwitch() -> some View {
    Form {
      Toggle("Selected", isOn: $selected)
        .toggleStyle(.maul())
        .disabled(disabled)
    }
  }

  private func builtText() -> String {
    var code = """
        Toggle("switch", isOn: $selected )
        \t.toggleStyle(.maul())
        """
    if disabled {
      code.append("\n\t.disabled(true)")
    }
    return code
  }

  private var controls: some View {
    Group {
      Toggle("Selected", isOn: $selected)
        .toggleStyle(.maul())

      Toggle("Disabled", isOn: $disabled)
        .toggleStyle(.maul())
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildToggleSwitch()
    } modalScreen: {
      ToggleSwitchScreen()
    }
    .navigationTitle("Toggle Switch")
  }
}

struct ToggleSwitchPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ToggleSwitchPlayground()
    }
    .setupMAULForPreviews()
  }
}
