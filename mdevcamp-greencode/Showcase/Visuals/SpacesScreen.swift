import SwiftUI
import MAUL

enum Space: String, CaseIterable {
  case XXXS
  case XXS
  case XS
  case S
  case M
  case L
  case XL
  case XXL
  case XXXL

  var name: String {
    return "Spacer \(self.rawValue)"
  }

  @ViewBuilder
  var spacer: some View {
    switch self {
    case .XXXS:
      Spacer.MAUL.XXXS()
    case .XXS:
      Spacer.MAUL.XXS()
    case .XS:
      Spacer.MAUL.XS()
    case .S:
      Spacer.MAUL.S()
    case .M:
      Spacer.MAUL.M()
    case .L:
      Spacer.MAUL.L()
    case .XL:
      Spacer.MAUL.XL()
    case .XXL:
      Spacer.MAUL.XXL()
    case .XXXL:
      Spacer.MAUL.XXXL()
    }
  }
}

struct SpacesScreen: View {

  var body: some View {
    List(Space.allCases, id: \.self) { space in
      SpaceRow(space: space)
    }
    .navigationTitle("Spaces")
    .listStyle(.plain)
  }

  struct SpaceRow: View {
    var space: Space

    var body: some View {
      VStack {
        Text(space.name)
        ZStack {
          space.spacer
        }
        .frame(maxWidth: .infinity)
        .background(Color.MAUL.Text.primary)
      }
#if os(iOS)
      .listRowSeparator(.hidden)
#endif
    }
  }
}

struct SpacerScreen_Previews: PreviewProvider {
  static var previews: some View {
    SpacesScreen()
      .setupMAULForPreviews()
  }
}
