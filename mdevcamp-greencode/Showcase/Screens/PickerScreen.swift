import SwiftUI
import MAUL

struct Ocean: Identifiable, Hashable {
  let name: String
  let id = UUID()
}
var oceans = [
  Ocean(name: "Pacific"),
  Ocean(name: "Atlantic"),
  Ocean(name: "Indian"),
  Ocean(name: "Southern"),
  Ocean(name: "Arctic")
]

struct PickerView<Style: PickerStyle>: View {

  @State private var selectedOcean = "Pacific"
  let style: Style

  init(_ style: Style) {
    self.style = style
  }

  var body: some View {
    Picker("Please choose a color", selection: $selectedOcean) {
      ForEach(oceans, id: \.self.name) {
        Text($0.name)
      }
    }
    .pickerStyle(style)
  }
}

struct PickerScreen: View {

  enum PickerStyles {
    case automatic
    case inline
    case menu
    case radioGroup
    case segmented
    case wheel
  }

  enum PickerEnvironment {
    case view
    case form
  }

  @State private var selectedScheme: ColorScheme = .light
  @State private var selectedEnvironment: PickerEnvironment = .view
  @State private var selectedStyle: PickerStyles = .automatic

  var body: some View {
    VStack {
      Form {
        Picker("Color scheme", selection: $selectedScheme) {
          Text("Light").tag(ColorScheme.light)
          Text("Dark").tag(ColorScheme.dark)
        }
        Picker("Environment", selection: $selectedEnvironment) {
          Text("View").tag(PickerEnvironment.view)
          Text("Form").tag(PickerEnvironment.form)
        }
        Picker("Style", selection: $selectedStyle) {
          Text("Automatic").tag(PickerStyles.automatic)
          Text("Inline").tag(PickerStyles.inline)
          Text("Menu").tag(PickerStyles.menu)
          Text("Segmented").tag(PickerStyles.segmented)
#if os(iOS)
          Text("Wheel").tag(PickerStyles.wheel)
#else
          Text("RadioGroup").tag(PickerStyles.radioGroup)
#endif
        }
      }

      if selectedEnvironment == .form {
        Form {
          switch selectedStyle {
          case .automatic:
            PickerView(.automatic)
          case .inline:
            PickerView(.inline)
          case .menu:
            PickerView(.menu)
          case .segmented:
            PickerView(.segmented)
#if os(iOS)
          case .radioGroup:
            PickerView(.automatic)
          case .wheel:
            PickerView(.wheel)
#else
          case .radioGroup:
            PickerView(.radioGroup)
          case .wheel:
            PickerView(.automatic)
#endif
          }
        }
      } else if selectedEnvironment == .view {
        switch selectedStyle {
        case .automatic:
          PickerView(.automatic)
        case .inline:
          PickerView(.inline)
        case .menu:
          PickerView(.menu)
        case .segmented:
          PickerView(.segmented)
#if os(iOS)
        case .radioGroup:
          PickerView(.automatic)
        case .wheel:
          PickerView(.wheel)
#else
        case .radioGroup:
          PickerView(.radioGroup)
        case .wheel:
          PickerView(.automatic)
#endif
        }
      }
    }
    .navigationTitle("Picker")
    .background(Color.MAUL.Background.primary)
    .environment(\.colorScheme, selectedScheme)
  }
}

struct PickerScreen_Previews: PreviewProvider {
  static var previews: some View {
    PickerScreen()
      .setupMAULForPreviews()
  }
}
