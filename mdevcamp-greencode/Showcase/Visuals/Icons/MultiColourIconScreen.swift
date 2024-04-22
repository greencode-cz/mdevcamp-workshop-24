import SwiftUI
import MAUL

struct MultiColourIconsScreen: View {

  @State var size = 20.0
  @State var applySize = false

  @State private var searchText = ""

  @ViewBuilder func iconFormatted(_ icon: Image) -> some View {
    if applySize {
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
      return Image.MAUL.allMultiColourValues
    } else {
      return Image.MAUL.allMultiColourValues.filter {
        $0.name.lowercased().contains(searchText.lowercased())
      }
    }
  }
}

struct MultiColourIconsScreen_Previews: PreviewProvider {
  static var previews: some View {
    MultiColourIconsScreen()
      .setupMAULForPreviews()
  }
}
