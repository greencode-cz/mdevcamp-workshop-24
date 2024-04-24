import MAUL
import SwiftUI

struct MainView: View {
  enum Tabs {
    case assignment1
    case showcase
  }

  @State var selectedTab: Tabs = .assignment1

  var body: some View {
    VStack(spacing: 0) {
      TabView(
        selection: $selectedTab,
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
          }.tag(Tabs.showcase)
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
