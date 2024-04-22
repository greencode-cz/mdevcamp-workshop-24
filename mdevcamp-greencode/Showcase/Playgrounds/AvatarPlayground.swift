import SwiftUI
import MAUL

extension MAULAvatar.Size {
  var name: String {
    switch self {
    case .small:
      return "small"
    case .medium:
      return "medium"
    case .large:
      return "large"
    case .extraLarge:
      return "extraLarge"
    case .custom:
      return "custom(100)"
    }
  }
}

extension MAULAvatar.Size: CaseIterable {
  public static var allCases: [MAULAvatar.Size] {
    [.small, .medium, .large, .extraLarge, .custom(100)]
  }
}

extension MAULAvatar.Size: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }

  public static func == (lhs: MAULAvatar.Size, rhs: MAULAvatar.Size) -> Bool {
    switch (lhs, rhs) {
    case (.small, .small):
      return true
    case (.medium, .medium):
      return true
    case (.large, .large):
      return true
    case (.extraLarge, .extraLarge):
      return true
    case (.custom(let lhsSize), .custom(let rhsSize)):
      return lhsSize == rhsSize
    default:
      return false
    }
  }
}

struct AvatarPlayground: View {

  @State var image: Image = Image("avatar")
  @State var size: MAULAvatar.Size = .medium
  @State var initials: String = "WW"
  @State var disabled: Bool = false

  enum Style: CaseIterable {
    case image
    case initials
    case icon

    var code: String {
      switch self {
      case .image:
        return "image: Image(\"avatar\")"
      case .initials:
        return "initials: \"WW\""
      case .icon:
        return "icon:  Image.MAUL.userFill"
      }
    }

    var name: String {
      switch self {
      case .image:
        return "image"
      case .initials:
        return "initials"
      case .icon:
        return "icon"
      }
    }
  }

  @State var style: Style = .image

  @ViewBuilder func buildComponent() -> some View {
    if style == .initials {
      MAULAvatar(initials: initials, size: size)
        .disabled(disabled)
    }
    if style == .image {
      MAULAvatar(image: image, size: size)
        .disabled(disabled)
    }
    if style == .icon {
      MAULAvatar(icon: Image.MAUL.userFill, size: size)
        .disabled(disabled)
    }
  }

  func buildCode() -> String {
    var code = """
        MAULAvatar(
            \(style.code),
            size: .\(size)
        )
        """

    if disabled {
      code += "\n.disabled(true)"
    }

    return code
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      Picker("", selection: $style) {
        ForEach(Style.allCases, id: \.self) {
          Text($0.name)
        }
      }
      .pickerStyle(.segmented)

      if style == .initials {
        TextField("Initials", text: $initials)
      }

      HStack {
        Text("size")
        Spacer()
        Picker("", selection: $size) {
          ForEach(MAULAvatar.Size.allCases, id: \.self) {
            Text($0.name)
          }
        }
      }

      HStack {
        Toggle("Disabled", isOn: $disabled)
          .toggleStyle(.maul())
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      AvatarScreen()
    }
    .navigationTitle("Avatar")
  }
}

struct AvatarPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AvatarPlayground()
    }
    .setupMAULForPreviews()
  }
}
