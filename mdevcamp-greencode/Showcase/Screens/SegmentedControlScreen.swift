import SwiftUI
import MAUL

#if os(iOS)

struct SegmentedControlScreen: View {

  @State private var selectedTab: Tab = .tab1

  var body: some View {
    let view =
    MAULSegmentedControl(
      segments: Tab.allCases,
      selectedSegment: $selectedTab
    )
    .padding(.vertical, .MAUL.S)
    .background(Color.MAUL.Background.primary)

    ScrollView {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

private extension SegmentedControlScreen {
  enum Tab: String, MAULSegmentTitleProviding, Identifiable, Equatable, CaseIterable {

    case tab1
    case tab2
    case tab3

    var id: String {
      self.rawValue
    }

    var title: String {
      switch self {
      case .tab1:
        return "Tab1"
      case .tab2:
        return "Tab2"
      case .tab3:
        return "Tab3"
      }
    }
  }
}

struct SegmentedControl_Previews: PreviewProvider {
  static var previews: some View {
    SegmentedControlScreen()
      .setupMAULForPreviews()
  }
}

#endif
