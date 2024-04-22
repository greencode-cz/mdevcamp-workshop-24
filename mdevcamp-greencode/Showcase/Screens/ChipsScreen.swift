import SwiftUI
import MAUL

struct ChipsScreen: View {

  @State private var selected = false

  var body: some View {
    let view = HStack {
      let toggle = Toggle("Chips", isOn: $selected)
      let icon = Image.MAUL.heart

      VStack {
        Text("Solid")
        toggle
          .toggleStyle(.maulChip(style: .solid, contentType: .default))
        toggle
          .toggleStyle(.maulChip(style: .solid, contentType: .chevron))
        toggle
          .toggleStyle(.maulChip(style: .solid, contentType: .default, icon: icon))
        toggle
          .toggleStyle(.maulChip(style: .solid, contentType: .chevron, icon: icon))
        toggle
          .toggleStyle(.maulChip(style: .solid, contentType: .badge(number: 1), icon: icon))
      }

      VStack {
        Text("MapShadow")
        toggle
          .toggleStyle(.maulChip(style: .shadow, contentType: .default))
        toggle
          .toggleStyle(.maulChip(style: .shadow, contentType: .chevron))
        toggle
          .toggleStyle(.maulChip(style: .shadow, contentType: .default, icon: icon))
        toggle
          .toggleStyle(.maulChip(style: .shadow, contentType: .chevron, icon: icon))
        toggle
          .toggleStyle(.maulChip(style: .shadow, contentType: .badge(number: 1), icon: icon))
      }
    }.padding(.all, .MAUL.S)
    ScrollView {
      VStack {
        view
        view.disabled(true)
      }
      .frame(maxWidth: .infinity)
      .background(Color.MAUL.Background.primary)
      .environment(\.colorScheme, .light)
      VStack {
        view
        view.disabled(true)
      }
      .frame(maxWidth: .infinity)
      .background(Color.MAUL.Background.primary)
      .environment(\.colorScheme, .dark)
    }
  }
}

struct ChipsScreen_Previews: PreviewProvider {
  static var previews: some View {
    ChipsScreen()
      .setupMAULForPreviews()
  }
}
