import SwiftUI
import MAUL

extension MAULTimestampPageControl.Format: CaseIterable {

  public static var allCases: [MAULTimestampPageControl.Format] = [
    .HMS,
    .MS
  ]

  var name: String {
    switch self {
    case .HMS:
      return "HMS"
    case .MS:
      return "MS"
    }
  }
}

struct TimestampPageControlPlayground: View {

  @State private var durationInSec: Double = 0
  @State private var format: MAULTimestampPageControl.Format = .MS

  @ViewBuilder private func buildComponent() -> some View {
    VStack {
      MAULTimestampPageControl(
        timeInterval: durationInSec,
        format: format
      )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.MAUL.Text.primary)
  }

  private func builtText() -> String {
    return """
        MAULTimestampPageControl(timestamp: \(durationInSec), format: .\(format.name))
        """
  }

  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    formatter.decimalSeparator = ""
    formatter.groupingSeparator = ""
    return formatter
  }()

  private var controls: some View {
    Group {
      TextField("Seconds", value: $durationInSec, formatter: numberFormatter)
        .textFieldStyle(.maul)

      HStack {
        Text("Format")
        Spacer()
        Picker("Format", selection: $format) {
          ForEach(MAULTimestampPageControl.Format.allCases, id: \.self) {
            Text($0.name)
          }
        }
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      TimestampPageControlScreen()
    }
    .navigationTitle("Page Control")
  }
}

struct TimestampPageControlPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TimestampPageControlPlayground()
    }
    .setupMAULForPreviews()
  }
}
