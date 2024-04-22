import SwiftUI
import MAUL

struct RadioGroupScreen: View {

  @State var isOff: Bool = false
  @State var isOn: Bool = true

  var body: some View {
    VStack {
      Toggle("Radio Button", isOn: $isOff)
        .toggleStyle(.maulRadioButton())
      Toggle("Radio Button", isOn: $isOn)
        .toggleStyle(.maulRadioButton())
      Toggle("Radio Button", isOn: $isOff)
        .toggleStyle(.maulRadioButton())
        .disabled(true)
      Toggle("Radio Button", isOn: $isOn)
        .toggleStyle(.maulRadioButton())
        .disabled(true)
    }
  }
}

struct RadioGroupScreen_Previews: PreviewProvider {
  static var previews: some View {
    RadioGroupScreen()
      .setupMAULForPreviews()
  }
}
