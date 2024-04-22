import MAUL
import SwiftUI

struct MenuScreen: View {

  @State private var toggleSelected = false
  @State private var sort: Int = 0
  @State private var dialogPresented = false

  var body: some View {

    let view = VStack {
      HStack {
        Text("Menu component")
        Spacer()
        // can be used label with icon
        // styles, font, size is ignored
        // roles change style of text - only destructive and cancel
        Menu {
          Section {
            Button(action: {}) {
              Label("Create a file", systemImage: "doc")
            }

            Button(action: {}) {
              Label("Create a folder", systemImage: "folder")
            }
          }

          Section(header: Text("Secondary actions")) {
#if os(iOS)
            Button("cancel", role: .cancel) {}
            Button("delete", role: .destructive) {}
#else
            Button("cansel") {}
            Button("delete") {}
#endif
            Button(action: {}) {
              Label("Remove old files", systemImage: "trash")
            }
          }
        }
      label: {
        Label("Add", systemImage: "plus")
      }
      }
      HStack {
        Text("Context menu")
        Spacer()
        Button("Menu - long tap") {

        }
        .contextMenu {
          Button(
            action: {
              print("Change country setting")
            }, label: {
              MAULStatusLabel(title: "Label", status: .positive)
            }
          )

          Button("Country", action: {})
            .font(.MAUL.black(ofSize: 40))
        }
      }

#if os(iOS)
      HStack {
        Text("Picker as menu")
        Spacer()
        // styles, font, size is ignored
        Picker(selection: $sort, label: Text("Sorting options")) {
          Text("Size").tag(0)
          Text("Date").tag(1)
          Text("Location").tag(2)
        }
        .pickerStyle(.menu)
        .accentColor(Color.MAUL.Brand.primary)
      }
#endif
    }
    VStack {
      view.padding().environment(\.colorScheme, .light).background(Color.white)
      view.padding().environment(\.colorScheme, .dark).background(Color.black)
    }.navigationTitle("Menu")
  }
}

struct MenuScreen_Previews: PreviewProvider {
  static var previews: some View {
    MenuScreen()
      .setupMAULForPreviews()
  }
}
