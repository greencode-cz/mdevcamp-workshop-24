import SwiftUI
import MAUL

struct FormScreen: View {
  @State private var toggleSelected = false
  @State private var selectedItem: String?
  @State private var text: String = "Text"
  @State private var selected = "Item1"
  @State private var value = 0

  var body: some View {
    let title = "List item Title"
    let desc = "List item explanation\nList item explanation\nList item explanation"
    // TODO: Fix layout of cells for Mac
#if os(iOS)
    let defaultCells: [Any] = [
      MAULCell.default(
        title: title
      ),
      MAULCell.default(
        title: title,
        description: desc
      ),
      MAULCell.default(
        title: title,
        icon: Image.MAUL.fileFile
      ),
      MAULCell.default(
        title: title,
        description: desc,
        icon: Image.MAUL.fileFile
      ),
      MAULCell.default(
        title: title,
        description: desc,
        image: Image("avatar", bundle: Bundle.main)
      ),
      MAULCell.default(
        title: title,
        description: desc,
        initials: "WW"
      ),
      MAULCell.default(
        title: title,
        description: desc,
        status: .positive
      ),
      MAULCell.default(
        title: title,
        description: desc,
        status: .alert
      ),
      MAULCell.default(
        title: title,
        description: desc,
        status: .warning
      )
    ]
    let cells = defaultCells.map(AnyView.init)
#else
    let cells = [EmptyView()]
#endif

    let sections = Group {
      Section(header: MAULSectionHeader(title: "Toggle")) {
        VStack(alignment: .leading) {
          ForEach(cells.indices, id: \.self) { index in
            Toggle(isOn: $toggleSelected) {
              cells[index]
            }
            .toggleStyle(.maul())
            if index != cells.count - 1 {
              Divider().withMAULStyle
            }
          }
#if os(iOS)
          .listRowSeparator(.hidden)
#endif
        }
      }
      Section(header: MAULSectionHeader(title: "Checkmark")) {
        VStack(alignment: .leading) {
          ForEach(cells.indices, id: \.self) { index in
            MAULCell.checkmark(isSelected: $toggleSelected) {
              cells[index]
            }

            if index != cells.count - 1 {
              Divider().withMAULStyle
            }
          }
#if os(iOS)
          .listRowSeparator(.hidden)
#endif
        }
      }
      Section(header: MAULSectionHeader(title: "Checkbox")) {
        VStack(alignment: .leading) {
          ForEach(cells.indices, id: \.self) { index in
            Toggle(isOn: $toggleSelected) {
              cells[index]
            }.toggleStyle(.maulCheckbox(labelAlignment: .leading))

            if index != cells.count - 1 {
              Divider().withMAULStyle
            }
          }
#if os(iOS)
          .listRowSeparator(.hidden)
#endif
        }
      }
      Section(header: MAULSectionHeader(title: "Radio")) {
        VStack(alignment: .leading) {
          ForEach(cells.indices, id: \.self) { index in
            Toggle(isOn: $toggleSelected) {
              cells[index]
            }.toggleStyle(.maulRadioButton(labelAlignment: .leading, radioButtonAlignment: .center))
            if index != cells.count - 1 {
              Divider().withMAULStyle
            }
          }
#if os(iOS)
          .listRowSeparator(.hidden)
#endif
        }
      }
      Section(header: MAULSectionHeader(title: "Picker")) {
        VStack(alignment: .leading) {
          ForEach(cells.indices, id: \.self) { index in
            Picker(selection: $selected,
                   label: cells[index]) {
              Text("Item1").tag("Item1")
              Text("Item2").tag("Item2")
              Text("Item3").tag("Item3")
            }
            if index != cells.count - 1 {
              Divider().withMAULStyle
            }
          }
#if os(iOS)
          .listRowSeparator(.hidden)
#endif
        }
      }
      Section(header: MAULSectionHeader(title: "Selectable Value")) {
        VStack(alignment: .leading) {
          ForEach(cells.indices, id: \.self) { index in
            MAULCell.selectableValue(.init(value: "Value", icon: Image.MAUL.check)) {
              cells[index]
            }
            if index != cells.count - 1 {
              Divider().withMAULStyle
            }
          }
#if os(iOS)
          .listRowSeparator(.hidden)
#endif
        }
      }
      Section(header: MAULSectionHeader(title: "Other inputs")) {
        VStack(alignment: .leading) {
          TextField("Text", text: $text)
            .withMAULStyle
          Divider()
            .withMAULStyle
          SecureField("Secure text", text: $text)
            .withMAULStyle
          Divider()
            .withMAULStyle
          TextEditor(text: $text)
            .withMAULStyle
          Divider()
            .withMAULStyle
          Stepper(value: $value, in: 0...50, step: 5) {
            Text("Value \(value) in range 0-50 and step 5")
              .font(.MAUL.regular())
          }
          Divider()
            .withMAULStyle
          Button("Button") {
            // code
          }
          .buttonStyle(.maulPrimary(layout: .standard))
        }
      }
    }

    let form = Form {
      sections
      sections.disabled(true)
    }
      .background(Color.MAUL.Background.primary)

#if os(macOS)
    // form on macos does not have scroll
    ScrollView {
      form.environment(\.colorScheme, .light)
      form.environment(\.colorScheme, .dark)
    }
#else
    form.environment(\.colorScheme, .light)
    form.environment(\.colorScheme, .dark)
#endif
  }
}

struct FormScreen_Previews: PreviewProvider {
  static var previews: some View {
    FormScreen()
      .setupMAULForPreviews()
  }
}
