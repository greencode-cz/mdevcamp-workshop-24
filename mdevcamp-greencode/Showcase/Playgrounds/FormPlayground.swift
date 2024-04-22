import SwiftUI
import MAUL
import BottomSheet

struct MAULCellData {
  enum MAULCellResource: String, CaseIterable {
    case none
    case icon
    case image
    case initials
    case status

    var code: String {
      switch self {
      case .icon:  return "Image.MAUL.fileFile"
      case .image:  return "Image(\"avatar\")"
      case .initials:  return "\"WW\""
      case .none:   return ""
      case .status: return "positive"
      }
    }
  }

  static let descriptionTitle: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur suscipit mi vitae enim tristique, sed sollicitudin orci accumsan."
  static let title: String = "Lorem Ipsum"
  static let icon: Image = Image.MAUL.fileFile
  static let image: Image = Image("avatar")
  static let initials: String = "WW"
}

struct FormPlayground: View {

  private enum MAULCellControl: String, CaseIterable {
    case toggle
    case checkmark
    case picker
    case radio = "radioButton"
    case checkbox
    case selectableValue

    func code(_ contentCode: String) -> String {
      return "MAULCell.\(self.rawValue)(\(contentCode)\n\t)"
    }
  }

  @State private var resource: MAULCellData.MAULCellResource = .none
  @State private var control: MAULCellControl = .toggle
  @State private var status: MAULStatus = .positive
  @State private var description = false
  @State private var disabled = false
  @State private var selected = false
  @State private var selectedItem = 1

  private let values = ["Value 1", "Value 2", "Value 3"]
  @State private var selectedValue = "Value 1"
  @State var bottomSheetPosition: BottomSheetPosition = .hidden

  private var contentCode: String {
    var code = ""

    if control == .picker {
      code += "\n\t\tselection: $selectedItem,"
    }

    if control == .checkbox || control == .checkmark || control == .toggle || control == .radio {
      code += "\n\t\tisSelected: $isSelected,"
    }

    if control == .selectableValue {
      code += "\n\t\t.init(\n\t\t\tvalue: selectedValue,\n\t\t\ticon: Image.MAUL.chevronUp\n\t\t),"
    }

    code += "\n\t\ttitle: \"\(MAULCellData.title)\""

    if description {
      code += ",\n\t\tdescription: \"\(MAULCellData.descriptionTitle)\""
    }

    switch resource {
    case .icon : code += ",\n\t\ticon: \(resource.code)"
    case .image: code +=  ",\n\t\timage: \(resource.code)"
    case .initials: code +=  ",\n\t\tinitials: \(resource.code)"
    case .none: break
    case .status: code += ",\n\t\tstatus: \(resource.code)"
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
    case .none:
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
    // There is no MAULCell wrapper used as in example code view to simplify component generation
    let cell = buildCell()
    switch control {
    case .checkmark:
      MAULCell.checkmark(isSelected: $selected) {
        cell
      }
    case .picker:
      Picker(selection: $selectedItem,
             label: cell) {
        Text("Item 1").tag(1)
        Text("Item 2").tag(2)
        Text("Item 3").tag(3)
      }
    case .toggle:
      Toggle(isOn: $selected) {
        cell
      }.toggleStyle(.maul())
    case .radio:
      Toggle(isOn: $selected) {
        cell
      }.toggleStyle(.maulRadioButton(labelAlignment: .leading, radioButtonAlignment: .center))
    case .checkbox:
      Toggle(isOn: $selected) {
        cell
      }.toggleStyle(.maulCheckbox(labelAlignment: .leading))
    case .selectableValue:
      MAULCell.selectableValue(.init(value: selectedValue, icon: Image.MAUL.chevronRight)) {
        cell
      }
      .onTapGesture {
        bottomSheetPosition = .middle
      }
    }
  }

  func buildForm() -> some View {
    Form {
      let section = Section(header: MAULSectionHeader(title: "Section header title")) {
        VStack(alignment: .leading, spacing: 0) {
          buildCellWrapper()
#if os(iOS)
            .listRowSeparator(.hidden)
#endif
          Divider().withMAULStyle
          buildCellWrapper()
#if os(iOS)
            .listRowSeparator(.hidden)
#endif
        }
      }
      if disabled {
        section.disabled(true)
      } else {
        section
      }
    }
  }

  func builtText() -> String {
    return """
        Form {
            Section(
                header: MAULSectionHeader(
                    title: "Section header title"
                )
            ) {
                \(control.code(contentCode))
            }
        }
        """
  }

  var controls: some View {
    Group {
      Toggle(isOn: $description) {
        Text("Description")
      }
      .toggleStyle(.maul())

      HStack {
        Text("Resource")
        Spacer()
        Picker("Resource", selection: $resource) {
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
        Picker("Control", selection: $control) {
          ForEach(MAULCellControl.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }

      Toggle(isOn: $disabled) {
        Text("Disabled")
      }
      .toggleStyle(.maul())

      if [.checkmark, .toggle, .radio, .checkbox].contains(control) {
        Toggle(isOn: $selected) {
          Text("Selected")
        }
        .toggleStyle(.maul())
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildForm()
    } modalScreen: {
      FormScreen()
    }
#if os(iOS)
    .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                 options: [],
                 title: "Title",
                 content: {

      List(values, id: \.self) { name in
        Text(name).onTapGesture {
          selectedValue = name
          bottomSheetPosition = .hidden
        }
      }
    })
#endif
    .navigationTitle("Form")
  }
}

struct FormPlayground_Previews: PreviewProvider {
  static var previews: some View {
    FormPlayground()
      .setupMAULForPreviews()
  }
}
