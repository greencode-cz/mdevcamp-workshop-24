import MAUL
import SwiftUI

struct Assignment: View {
  var body: some View {
    ScrollView{

      ForEach(0..<100) {_ in
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
          .maulFontStyle(.h1)
          .foregroundColor(.MAUL.Text.primary)
      }

    }
  }
}

#Preview {
  Assignment()
    .setupMAULForPreviews()
}
