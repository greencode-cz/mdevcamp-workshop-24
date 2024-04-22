import SwiftUI
import MAUL

struct ChipPlayground: View {

  @State private var selected = false
  @State private var showIcon = false
  @State private var badgeInt: Int = 1
  @State private var onTap = false

  enum ChipType: String, CaseIterable {
    case solid = "Solid"
    case mapShadow = "MapShadow"
  }

  enum ChipContent: String, CaseIterable {
    case `default` = "Default"
    case chevron = "Chevron"
    case badge = "Badge"

    var value: MAULChipToggleStyle.ContentType {
      switch self {
      case .default:
        return .default
      case .chevron:
        return .chevron
      case .badge:
        return .badge(number: 1)
      }
    }
  }

  @State var chipType: ChipType = .solid
  @State var disabled: Bool = false
  @State var chipContent: ChipContent = .default

  @ViewBuilder func buildChip() -> some View {
    let toggle = Toggle("Chips", isOn: $selected)
    let icon: Image? = showIcon ? Image.MAUL.heart : nil
    let onTap: (() -> Void)? = self.onTap ? { print("tapped") } : nil

    switch chipType {
    case .solid:
      toggle
        .toggleStyle(
          .maulChip(
            style: .solid,
            contentType: chipContent.value,
            icon: icon,
            onTap: onTap
          )
        )
        .disabled(disabled)
    case .mapShadow:
      toggle
        .toggleStyle(
          .maulChip(
            style: .shadow,
            contentType: chipContent.value,
            icon: icon,
            onTap: onTap
          )
        )
        .disabled(disabled)
    }
  }

  func builtText() -> String {
    var content = ""
    if chipContent == .badge {
      content += ",\n\t\t\tcontentType: .badge(number: 1)"
    }
    if chipContent == .chevron {
      content += ",\n\t\t\tcontentType: .chevron"
    }
    if showIcon {
      content += ",\n\t\t\ticon: Image(\"heart\")"
    }
    if onTap {
      content += ",\n\t\t\tonTap: { print(\"tapped\") }"
    }
    var code = """
        Toggle("Chips", isOn: $selected)
        """
    switch chipType {
    case .solid:
      code += "\n\t.toggleStyle(\n\t\t.maulChip(\n\t\t\ttype: .solid\(content)\n\t\t)\n\t)"
    case .mapShadow:
      code += "\n\t.toggleStyle(\n\t\t.maulChip(\n\t\t\ttype: .shadow\(content)\n\t\t)\n\t)"
    }

    if disabled {
      code += "\n\t.disabled(true)"
    }
    return code
  }

  var controls: some View {
    Group {
      HStack {
        Text("Type")
        Spacer()
        Picker("", selection: $chipType) {
          ForEach(ChipType.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }

      Toggle("Disabled", isOn: $disabled)
        .toggleStyle(.maul())

      HStack {
        Text("Content")
        Spacer()
        Picker("", selection: $chipContent) {
          ForEach(ChipContent.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }

      HStack {
        Toggle("Icon", isOn: $showIcon)
          .toggleStyle(.maul())
      }

      HStack {
        Toggle("Selected", isOn: $selected)
          .toggleStyle(.maul())
      }

      HStack {
        Toggle("On tap", isOn: $onTap)
          .toggleStyle(.maul())
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildChip()
    } modalScreen: {
      ChipsScreen()
    }
    .navigationTitle("Chip")
  }
}

struct ChipPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ChipPlayground()
    }
    .setupMAULForPreviews()
  }
}
