import SwiftUI
import MAUL

struct SliderScreen: View {

  @State private var value = 30.0
  @State private var range = 20.0...80.0

  var numberFormatter: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    return numberFormatter
  }

  var body: some View {

    let view  = VStack(spacing: .MAUL.S) {
      Group {
        Text("Native")

        Slider(value: $value, in: 0...100)
          .modifier(MAULStyle())

        Slider(value: $value, in: 0...100, step: 10)
          .modifier(MAULStyle())
      }
      Group {
        Text("Custom")
        MAULSlider(value: $value, in: 0...100)
        MAULSlider(value: $value, in: 0...100, step: 10)
        MAULSlider(range: $range, in: 0...100)
        MAULSlider(range: $range, in: 0...100, step: 10)
        MAULSlider(value: $value, in: 0...100).disabled(true)
        MAULSlider(value: $value, in: 0...100, step: 10).disabled(true)
        MAULSlider(range: $range, in: 0...100).disabled(true)
        MAULSlider(range: $range, in: 0...100, step: 10).disabled(true)
      }
      Group {
        Text("Custom with label")
        MAULSlider(value: $value, in: 0...100, step: 20) { index, value in
          let formattedValue = numberFormatter.string(from: value)!
          return "\(formattedValue)"
        }
        MAULSlider(value: $value, in: 0...100, step: 20) { index, value in
          let formattedValue = numberFormatter.string(from: value)!
          switch index {
          case .first, .last(_):
            return "\(formattedValue)"
          case  .middle(_):
            return ""
          }
        }
        MAULSlider(value: $value, in: 0...100){ index, value in
          let formattedValue = numberFormatter.string(from: value)!
          return "\(formattedValue)"
        }
      }
    }
      .padding(.MAUL.S)
      .background(Color.MAUL.Background.primary)

    ScrollView {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct SliderScreen_Previews: PreviewProvider {
  static var previews: some View {
    SliderScreen()
      .setupMAULForPreviews()
  }
}
