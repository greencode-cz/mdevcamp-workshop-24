import SwiftUI
import MAUL

extension MAULTextField.Focus {
  var name: String {
    switch self {
    case .active: return "Active"
    case .focused: return "Focused"
    case .error: return "Error"
    case .default: return "Default"
    }
  }

  static var allCases: [MAULTextField.Focus] {
    [.default, .active, .focused, .error]
  }
}

struct TextFieldPlayground: View {
  @State private var state: MAULTextField.Focus = .default
  @State private var text = ""
  @State private var title = ""
  @State private var isFloating = true
  @State private var isIconShown = true
  @State private var isFooterVisible = true
  @State private var helper = ""
  @State private var action = true
  @State private var isCounterEnabled = true
  @State private var isDisabled = false
  private let defaultTitle = "Title"
  private let defaultHelper = "Helper text"
  private let icon = Image.MAUL.heart
  private let actionIcon = Image.MAUL.camera

  @ViewBuilder func buildComponent() -> some View {

    MAULTextField(
      state: $state,
      text: $text,
      titleConfiguration: .init(
        title: title.isEmpty ? defaultTitle : title,
        isFloating: isFloating
      ),
      icon: isIconShown ? icon : nil,
      action: action ? .init(
        icon: actionIcon,
        action: { print("Action button tapped") }
      ) : nil,
      footerConfiguration: .init(
        isHidden: !isFooterVisible,
        helperText: helper.isEmpty ? defaultHelper : helper,
        numberOfCharacters: isCounterEnabled ? 20 : nil
      )
    )
    .disabled(isDisabled)
    .padding()
  }

  func buildCode() -> String {
    var code = """
        MAULTextField(
            state: $state,
            text: $text,
            titleConfiguration: .init(
                title: "\(title.isEmpty ? defaultTitle : title)",
                isFloating: \(isFloating ? true : false)
            )
        """

    if isIconShown {
      code += ",\n    icon: Image.MAUL.heart"
    }

    if action {
      code += ",\n    action: .init("
      code += "\n        icon: Image.MAUL.camera,"
      code += "\n        action: { // action }"
      code += "\n    )"
    }

    if isFooterVisible {
      code += ",\n    footerConfiguration: .init("
      code += "\n        isHidden: \(isFooterVisible ? "false" : "true")"
      code += ",\n        helperText: \"\(helper.isEmpty ? defaultHelper : helper)\""
      if isCounterEnabled {
        code += ",\n        numberOfCharacters: 20"
      }
      code += "\n    )"
    }

    code += "\n)"

    if isDisabled {
      code += "\n.disabled(true)"
    }

    return code
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      TextField("Title", text: $title)

      Toggle("Floating title", isOn: $isFloating)
      Toggle("Icon", isOn: $isIconShown)
      Toggle("Footer", isOn: $isFooterVisible)

      if isFooterVisible {
        TextField(defaultHelper, text: $helper)
        Toggle("Counter", isOn: $isCounterEnabled)
      }

      Toggle("Action", isOn: $action)

      HStack {
        Text("State")
        Spacer()
        Picker("State", selection: $state) {
          ForEach(MAULTextField.Focus.allCases, id: \.self) {
            Text($0.name)
          }
        }
        .labelsHidden()
      }

      Toggle("Disabled", isOn: $isDisabled)

    }
    .textFieldStyle(.maul)
    .toggleStyle(.maul())
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      TextFieldScreen()
    }
    .navigationTitle("TextField")
  }
}

struct TextFieldPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TextFieldPlayground()
    }
    .setupMAULForPreviews()
  }
}
