import MAUL
import SwiftUI

struct CardScreen: View {
  @State var isSelected = true

  var body: some View {
    let box = GroupBox(label: Text("Header").maulFontStyle(.h1)) {
      HStack {
        VStack(alignment: .leading) {
          Text("First line of card Description\nSecond lien of card description")

          Button {
            print("tap")
          } label: {
            Image.MAUL.heartFill
          }
          .buttonStyle(.maulTertiary(layout: .icon))
        }

        Spacer()
      }
    }

    let view = VStack {
      Text("Disable select")
      box.groupBoxStyle(.maulCard())

      Text("Selected")
      box.groupBoxStyle(.maulCard(isSelected: isSelected))
    }
      .padding(.MAUL.S)

    VStack {
      ScrollView {
        view
      }
      .background(Color.MAUL.Background.primary)
      .environment(\.colorScheme, .light)

      ScrollView {
        view
      }
      .background(Color.MAUL.Background.primary)
      .environment(\.colorScheme, .dark)
    }
  }
}

struct CardScreen_Previews: PreviewProvider {
  static var previews: some View {
    CardScreen()
      .setupMAULForPreviews()
  }
}
