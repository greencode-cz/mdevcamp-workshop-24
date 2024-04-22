import SwiftUI
import MAUL

#if os(iOS)

extension MAULSearchField.Style: CaseIterable {
  public static var allCases: [MAULSearchField.Style] = [.solid, .shadow]

  var name: String {
    switch self {
    case .solid:
      return "solid"
    case .shadow:
      return "shadow"
    }
  }
}

struct SearchFieldPlayground: View {
  private let defaultPlaceholder = "Search anything..."
  @State private var placeholder = ""
  @State private var searchIcon = true
  @State private var searchFieldState: MAULSearchField.State = .default
  @State private var style: MAULSearchField.Style = .solid
  //Added due to xcode bug with update component when show icon toggle change
  @State var viewID: Bool = true

  @ViewBuilder func buildComponent() -> some View {
    MAULSearchField(
      state: $searchFieldState,
      placeholder: placeholder.isEmpty ? defaultPlaceholder : placeholder,
      withIcon: searchIcon,
      style: style
    )
    .id(viewID)
    .onChange(of: searchIcon, perform: { value in
      viewID.toggle()
    })
  }

  func buildCode() -> String {
    let code = """
        MAULSearchField(
            state: $searchFieldState,
            placeholder: "\(placeholder.isEmpty ? defaultPlaceholder : placeholder)",
            withSearchIcon: \(searchIcon ? "true" : "false"),
            style: .\(style.name)
        )
        """
    return code
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      Group {
        TextField(defaultPlaceholder, text: $placeholder)
          .textFieldStyle(.maul)

        Toggle("Show icon", isOn: $searchIcon)
          .toggleStyle(.maul())

        HStack {
          Text("Style")
          Spacer()
          Picker("Style", selection: $style) {
            ForEach(MAULSearchField.Style.allCases, id: \.self) {
              Text($0.name)
            }
          }
        }
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      CustomSearchFieldScreen()
    }
    .navigationTitle("SearchField")
  }
}

struct SearchFieldPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchFieldPlayground()
    }
    .setupMAULForPreviews()
  }
}

#endif
