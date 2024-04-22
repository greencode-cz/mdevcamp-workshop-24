import MAUL
import SwiftUI

struct MainView: View {
  enum Tabs {
    case assignment1
    case assignment2
    case assignment3
  }

  var body: some View {
    VStack(spacing: 0) {
      TabView(
        selection: .constant(1),
        content:  {
          Assignment().tabItem {
            Text("Assignment")
              .maulFontStyle(.body1)
              .foregroundColor(.MAUL.Text.primary)
          }.tag(Tabs.assignment1)

          Showcase().tabItem {
            Text("Showcase")
              .maulFontStyle(.body1)
              .foregroundColor(.MAUL.Text.primary)
          }.tag(Tabs.assignment2)
        }
      )
      .withMAULStyle
    }
    .background(Color.MAUL.Background.primary)
  }
}

#Preview {
  MainView()
    .setupMAULForPreviews()
}
