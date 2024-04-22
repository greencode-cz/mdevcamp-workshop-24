import SwiftUI

struct ColorPickerScreen: View {

  @State private var bgColor =
  Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

  var body: some View {
    Form {
      ColorPicker("Alignment Guides", selection: $bgColor)
    }
  }
}

struct ColorPickerScreen_Previews: PreviewProvider {
  static var previews: some View {
    ColorPickerScreen()
      .setupMAULForPreviews()
  }
}
