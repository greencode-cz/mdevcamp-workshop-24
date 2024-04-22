import SwiftUI
import MAUL

extension MAULStatus: CaseIterable {
  public static var allCases: [MAULStatus] = [
    .positive,
    .warning,
    .alert,
    .neutral
  ]

  var rawValue: String {
    switch self {
    case .positive:
      return "positive"
    case .warning:
      return "warning"
    case .alert:
      return "alert"
    case .neutral:
      return "neutral"
    }
  }
}

struct MAULSeparator: ViewModifier {
  func body(content: Content) -> some View {
    content
#if os(iOS)
      .listRowSeparator(.hidden)
#endif
      .listRowBackground(
        VStack {
          Spacer()
          Divider().withMAULStyle
        }
          .padding(.horizontal, 20)
      )
  }
}

extension View {
  func maulSeparator() -> some View {
    return modifier(MAULSeparator())
  }
}

extension List {
  @ViewBuilder
  func listStyle(_ customListStyle: ListPlayground.ListStyles) -> some View {
    switch customListStyle {
#if os(macOS)
    case .bordered:
      listStyle(BorderedListStyle())
#endif
#if os(watchOS)
    case .carousel:
      listStyle(CarouselListStyle())
#endif
    case .basic:
      listStyle(DefaultListStyle())
    case .plain:
      listStyle(PlainListStyle())
#if !os(macOS)
    case .grouped:
      listStyle(GroupedListStyle())
    case .insetGrouped:
      listStyle(InsetGroupedListStyle())
#endif
    case .inset:
      listStyle(InsetListStyle())
    case .sidebar:
      listStyle(SidebarListStyle())
    case .custom:
      listStyle(PlainListStyle())
    }
  }
}

struct ApplyStyle<Component: View, Style: ListStyle>: View {
  let style: Style
  let component: Component

  init(_ content: () -> Component, style: Style) {
    self.style = style
    self.component = content()
  }

  var body: some View {
    component
      .listStyle(self.style)
  }
}

struct ListPlayground: View {

  private enum MAULCellControl: String, CaseIterable {
    case none = "default"
    case value
    case badge = "statusBadge"
    case progressView

    func code(_ contentCode: String) -> String {
      return "MAULCell.\(self.rawValue)(\n\(contentCode)\n\t)"
    }
  }

  public enum ListStyles: String, CaseIterable {
#if os(macOS)
    case bordered
#endif
#if os(watchOS)
    case carousel
#endif
    case basic = "default"
#if !os(macOS)
    case grouped
    case insetGrouped
#endif
    case inset
    case plain
    case sidebar
    case custom
  }

  @State private var resource: MAULCellData.MAULCellResource = .initials
  @State private var control: MAULCellControl = .none
  @State private var status: MAULStatus = .positive
  @State private var description = false
  @State private var disabled = false
#if !os(macOS)
  @State private var editMode: EditMode = .inactive
#endif
  @State private var selectedCell: String?
  @State var enabledEditMode: Bool = false
  @State private var listStyle: ListStyles = .custom
  @State private var badgeValue: Int = 1
  @State private var badgeScheme: MAULStatusBadge.Scheme = .warning

  var contentCode: String {
    var code = ""
    switch control {
    case .badge:
      code += "\t\t.init(\n\t\t\tvalue: \(badgeValue),\n\t\t\tstatus: .\(badgeScheme)\n\t\t),\n"
    case .value:
      code += "\t\t\"Value\",\n"
    default:
      break
    }
    code += "\t\ttitle: \(MAULCellData.title)"
    if description {
      code += ",\n\t\tdescription: \(MAULCellData.descriptionTitle)"
    }
    switch resource {
    case .icon : code += ",\n\t\ticon: \(resource.code)"
    case .image: code +=  ",\n\t\timage: \(resource.code)"
    case .initials: code +=  ",\n\t\tinitials: \(resource.code)"
    case .none: break
    case .status: code += ",status: \(resource.code)"
    }

    return code
  }

  @ViewBuilder func buildCell() -> some View {
    let desc = description ? MAULCellData.descriptionTitle : nil

    switch resource {
    case .icon:
      MAULCell.default(
        title: MAULCellData.title,
        description: desc,
        icon: MAULCellData.icon
      )
    case .image:
      MAULCell.default(
        title: MAULCellData.title,
        description: desc,
        image: MAULCellData.image
      )
    case .initials:
      MAULCell.default(
        title: MAULCellData.title,
        description: desc,
        initials: MAULCellData.initials
      )
    case .none :
      MAULCell.default(
        title: MAULCellData.title,
        description: desc
      )
    case .status:
      MAULCell.default(
        title: MAULCellData.title,
        description: desc,
        status: status
      )
    }
  }

  @ViewBuilder func buildCellWrapper() -> some View {
    let cell = buildCell()
    switch control {
    case .none:
      cell
    case .value:
      MAULCell.value("Value") {
        cell
      }
    case .badge:
      MAULCell.statusBadge(.init(value: badgeValue, status: badgeScheme)) {
        cell
      }
    case .progressView:
      MAULCell.progressView {
        cell
      }
    }
  }

  func buildList() -> some View {
    List(selection: $selectedCell) {
      let section = Section(header: MAULSectionHeader(title: "Section header title")) {
        ForEach(0..<2) { _ in
          let cell = buildCellWrapper()
          if listStyle == .custom {
            cell.maulSeparator()
          } else {
            cell
          }
        }
        .onMove { _, _ in
          print("move")
        }
        .onDelete { _ in
          print("delete")
        }
      }
#if os(iOS)
        .listSectionSeparator(.hidden)
#endif
      if disabled {
        section.disabled(true)
      } else {
        section
      }
    }
    .listStyle(listStyle)
#if !os(macOS)
    .environment(\.editMode, $editMode)
    .onChange(of: enabledEditMode) { newValue in
      editMode = newValue ? .active : .inactive
    }
#endif
  }

  func builtText() -> String {
    var code =  """
        List {
            Section(
                header: MAULSectionHeader(
                    title: "Section header title"
                )
            ) {
                \(control.code(contentCode))
            }
        }
        .listStyle(.\(listStyle.rawValue))
        """

    if disabled {
      code += "\n.disabled(true)"
    }
    return code
  }

  var controls: some View {
    Group {
      Toggle(isOn: $description) {
        Text("Description")
      }

      HStack {
        Text("Resource")
        Spacer()
        Picker("", selection: $resource) {
          ForEach(MAULCellData.MAULCellResource.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }

      if resource == .status {
        HStack {
          Text("Status")
          Spacer()
          Picker("Status", selection: $status) {
            ForEach(MAULStatus.allCases, id: \.self) {
              Text($0.rawValue)
            }
          }
        }
      }

      HStack {
        Text("Control")
        Spacer()
        Picker("", selection: $control) {
          ForEach(MAULCellControl.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }

      if control == .badge {
        TextField("Value", value: $badgeValue, formatter: NumberFormatter())
          .withMAULStyle

        HStack {
          Text("Scheme")
          Spacer()
          Picker("", selection: $badgeScheme) {
            ForEach(MAULStatusBadge.Scheme.allCases, id: \.self) {
              Text($0.name)
            }
          }
        }
      }

      Toggle(isOn: $disabled) {
        Text("Disabled")
      }

#if !os(macOS)
      Toggle(isOn: $enabledEditMode) {
        Text("Edit mode")
      }

#endif

      HStack {
        Text("Control")
        Spacer()
        Picker("", selection: $listStyle) {
          ForEach(ListStyles.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }
    }
    .toggleStyle(.maul())
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildList()
    } modalScreen: {
      ListScreen()
    }
    .navigationTitle("List")
  }
}
