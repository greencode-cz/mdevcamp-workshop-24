import MAUL
import SwiftUI

struct Assignment3: View {
  var body: some View {
    Text("Assignment3")
      .maulFontStyle(.h1)
      .foregroundColor(.MAUL.Text.primary)
  }
}

#Preview {
  Assignment3()
    .setupMAULForPreviews()
}
