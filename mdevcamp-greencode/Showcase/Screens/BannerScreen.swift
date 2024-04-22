import SwiftUI
import MAUL

struct BannerScreen: View {
  var body: some View {
    VStack {
      let view = ScrollView {
        let message = "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua."
        let icon = Image.MAUL.circleInformationFill
        let primaryButtonCongig = MAULButtonConfig("Dismiss") { print("tap dismiss") }
        MAULBanner(message: message, primaryButton: primaryButtonCongig)
        MAULBanner(message: message, primaryButton: primaryButtonCongig, secondaryButton: .init("Confirm") { print("tap confirm") })
        MAULBanner(message: message, primaryButton: primaryButtonCongig, icon: icon)
        MAULBanner(message: message, primaryButton: primaryButtonCongig, secondaryButton: .init("Confirm") { print("tap confirm") }, icon: icon)
        MAULBanner(message: message, primaryButton: primaryButtonCongig, secondaryButton: .init("Confirm") { print("tap confirm") }, icon: icon)
        MAULBanner(message: message, primaryButton: primaryButtonCongig, secondaryButton: .init("Confirm") { print("tap confirm") }, illustration: .progress())
        MAULBanner(message: message, primaryButton: primaryButtonCongig, secondaryButton: .init("Confirm") { print("tap confirm") }, illustration: .progress(value: 1))
      }
        .background(Color.MAUL.Background.primary)
        .padding()

      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct BannerScreen_Previews: PreviewProvider {
  static var previews: some View {
    BannerScreen()
      .setupMAULForPreviews()
  }
}
