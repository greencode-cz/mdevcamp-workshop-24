import MAUL
import SwiftUI

#if os(iOS)

struct CustomSearchFieldScreen: View {
  @State private var searchFieldState: MAULSearchField.State = .default
  @State private var searchFieldState2: MAULSearchField.State = .default
  @State private var searchFieldState3: MAULSearchField.State = .default
  @State private var searchFieldState4: MAULSearchField.State = .default

  var body: some View {
    let view = VStack {
      MAULSearchField(
        state: $searchFieldState,
        placeholder: "Search anything...",
        withIcon: true,
        style: .solid
      )
      MAULSearchField(
        state: $searchFieldState2,
        placeholder: "Search anything...",
        withIcon: true,
        style: .shadow
      )
      MAULSearchField(
        state: $searchFieldState3,
        placeholder: "Search anything...",
        withIcon: false,
        style: .solid
      )
      MAULSearchField(
        state: $searchFieldState4,
        placeholder: "Search anything...",
        withIcon: false,
        style: .shadow
      )
    }
      .padding(.MAUL.S)
      .background(Color.MAUL.Background.primary)

    ScrollView {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct CustomSearchFieldScreen_Previews: PreviewProvider {
  static var previews: some View {
    CustomSearchFieldScreen()
      .setupMAULForPreviews()
  }
}

#endif
