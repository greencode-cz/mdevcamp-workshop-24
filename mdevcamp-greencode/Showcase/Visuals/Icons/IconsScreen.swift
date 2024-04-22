import SwiftUI
import MAUL

struct IconsScreen: View {

  @State var color = Color.black
  @State var applyColor = false

  @State var size = 20.0
  @State var applySize = false

  @State private var searchText = ""

  @ViewBuilder func iconFormatted(_ icon: Image) -> some View {
    if applySize && applyColor {
      icon
        .resizable()
        .frame(width: size, height: size)
        .foregroundColor(color)
    } else if applyColor {
      icon
        .foregroundColor(color)
    } else if applySize {
      icon
        .resizable()
        .frame(width: size, height: size)
    } else {
      icon
    }
  }

  var body: some View {
    ScrollView {
      VStack {
        Toggle("Apply color", isOn: $applyColor)
          .toggleStyle(.maul())
        ColorPicker("Color", selection: $color)
        Divider().withMAULStyle
        Toggle("Apply size", isOn: $applySize)
          .toggleStyle(.maul())
        HStack {
          Text("Size")
          Spacer()
          Picker("", selection: $size) {
            Text("20").tag(20.0)
            Text("24").tag(24.0)
            Text("32").tag(32.0)
            Text("40").tag(40.0)
          }
        }
#if os(iOS)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
#else
        .searchable(text: $searchText, placement: .automatic)
#endif
        ForEach(searchResults, id: \.self) { image in
          HStack {
            iconFormatted(image.image)
            Spacer()
            Text(image.name)
          }
          Divider().withMAULStyle
        }
      }
      .padding(.horizontal, .MAUL.S)
    }
    .navigationTitle("Icons")
  }

  var searchResults: [MAULImage] {
    if searchText.isEmpty {
      return Image.MAUL.allValues
    } else {
      return Image.MAUL.allValues.filter {
        $0.name.lowercased().contains(searchText.lowercased())
      }
    }
  }
}

struct IconsScreen_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Text(MAULImage.MultiColour.battery10.name)
      MAULImage.MultiColour.battery10.image

      Image.MAUL.MultiColour.battery10

    }
    //        IconsScreen()
    //            .setupMAULForPreviews()
  }
}
