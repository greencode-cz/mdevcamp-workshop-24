import SwiftUI
import MAUL

struct NamedColor: Hashable {
  var name: String
  var color: Color
}

extension Color.MAUL {

  static let allValues: [NamedColor] = [
    // Background
    NamedColor(name: "Background/Component/Primary",
               color: Color.MAUL.Background.Component.primary),
    NamedColor(name: "Background/Component/Secondary",
               color: Color.MAUL.Background.Component.secondary),
    NamedColor(name: "Background/Component/Tertiary",
               color: Color.MAUL.Background.Component.tertiary),
    NamedColor(name: "Background/Primary",
               color: Color.MAUL.Background.primary),
    NamedColor(name: "Background/Secondary",
               color: Color.MAUL.Background.secondary),
    NamedColor(name: "Background/Tertiary",
               color: Color.MAUL.Background.tertiary),
    // Brand
    NamedColor(name: "Brand/Primary",
               color: Color.MAUL.Brand.primary),
    NamedColor(name: "Brand/Secondary",
               color: Color.MAUL.Brand.secondary),
    NamedColor(name: "Brand/Tertiary",
               color: Color.MAUL.Brand.tertiary),
    NamedColor(name: "Brand/Quartenary",
               color: Color.MAUL.Brand.quartenary),
    NamedColor(name: "Brand/Quinary",
               color: Color.MAUL.Brand.quinary),
    // Neutral
    NamedColor(name: "Neutral/Primary",
               color: Color.MAUL.Neutral.primary),
    NamedColor(name: "Neutral/Secondary",
               color: Color.MAUL.Neutral.secondary),
    NamedColor(name: "Neutral/Tertiary",
               color: Color.MAUL.Neutral.tertiary),
    NamedColor(name: "Neutral/Quartenary",
               color: Color.MAUL.Neutral.quartenary),
    NamedColor(name: "Neutral/Quinary",
               color: Color.MAUL.Neutral.quinary),
    // Semantic
    NamedColor(name: "Semantic/Info",
               color: Color.MAUL.Semantic.info),
    NamedColor(name: "Semantic/Positive",
               color: Color.MAUL.Semantic.positive),
    NamedColor(name: "Semantic/Warning",
               color: Color.MAUL.Semantic.warning),
    NamedColor(name: "Semantic/Alert",
               color: Color.MAUL.Semantic.alert),
    // Surface
    NamedColor(name: "Surface/Primary",
               color: Color.MAUL.Surface.primary),
    NamedColor(name: "Surface/Secondary",
               color: Color.MAUL.Surface.secondary),
    // Text
    NamedColor(name: "Text/Component/Primary",
               color: Color.MAUL.Text.Component.primary),
    NamedColor(name: "Text/Component/Secondary",
               color: Color.MAUL.Text.Component.secondary),
    NamedColor(name: "Text/Component/Tertiary",
               color: Color.MAUL.Text.Component.tertiary),
    NamedColor(name: "Text/Primary",
               color: Color.MAUL.Text.primary),
    NamedColor(name: "Text/Secondary",
               color: Color.MAUL.Text.secondary),
    NamedColor(name: "Text/Tertiary",
               color: Color.MAUL.Text.tertiary),
    NamedColor(name: "Text/Quartenary",
               color: Color.MAUL.Text.quartenary)
  ]

}

struct ColorScreen: View {
  var body: some View {
    List(Color.MAUL.allValues, id: \.self) { color in
      ColorRow(color: color)
    }
    .listStyle(.plain)
    .navigationTitle("Colors")
    EmptyView()
  }
}

struct ColorRow: View {
  var color: NamedColor

  var body: some View {
    HStack {
      RoundedRectangle(cornerRadius: 10)
        .frame(width: 100, height: 50, alignment: .leading)
        .foregroundColor(color.color)
      Text(color.name)
      Spacer()
    }
  }
}

struct ColorScreen_Previews: PreviewProvider {
  static var previews: some View {
    ColorScreen()
      .setupMAULForPreviews()
  }
}
