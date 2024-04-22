import SwiftUI
import MAUL

struct LogosScreen: View {
  var body: some View {
    ScrollView {
      VStack(spacing: .MAUL.XXL) {
        VStack {
          Text("Corporate logo")
            .maulFontStyle(.h1)
          Image.MAUL.Logo.corporateLogo
        }
        VStack {
          Text("Wordmark")
            .maulFontStyle(.h1)
          Image.MAUL.Logo.wordmark
        }
        VStack {
          Text("Picturemark")
            .maulFontStyle(.h1)
          Image.MAUL.Logo.picturemark
        }
      }
      .frame(maxWidth: .infinity)
    }
    .navigationTitle("Logos")
  }
}

struct LogosScreen_Previews: PreviewProvider {
  static var previews: some View {
    LogosScreen()
      .setupMAULForPreviews()
  }
}
