import SwiftUI
import MAUL

struct CheckboxPlayground: View {

  @State private var isFlagged: Bool = false
  @State private var disabled: Bool = false
  @State private var useNative: Bool = false
  @State private var isIndeterminate: Bool = false

  @ViewBuilder func buildComponent() -> some View {
    Form {
      let toggle = Toggle("Checkbox", isOn: $isFlagged)
        .disabled(disabled)
#if os(macOS)
      if useNative {
        toggle.toggleStyle(.checkbox)
      } else {
        toggle.toggleStyle(MAULCheckboxToggleStyle(isIndeterminate: isIndeterminate))
      }
#else
      toggle.toggleStyle(MAULCheckboxToggleStyle(isIndeterminate: isIndeterminate))
#endif
    }
  }

  func builtText() -> String {
    var code = """
        Toggle("Checkbox", isOn: $isFlagged)
        """

    if useNative {
      code.append("\n\t.toggleStyle(.checkbox)")
    } else {
      code.append("\n\t.toggleStyle(\(isIndeterminate ? ".maulCheckbox(isIndeterminate: true)" : ".maulCheckbox()"))")
    }

    if disabled {
      code.append("\n\t.disabled(true)")
    }
    return code    }

  var controls: some View {
    Group {
      Toggle("Disabled", isOn: $disabled)
        .toggleStyle(.maul())
      if !useNative {
        Toggle("Indeterminate", isOn: $isIndeterminate)
          .toggleStyle(.maul())
      }
#if os(macOS)
      Toggle("Native", isOn: $useNative)
        .toggleStyle(.maul())
#endif
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      CheckboxScreen()
    }
    .navigationTitle("Checkbox")
  }
}

struct CheckboxPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CheckboxPlayground()
    }
    .setupMAULForPreviews()
  }
}
