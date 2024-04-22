import SwiftUI
import MAUL

struct RadioGroupPlayground: View {

  @State private var isFlagged: Bool = false
  @State private var disabled: Bool = false
  @State private var useNative: Bool = false

  @ViewBuilder func buildComponent() -> some View {
    Form {
      Toggle("Radio Button", isOn: $isFlagged)
        .disabled(disabled)
        .toggleStyle(.maulRadioButton())
    }
  }

  func builtText() -> String {
    var code = """
        Toggle("Radio Button", isOn: $isFlagged)
        \t.toggleStyle(.maulRadioButton())
        """

    if disabled {
      code.append("\n\t.disabled(true)")
    }
    return code    }

  var controls: some View {
    Group {
      Toggle("Disabled", isOn: $disabled)
        .toggleStyle(.maul())
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      RadioGroupScreen()
    }
    .navigationTitle("Radio Button")
  }
}

struct RadioGroupPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      RadioGroupPlayground()
    }
    .setupMAULForPreviews()
  }
}
