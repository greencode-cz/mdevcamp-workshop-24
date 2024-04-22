import Foundation
import SwiftUI
import MAUL

struct ContainElementAccesibilityModifier: ViewModifier {

  var identifier: String

  func body(content: Content) -> some View {
    content
      .accessibilityElement(children: .contain)
      .accessibilityIdentifier(identifier)
  }
}

extension View {
  func addAcessibilityIdentifier(_ identifier: String) -> some View {
    self.modifier(ContainElementAccesibilityModifier(identifier: identifier))
  }
}

struct AccessibilityScreen: View {
  var body: some View {
    ScrollView {
      VStack {
        MAULCell.default(title: "Cell title", description: "Cell description", icon: Image.MAUL.add)
          .addAcessibilityIdentifier("MAULCell.default.icon")
        MAULCell.default(title: "Cell title", description: "Cell description", image: Image("avatar"))
          .addAcessibilityIdentifier("MAULCell.default.image")
        MAULCell.default(title: "Cell title", description: "Cell description", status: .alert)
          .addAcessibilityIdentifier("MAULCell.default.status")
        MAULCell.default(title: "Cell title", description: "Cell description",
                         initials: "AA")
        .addAcessibilityIdentifier("MAULCell.default.initials")

        Divider()

        MAULCell.selectableValue(
          .init(
            value: "Value",
            icon: .MAUL.add
          ),
          title: "Selectable value cell",
          description: "Cell description",
          icon: .MAUL.add
        )
        .addAcessibilityIdentifier("MAULCell.selectableValue.icon")
        MAULCell.selectableValue(
          .init(
            value: "Value",
            icon: .MAUL.add
          ),
          title: "Selectable value cell",
          description: "Cell description",
          image: Image("avatar")
        )
        .addAcessibilityIdentifier("MAULCell.selectableValue.image")
        MAULCell.selectableValue(
          .init(
            value: "Value",
            icon: .MAUL.add
          ),
          title: "Selectable value cell",
          description: "Cell description",
          initials: "AA"
        )
        .addAcessibilityIdentifier("MAULCell.selectableValue.initials")
        MAULCell.selectableValue(
          .init(
            value: "Value",
            icon: .MAUL.add
          ),
          title: "Selectable value cell",
          description: "Cell description",
          status: .alert
        )
        .addAcessibilityIdentifier("MAULCell.selectableValue.status")
      }
    }
    .accessibilityIdentifier("accesibility_screen")
  }
}

struct AccessibilityScreen_Previews: PreviewProvider {
  static var previews: some View {
    AccessibilityScreen()
      .setupMAULForPreviews()
  }
}
