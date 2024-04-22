import SwiftUI
import MAUL

struct ToggleSwitchScreen: View {

  @State private var toggleSelected = false

  var body: some View {

    let view = VStack {
      Toggle("Enabled", isOn: $toggleSelected).toggleStyle(.maul())
      Toggle("Disabled", isOn: $toggleSelected).toggleStyle(.maul()).disabled(true)
    }
      .padding(.MAUL.S)
      .background(Color.MAUL.Background.primary)

    ScrollView {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct ToggleSwitchScreen_Previews: PreviewProvider {
  static var previews: some View {
    ToggleSwitchScreen()
      .setupMAULForPreviews()
  }
}
