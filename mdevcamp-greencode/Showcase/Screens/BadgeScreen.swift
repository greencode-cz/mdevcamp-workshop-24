import SwiftUI
import MAUL

struct BadgeScreen: View {

  private var min = 0
  private var middle = 50
  private var max = 100

  var body: some View {
    let badges = {
      VStack(alignment: .leading) {
        HStack {
          MAULStatusBadge(value: min, scheme: .info)
          MAULStatusBadge(value: min, scheme: .warning)
          MAULStatusBadge(value: min, scheme: .alert)
          MAULStatusBadge(value: min, scheme: .positive)
          MAULStatusBadge(value: min, scheme: .neutral)
        }
        HStack {
          MAULStatusBadge(value: middle, scheme: .info)
          MAULStatusBadge(value: middle, scheme: .warning)
          MAULStatusBadge(value: middle, scheme: .alert)
          MAULStatusBadge(value: middle, scheme: .positive)
          MAULStatusBadge(value: middle, scheme: .neutral)
        }
        HStack {
          MAULStatusBadge(value: max, scheme: .info)
          MAULStatusBadge(value: max, scheme: .warning)
          MAULStatusBadge(value: max, scheme: .alert)
          MAULStatusBadge(value: max, scheme: .positive)
          MAULStatusBadge(value: max, scheme: .neutral)
        }
      }
      .padding(.MAUL.S)
      .frame(maxWidth: .infinity)
      .background(Color.MAUL.Background.primary)
    }
    VStack {
      badges().environment(\.colorScheme, .light)
      badges().environment(\.colorScheme, .dark)
      Spacer()
    }
    .navigationTitle("Badge")
  }
}

struct BadgeScreen_Previews: PreviewProvider {
  static var previews: some View {
    BadgeScreen()
      .setupMAULForPreviews()
  }
}
