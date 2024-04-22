import SwiftUI
import MAUL

struct TextEditorPlayground: View {
  @FocusState private var focused
  let defaultTitle = "Title"
  let defaultHelper = "Helper text"
  @State private var state: MAULTextField.Focus = .default
  @State private var text = ""
  @State private var title = ""
  @State private var isTitleFloating = true
  @State private var isFooterVisible = true
  @State private var helper = ""
  @State private var isCounterEnabled = true
  @State private var isTextFieldDisabled = false

  private let icon = Image.MAUL.heart
  private let actionIcon = Image.MAUL.camera

  @ViewBuilder func buildComponent() -> some View {
    MAULTextEditor(
      state: $state,
      text: $text,
      titleConfiguration: .init(
        title: title.isEmpty ? defaultTitle : title,
        isFloating: isTitleFloating
      ),
      footerConfiguration: .init(
        isHidden: !isFooterVisible,
        helperText: helper,
        numberOfCharacters: isCounterEnabled ? 20 : nil
      )
    )
    .disabled(isTextFieldDisabled)
    .padding(.MAUL.S)
  }

  func buildCode() -> String {
    var code = """
        MAULTextEditor(
            state: $state,
            text: $text,
            titleConfiguration: .init(
                title: "\(title.isEmpty ? defaultTitle : title)",
                isTitleFloating: \(isTitleFloating ? "true" : "false")
            )
        """

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

    if isTextFieldDisabled {
      code += "\n.disabled(true)"
    }

    return code
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      Group {
        TextField("Title", text: $title)

        Toggle("Floating Title", isOn: $isTitleFloating)
        Toggle("Footer", isOn: $isFooterVisible)

        if isFooterVisible {
          TextField(defaultHelper, text: $helper)
          Toggle("Counter", isOn: $isCounterEnabled)
        }

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

        Toggle("Disabled", isOn: $isTextFieldDisabled)
      }
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
      TextEditorScreen()
    }
    .navigationTitle("TextEditor")
  }
}

struct TextEditorPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TextEditorPlayground()
    }
    .setupMAULForPreviews()
  }
}
