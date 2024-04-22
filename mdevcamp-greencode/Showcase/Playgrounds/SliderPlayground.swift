import SwiftUI
import MAUL

struct SliderPlayground: View {

  @State private var value = 20.0000
  @State private var range = 20.000...80.0000
  @State private var inRange = 0.000...100.000
  @State private var step = 20.0000

  @State private var useStep = false

  enum SliderSelection: String, CaseIterable {
    case value = "Value"
    case range = "Range"
  }

  @State var disabled: Bool = false
  @State var showLabel: Bool = false
  @State var selection: SliderSelection = .value

  @State private var lowerBound = 0.0
  @State private var upperBound = 0.0
  @State private var lowerRange = 0.0
  @State private var upperRange = 0.0

  func updateRanges() {
    self.lowerBound = inRange.lowerBound
    self.upperBound = inRange.upperBound
    self.lowerRange = range.lowerBound
    self.upperRange = range.upperBound
  }

  var textClosure:(MAULSliderIndex, NSNumber) -> (String) = { index, value in
    return "\(value)"
  }

  @ViewBuilder func buildSliderView() -> some View {
    if selection == .range {
      MAULSlider(range: $range, in: inRange, step: useStep ? step : nil, text: showLabel ? textClosure : nil, onEditingChanged:  { _ in
        updateRanges()
      }).disabled(disabled)
    }
    if selection == .value {
      MAULSlider(value: $value, in: inRange, step: useStep ? step : nil, text: showLabel ? textClosure : nil).disabled(disabled)
    }
  }

  func builtText() -> String {
    let selection = selection == .range ? "range: $range" : "value: $value"
    var code = """
        MAULSlider(\(selection), in: \(self.lowerBound)...\(self.upperBound)
        """
    if useStep {
      code += ", step: \(step)"
    }
    code += ")"

    if showLabel {
      code += """
            { index, value in
                return "\\(value)"
            }
            """
    }
    if disabled {
      code += ".disabled(true)"
    }
    return code
  }

  private let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.roundingMode = .down
    formatter.maximumFractionDigits = 3
    return formatter
  }()

  var controls: some View {
    Group {
      VStack(alignment: .leading) {
        Text("Bounds").maulFontStyle(.h3)
        HStack {
          Text("Range from")
          Spacer()
          TextField("from", value: $lowerBound, formatter: self.numberFormatter) {
            if self.inRange.upperBound >= lowerBound {
              self.inRange = lowerBound...self.inRange.upperBound
            } else {
              lowerBound = min(lowerBound, self.inRange.upperBound)
            }
          }.multilineTextAlignment(.trailing)
        }
        HStack {
          Text("Range to")
          TextField("to", value: $upperBound, formatter: self.numberFormatter) {
            if self.inRange.lowerBound <= upperBound {
              self.inRange = self.inRange.lowerBound...upperBound
            } else {
              upperBound = max(upperBound, self.inRange.lowerBound)
            }
          }.multilineTextAlignment(.trailing)

        }
        Divider().withMAULStyle
        HStack {
          Text("Selection")
          Spacer()
          Picker("", selection: $selection) {
            ForEach(SliderSelection.allCases, id: \.self) {
              Text($0.rawValue)
            }
          }
        }
        if selection == .value {
          HStack {
            Text("Selected value")
            Spacer()
            TextField("", value: $value, formatter: self.numberFormatter).multilineTextAlignment(.trailing)
          }
        }

        if selection == .range {
          Text("Selected range").maulFontStyle(.h3)
          HStack {
            Text("Range from")
            Spacer()
            TextField("from", value: $lowerRange, formatter: self.numberFormatter) {
              if self.range.upperBound >= lowerRange {
                self.range = lowerRange...self.range.upperBound
              } else {
                lowerRange = min(lowerRange, self.range.upperBound)
              }
            }.multilineTextAlignment(.trailing)
          }
          HStack {
            Text("Range to")
            Spacer()
            TextField("to", value: $upperRange, formatter: self.numberFormatter) {
              if self.range.lowerBound <= upperRange {
                self.range = self.range.lowerBound...upperRange
              } else {
                upperRange = min(upperRange, self.range.lowerBound)
              }
            }.multilineTextAlignment(.trailing)
          }
          Divider().withMAULStyle
        }

        Toggle("Step use", isOn: $useStep)

        if useStep {
          HStack {
            Text("Step value")
            Spacer()
            TextField("step", value: $step, formatter: self.numberFormatter).multilineTextAlignment(.trailing)
          }
        }

        Group {
          Toggle("With text", isOn: $showLabel)
          Toggle("Disabled", isOn: $disabled)
        }
      }
      
    }
    .textFieldStyle(.maul)
    .toggleStyle(.maul())
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildSliderView()
        .padding(.horizontal, .MAUL.XS)
    } modalScreen: {
      SliderScreen()
    }
    .onAppear(perform: {
      updateRanges()
    })
    .navigationTitle("Slider")
  }
}

struct SliderPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SliderPlayground()
    }
    .setupMAULForPreviews()
  }
}
