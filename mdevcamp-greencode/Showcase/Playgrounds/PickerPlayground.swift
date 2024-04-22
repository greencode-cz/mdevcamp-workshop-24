import SwiftUI
import MAUL

extension Picker {
  @ViewBuilder
  func pickerStyle(for customPickerStyle: PickerPlayground.PickerStyles) -> some View {
    switch customPickerStyle {
    case .automatic:
      pickerStyle(.automatic)
    case .inline:
      pickerStyle(.inline)
    case .menu:
      pickerStyle(.menu)
    case .segmented:
      pickerStyle(.segmented)
#if os(iOS)
    case .radioGroup:
      pickerStyle(.automatic)
    case .wheel:
      pickerStyle(.wheel)
#else
    case .radioGroup:
      pickerStyle(.radioGroup)
    case .wheel:
      pickerStyle(.automatic)
#endif
    }
  }
}

struct PickerPlayground: View {

  enum PickerStyles: String, CaseIterable {
    case automatic
    case inline
    case menu
    case radioGroup
    case segmented
    case wheel

    var name: String {
      return self.rawValue
    }
  }

  enum PickerEnvironment: String, CaseIterable {
    case view
    case form

    var name: String {
      return self.rawValue
    }
  }

  @State private var selectedEnvironment: PickerEnvironment = .view
  @State private var selectedStyle: PickerStyles = .automatic
  @State private var selectedOcean = "Pacific"

  @ViewBuilder private func buildPicker() -> some View {
    if selectedEnvironment == .form {
      Form {
        Picker("Please choose a color", selection: $selectedOcean) {
          ForEach(oceans, id: \.self.name) {
            Text($0.name)
          }
        }
        .pickerStyle(for: selectedStyle)
      }
    } else if selectedEnvironment == .view {
      Picker("Please choose a color", selection: $selectedOcean) {
        ForEach(oceans, id: \.self.name) {
          Text($0.name)
        }
      }
      .pickerStyle(for: selectedStyle)
    }
  }

  private func builtText() -> String {
    var code = """
        Picker("Please choose a color", selection: $selectedOcean) {
            ForEach(oceans, id: \\.self.name) {
                Text($0.name)
            }
        }
        .pickerStyle(.\(selectedStyle.name))
        """
    if selectedEnvironment == .form {
      code = """
            Form {
                \(code)
            }
            """
    }
    return code
  }

  private var controls: some View {
    Group {
      HStack {
        Text("Environment")
        Spacer()
        Picker("Environment", selection: $selectedEnvironment) {
          ForEach(PickerEnvironment.allCases, id: \.self) {
            Text($0.name)
          }
        }
      }

      HStack {
        Text("Style")
        Spacer()
        Picker("Style", selection: $selectedStyle) {
          ForEach(PickerStyles.allCases, id: \.self) {
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
      buildPicker()
    } modalScreen: {
      PickerScreen()
    }
    .navigationTitle("Picker")
  }
}

struct PickerPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PickerPlayground()
    }
    .setupMAULForPreviews()
  }
}
