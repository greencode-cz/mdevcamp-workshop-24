import SwiftUI
import MAUL

extension MAULButtonLayout: CaseIterable {
  public static var allCases: [MAULButtonLayout] = [
    .standard,
    .full,
    .compact,
    .icon
  ]

  var name: String {
    switch self {
    case .standard : return "Standard"
    case .full : return "Full"
    case .compact : return "Compact"
    case .icon : return "Icon"
    }
  }

  var contents: [ButtonPlayground.ButtonContents] {
    switch self {
    case .standard, .full:
      return  [.text, .imageText]
    case .compact:
      return [.text]
    case .icon:
      return [.image]
    }
  }

  var fabLayout: FABButtonLayout {
    switch self {
    case .compact:
      return .compact
    case .icon:
      return .icon
    default:
      return .compact
    }
  }
}

struct ButtonPlayground: View {

  @State var buttonContent: ButtonContents = .text

  enum ButtonStyles: String, Equatable, CaseIterable {
    case primary = "Primary"
    case secondary = "Secondary"
    case tertially = "Tertiary"
    case outline = "Outline"
    case fabPrimary = "FABPrimary"
    case fabSecondary = "FABSecondary"

    var name: String {
      return self.rawValue
    }

    var layouts: [MAULButtonLayout] {
      switch self {
      case .primary, .secondary, .tertially, .outline:
        return [.standard, .full, .compact, .icon]
      case .fabPrimary, .fabSecondary:
        return [.compact, .icon]
      }
    }
  }

  enum ButtonContents: String, Equatable, CaseIterable {
    case text = "text"
    case imageText = "image+text"
    case image = "image"

    var name: String {
      return self.rawValue
    }
  }

  @State var disabled: Bool = false
  @State var buttonStyle: ButtonStyles = .primary
  @State var buttonLayout: MAULButtonLayout = .standard

  @ViewBuilder func createContentButton() -> some View {
    switch buttonContent {
    case .text:
      Button("Button") {
        print("button tapped")
      }
    case .imageText:
      Button {
        print("button tapped")
      } label: {
        HStack(spacing: .MAUL.XXS) {
          Image.MAUL.heart
            .resizable()
            .frame(width: 20, height: 20)
          Text("Button")
        }
      }
    case .image:
      Button {
        print("button tapped")
      } label: {
        Image.MAUL.heart
          .resizable()
          .frame(width: 20, height: 20)
      }
    }
  }

  @ViewBuilder func createButton() -> some View {
    let button = createContentButton()

    switch buttonStyle {
    case .primary:
      button.buttonStyle(.maulPrimary(layout: buttonLayout))
    case .secondary:
      button.buttonStyle(.maulSecondary(layout: buttonLayout))
    case .tertially:
      button.buttonStyle(.maulTertiary(layout: buttonLayout))
    case .outline:
      button.buttonStyle(.maulOutline(layout: buttonLayout))
    case .fabPrimary:
      button.buttonStyle(.maulFABPrimary(layout: buttonLayout.fabLayout))
    case .fabSecondary:
      button.buttonStyle(.maulFABSecondary(layout: buttonLayout.fabLayout))
    }
  }

  @ViewBuilder func buildButton() -> some View {
    createButton()
      .disabled(disabled)
  }

  func builtText() -> String {
    var code = ""
    switch buttonContent {
    case .text:
      code.append("""
                Button(\"Button\") {
                    print("button tapped")
                }
                """)
    case .imageText:
      code.append("""
                Button {
                    print("button tapped")
                } label: {
                    Label("Button", systemImage: "heart")
                }
                """)
    case .image:
      code.append("""
                Button {
                    print("button tapped")
                } label: {
                    Image(systemName: "heart")
                }
                """)
    }

    code.append("""
        \n.buttonStyle(.maul\(buttonStyle.name)(layout: .\(buttonLayout.name.lowercased()))
        """)

    if disabled {
      code.append("""
            \n.disabled(true)
            """)
    }
    return code
  }

  var controls: some View {
    Group {
      HStack {
        Text("Content")
        Spacer()
        Picker("", selection: $buttonContent) {
          ForEach(buttonLayout.contents, id: \.self) {
            Text($0.name)
          }
        }
      }

      Toggle(isOn: $disabled) {
        Text("Disabled")
      }
      .toggleStyle(.maul())

      HStack {
        Text("Style")
        Spacer()
        Picker("", selection: $buttonStyle) {
          ForEach(ButtonPlayground.ButtonStyles.allCases, id: \.self) {
            Text($0.name)
          }
        }
        .onChange(of: buttonStyle) { _ in
          if !buttonStyle.layouts.contains(buttonLayout) {
            buttonLayout = buttonStyle.layouts.first ?? .compact
          }
        }
      }

      HStack {
        Text("Layout")
        Spacer()
        Picker("", selection: $buttonLayout) {
          ForEach(buttonStyle.layouts, id: \.self) {
            Text($0.name)
          }
        }
        .onChange(of: buttonLayout) { _ in
          if !buttonLayout.contents.contains(buttonContent) {
            buttonContent  = buttonLayout.contents.first ?? .text
          }
        }
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildButton()
    } modalScreen: {
      ButtonScreen()
    }
    .navigationTitle("Button")
  }
}

struct ButtonPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ButtonPlayground()
    }
    .setupMAULForPreviews()
  }
}
