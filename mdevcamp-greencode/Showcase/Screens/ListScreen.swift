import SwiftUI
import MAUL

struct ListScreen: View {

  var body: some View {
    let title = "List item Title"
    let desc = "List item explanation\nList item explanation\nList item explanation\n"
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

    let sections = Group {
      Section(header: MAULSectionHeader(title: "Default")) {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(cells.indices, id: \.self) { index in
            cells[index]
            if index != cells.count - 1 {
              Divider().withMAULStyle
            }
          }
#if os(iOS)
          .listRowSeparator(.hidden)
#endif
        }
      }
      Section(header: MAULSectionHeader(title: "Value")) {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(cells.indices, id: \.self) { index in
            MAULCell.value("Value") {
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
      Section(header: MAULSectionHeader(title: "Badge")) {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(cells.indices, id: \.self) { index in
            MAULCell.statusBadge(.init(value: 1, status: .warning)) {
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
      Section(header: MAULSectionHeader(title: "Progress View")) {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(cells.indices, id: \.self) { index in
            MAULCell.progressView {
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
    }

    let list = List {
      sections
      sections.disabled(true)
    }
#if os(macOS)
      .frame(minWidth: 400, minHeight: 400, alignment: .center)
#endif
      .background(Color.MAUL.Background.primary)

    VStack {
      list.environment(\.colorScheme, .light)
      list.environment(\.colorScheme, .dark)
    }
  }
}

struct ListScreen_Previews: PreviewProvider {
  static var previews: some View {
    ListScreen()
      .setupMAULForPreviews()
  }
}
