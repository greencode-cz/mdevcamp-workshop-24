import SwiftUI
import MAUL

struct ProgressViewScreen: View {

  @State private var downloadAmount = 33.0

  var body: some View {

    let view = VStack(spacing: .MAUL.S) {

      // Linear determinate
      ProgressView("Downloading…", value: downloadAmount, total: 100)
        .progressViewStyle(.maulLinear)
      // Linear determinate
      ProgressView(value: downloadAmount, total: 100)
        .progressViewStyle(.maulLinear)
      // Linear indeterminate
      ProgressView("Downloading…")
        .progressViewStyle(.maulLinear)
      // Linear indeterminate
      ProgressView()
        .progressViewStyle(.maulLinear)
      // Circular determinate
      ProgressView(value: downloadAmount, total: 100)
        .progressViewStyle(.maulCircularLarge)
      // Circular determinate
      ProgressView(value: downloadAmount, total: 100)
        .progressViewStyle(.maulCircularSmall)
      // Circular indeterminate
      ProgressView()
        .progressViewStyle(.maulCircularLarge)
      // Circular indeterminate
      ProgressView()
        .progressViewStyle(.maulCircularSmall)
    }
      .padding(.MAUL.S)
      .background(Color.MAUL.Background.primary)

    ScrollView {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct ProgressIndicatorScreen_Previews: PreviewProvider {
  static var previews: some View {
    ProgressViewScreen()
      .setupMAULForPreviews()
  }
}
