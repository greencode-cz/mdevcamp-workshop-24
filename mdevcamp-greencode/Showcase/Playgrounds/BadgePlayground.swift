import SwiftUI
import MAUL

extension MAULStatusBadge.Scheme {
  var name: String {
    switch self {
    case .positive:
      return "positive"
    case .alert:
      return "alert"
    case .info:
      return "info"
    case .warning:
      return "warning"
    case .neutral:
      return "neutral"
    }
  }
}

struct BadgePlayground: View {

  @State var scheme: MAULStatusBadge.Scheme = .positive
  @State var value = 0

  @ViewBuilder func buildComponent() -> some View {
    MAULStatusBadge(value: value, scheme: scheme)
  }

  func buildCode() -> String {
        """
        MAULStatusBadge(
            value: \(value),
            scheme: .\(scheme.name)
        )
        """
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      HStack {
        TextField("Value", value: $value, formatter: NumberFormatter()).textFieldStyle(.maul)
        Stepper("", value: $value).labelsHidden()
      }

      HStack {
        Text("Scheme")
        Spacer()
        Picker("", selection: $scheme) {
          ForEach(MAULStatusBadge.Scheme.allCases, id: \.self) {
            Text($0.name)
          }
        }
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      BadgeScreen()
    }
    .navigationTitle("Badge")
  }
}

struct BadgePlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BadgePlayground()
    }
    .setupMAULForPreviews()
  }
}
