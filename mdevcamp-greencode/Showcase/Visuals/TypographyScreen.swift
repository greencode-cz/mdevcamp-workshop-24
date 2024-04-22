import SwiftUI
import MAUL

struct TypographyScreen: View {
  var body: some View {
    List {
      Group {
        Text("Display40/40\nDisplay40/40\nDisplay40/40").maulFontStyle(.display)
        Text("Header 1 28/36\nHeader 1 28/36\nHeader 1 28/36").maulFontStyle(.h1)
        Text("Header 2 24/28\nHeader 2 24/28\nHeader 2 24/28").maulFontStyle(.h2)
        Text("Header 3 20/24\nHeader 3 20/24\nHeader 3 20/24").maulFontStyle(.h3)
        Text("Header 4 16/24\nHeader 4 16/24\nHeader 4 16/24").maulFontStyle(.h4)
        Text("Header 5 14/20\nHeader 5 14/20\nHeader 5 14/20").maulFontStyle(.h5)
        Text("Header 6 14/20\nHeader 6 14/20\nHeader 5 14/20").maulFontStyle(.body)
      }
      Group {
        Text("Body 1 - Skoda\n Next Regular - 16/24").maulFontStyle(.body1)
        Text("Body 1 - Skoda\n Next Regular - 16/24").maulFontStyle(.body1Link)
        Text("Body 2 - Skoda\n Next Regular - 10/Auto").maulFontStyle(.body2)
        Text("Disclaimer - Skoda\n Next Regular - 12/16").maulFontStyle(.disclaimer)
        Text("Disclaimer - Skoda\n Next Regular - 12/16").maulFontStyle(.disclaimerBold)
        Text("Disclaimer - Skoda\n Next Regular - 12/16").maulFontStyle(.disclaimerLink)
        Text("Label - SKODA NEXT\n Black 0.273 EM11/12").maulFontStyle(.label)
      }
    }
    .listStyle(.plain)
    .navigationTitle("Typography")
  }
}

struct TypographyScreen_Previews: PreviewProvider {
  static var previews: some View {
    TypographyScreen()
      .setupMAULForPreviews()
  }
}
