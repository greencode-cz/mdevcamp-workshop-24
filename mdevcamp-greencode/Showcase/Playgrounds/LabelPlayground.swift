import SwiftUI
import MAUL

struct LabelPlayground: View {

  struct BlueLabel: MAULFeatureLabelColorConfiguration {
    var text: Color = .MAUL.Text.Component.tertiary
    var background: Color = .blue
  }

  enum LabelStyle: String, Equatable, CaseIterable {
    case maulPositive = "Status Positive"
    case maulWarning = "Status Warning"
    case maulAlert = "Status Alert"
    case maulNeutral = "Status Neutral"
    case maulLarge = "Large"
    case maulSmall = "Small"
  }

  @State var labelStyle: LabelStyle = .maulLarge

  @ViewBuilder func buildLabel() -> some View {
    EmptyView()
    switch labelStyle {
    case .maulPositive:
      MAULStatusLabel(title: "Label", status: .positive)
    case .maulWarning:
      MAULStatusLabel(title: "Label", status: .warning)
    case .maulAlert:
      MAULStatusLabel(title: "Label", status: .alert)
    case .maulNeutral:
      MAULStatusLabel(title: "Label", status: .neutral)
    case .maulLarge:
      MAULFeatureLabel(title: "Label", size: .large, colorConfiguration: BlueLabel())
    case .maulSmall:
      MAULFeatureLabel(title: "Label", size: .small, colors: .init(text: .MAUL.Text.Component.tertiary, background: .blue))
    }
  }

  func builtText() -> String {
    switch labelStyle {
    case .maulPositive:
      return "MAULStatusLabel(\n\ttitle: \"Label\",\n\tstatus: .positive)\n"
    case .maulWarning:
      return "MAULStatusLabel(\n\ttitle: \"Label\",\n\tstatus: .warning)\n"
    case .maulAlert:
      return "MAULStatusLabel(\n\ttitle: \"Label\",\n\tstatus: .alert)\n"
    case .maulNeutral:
      return "MAULStatusLabel(\n\ttitle: \"Label\",\n\tstatus: .neutral)\n"
    case .maulLarge:
      return """
            MAULFeatureLabel(
                title: "Label",
                size: .large,
                colors: .(
                    text: .MAUL.Text.Component.tertiary,
                    background: .red
                )
            )

            or

            struct BlueLabel: MAULFeatureLabelColorConfiguration {
                var text: Color = .MAUL.Text.Component.tertiary
                var background: Color = .blue
            }

            MAULFeatureLabel(
                title: "Label",
                size: .large,
                colorConfiguration: BlueLabel()
            )
            """
    case .maulSmall:
      return """
            MAULFeatureLabel(
                title: "Label",
                size: .small,
                colors: .(
                    text: .MAUL.Text.Component.tertiary,
                    background: .red
                )
            )

            or

            struct BlueLabel: MAULFeatureLabelColorConfiguration {
                var text: Color = .MAUL.Text.Component.tertiary
                var background: Color = .blue
            }

            MAULFeatureLabel(
                title: "Label",
                size: .small,
                colorConfiguration: BlueLabel()
            )
            """
    }
  }
  
  var controls: some View {
    HStack {
      Text("Style")
      Spacer()
      Picker("", selection: $labelStyle) {
        ForEach(LabelStyle.allCases, id: \.self) {
          Text($0.rawValue)
        }
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildLabel()
    } modalScreen: {
      LabelScreen()
    }
    .navigationTitle("Label")
  }
}

struct LabelPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LabelPlayground()
    }
    .setupMAULForPreviews()
  }
}
