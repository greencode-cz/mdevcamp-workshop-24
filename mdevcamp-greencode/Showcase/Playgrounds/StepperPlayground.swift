import SwiftUI
import MAUL

struct StepperPlayground: View {

  @State var value = 0
  @State var step = 5
  @State var rangeFrom = 0
  @State var rangeTo = 100

  @ViewBuilder func buildComponent() -> some View {
    Stepper(value: $value, in: rangeFrom...rangeTo, step: step) {
      Text("\(value)")
        .font(.MAUL.regular())
    }.padding(.MAUL.S)
  }

  func buildCode() -> String {
    return """
        Stepper(value: $value,
                in: \(rangeFrom)...\(rangeTo),
                step: \(step)) {
            Text(\"\\(value)\")
        }
        """
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      HStack {
        VStack(alignment: .leading) {
          Group {
            Text("Value")
            Text("Range")
            Text("Step")
          }.frame(maxHeight: .infinity)
        }
        VStack {
          HStack {
            TextField("Value", value: $value, formatter: NumberFormatter())
          }
          HStack {
            TextField("From", value: $rangeFrom, formatter: NumberFormatter()) { _ in
              rangeFrom = min(rangeFrom, rangeTo)
            }
            TextField("To", value: $rangeTo, formatter: NumberFormatter()) { _ in
              rangeTo = max(rangeFrom, rangeTo)
            }
          }
          HStack {
            TextField("Step", value: $step, formatter: NumberFormatter())
          }
        }
      }
    }.textFieldStyle(.maul)
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      StepperScreen()
    }
    .navigationTitle("Stepper")
  }
}

struct StepperPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StepperPlayground()
    }
    .setupMAULForPreviews()
  }
}
