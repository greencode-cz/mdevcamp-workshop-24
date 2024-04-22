import SwiftUI
import MAUL

struct LabelScreen: View {

  struct BlueLabel: MAULFeatureLabelColorConfiguration {
    var text: Color = .MAUL.Text.Component.tertiary
    var background: Color = .blue
  }

  var body: some View {
    let view = VStack(spacing: .MAUL.S) {
      VStack {
        Text("Feature Label").maulFontStyle(.h3)
        HStack {
          Text("large")
          Spacer()
          MAULFeatureLabel(title: "Label", size: .large, colorConfiguration: BlueLabel())
        }
        HStack {
          Text("small")
          Spacer()
          MAULFeatureLabel(title: "Label", size: .small, colorConfiguration: BlueLabel())
        }
      }

      VStack {
        Text("Status Label").maulFontStyle(.h3)
        HStack {
          Text("positive")
          Spacer()
          MAULStatusLabel(title: "Label", status: .positive)
        }
        HStack {
          Text("warning")
          Spacer()
          MAULStatusLabel(title: "Label", status: .warning)
        }
        HStack {
          Text("alert")
          Spacer()
          MAULStatusLabel(title: "Label", status: .alert)
        }
        HStack {
          Text("neutral")
          Spacer()
          MAULStatusLabel(title: "Label", status: .neutral)
        }
      }
    }
      .padding(.MAUL.S)

    ScrollView {
      view
        .background(Color.MAUL.Background.primary)
        .environment(\.colorScheme, .light)

      view
        .background(Color.MAUL.Background.primary)
        .environment(\.colorScheme, .dark)
    }
  }
}

struct LabelScreen_Previews: PreviewProvider {
  static var previews: some View {
    LabelScreen()
      .setupMAULForPreviews()
  }
}
