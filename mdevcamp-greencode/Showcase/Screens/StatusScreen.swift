import SwiftUI
import MAUL

struct StatusScreen: View {

  var body: some View {
    let badges = VStack {
      MAULStatus.positive.icon()
      MAULStatus.alert.icon()
      MAULStatus.warning.icon()
      MAULStatus.neutral.icon()
    }
      .padding()
      .frame(maxWidth: .infinity)

    ScrollView {
      badges
        .background(Color.MAUL.Background.primary)
        .environment(\.colorScheme, .light)
      badges
        .background(Color.MAUL.Background.primary)
        .environment(\.colorScheme, .dark)
      Spacer()
    }
    .navigationTitle("Status")
  }
}

struct StatusScreen_Previews: PreviewProvider {
  static var previews: some View {
    StatusScreen()
      .setupMAULForPreviews()
  }
}
