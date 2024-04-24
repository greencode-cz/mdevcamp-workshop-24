import MAUL
import SwiftUI

struct Assignment2: View {
  var body: some View {
    Text("Assignment2")
      .maulFontStyle(.h1)
      .foregroundColor(.MAUL.Text.primary)
  }
}

#Preview {
  Assignment2()
    .setupMAULForPreviews()
}
