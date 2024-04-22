import SwiftUI
import MAUL

struct CheckboxScreen: View {

  @State private var selectedScheme: ColorScheme = .light
  @State private var isFlagged: Bool = false
  @State private var isEnabled: Bool = true
  @State private var isIndeterminate: Bool = false

  var body: some View {

    let toggle = Toggle("Checkbox", isOn: $isFlagged)
      .toggleStyle(MAULCheckboxToggleStyle(isIndeterminate: false))
    let toggleDisabled = Toggle("Checkbox", isOn: $isFlagged).disabled(true)
      .toggleStyle(MAULCheckboxToggleStyle(isIndeterminate: false))
    let toggleIndeterminate = Toggle("Checkbox", isOn: $isFlagged)
      .toggleStyle(MAULCheckboxToggleStyle(isIndeterminate: true))
    let toggleIndeterminateDisabled = Toggle("Checkbox", isOn: $isFlagged)
      .disabled(true)
      .toggleStyle(MAULCheckboxToggleStyle(isIndeterminate: true))

    VStack {
      Form {
#if os(macOS)
        Toggle("Native Checkbox", isOn: $isFlagged)
          .toggleStyle(.checkbox)
        Toggle("Native Checkbox", isOn: $isFlagged)
          .disabled(true)
          .toggleStyle(.checkbox)
#endif
        toggle
        toggleDisabled
        toggleIndeterminate
        toggleIndeterminateDisabled
      }.environment(\.colorScheme, .light)
      Form {
#if os(macOS)
        Toggle("Native Checkbox", isOn: $isFlagged)
          .toggleStyle(.checkbox)
        Toggle("Native Checkbox", isOn: $isFlagged)
          .disabled(true)
          .toggleStyle(.checkbox)
#endif
        toggle
        toggleDisabled
        toggleIndeterminate
        toggleIndeterminateDisabled
      }.environment(\.colorScheme, .dark)
    }
  }
}

struct CheckboxScreen_Previews: PreviewProvider {
  static var previews: some View {
    CheckboxScreen()
      .setupMAULForPreviews()
  }
}
