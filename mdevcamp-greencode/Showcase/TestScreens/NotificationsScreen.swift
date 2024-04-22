import SwiftUI
import MAUL

struct NotificationMessageRow: View {
  var data: NotificationMessage

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack(spacing: 0) {
        Image(data.imageName)
          .resizable()
          .frame(width: 64, height: 64)
          .background(Color.MAUL.Surface.primary)
          .cornerRadius(4)
          .clipped()

        Spacer()
          .frame(width: 8)

        VStack(alignment: .leading, spacing: 0) {
          Text(data.title)
            .font(.MAUL.regular(ofSize: 16))
            .frame(height: 24)

          Spacer().frame(height: 4)

          Text(data.description)
            .font(.MAUL.regular(ofSize: 14))
            .lineSpacing(4)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .truncationMode(.tail)
        }
        .frame(height: 68)
      }
      HStack(spacing: 0) {
        Spacer().frame(width: 64)
        Spacer().frame(width: 8)
        Text(data.timeCreated)
          .font(.MAUL.regular(ofSize: 12))
          .frame(height: 14, alignment: .leading)
          .padding(.vertical, 4)
        Spacer()
      }
    }
    .padding(.vertical, 8)
    .font(.MAUL.regular())
    .foregroundColor(Color.MAUL.Text.secondary)
  }
}

struct NotificationMessage: Hashable, Codable, Identifiable {
  var id = UUID()
  var title: String
  var timeCreated: String
  var description: String
  var imageName: String
}

struct NotificationsScreen: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @State private var selectedPickerValue = "Activity"
  private var pickerOptions = [
    Ocean(name: "Activity"),
    Ocean(name: "Messages")
  ]

  @State private var selectedMessage: NotificationMessage?

  private var notificationMessages = [
    NotificationMessage(title: "Get a free cheeseburger", timeCreated: "1 hour ago", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent facilisis diam eu ipsum eleifend, vel pharetra felis sollicitudin. Nulla id justo purus. Nullam massa tellus, lacinia nec nisl quis, ultricies rutrum dolor. Integer eu metus est. Praesent laoreet tempor neque id commodo.", imageName: "burger"),
    NotificationMessage(title: "Get a free cheeseburger", timeCreated: "1 hour ago", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent facilisis diam eu ipsum eleifend, vel pharetra felis sollicitudin. Nulla id justo purus. Nullam massa tellus, lacinia nec nisl quis, ultricies rutrum dolor. Integer eu metus est. Praesent laoreet tempor neque id commodo.", imageName: "burger"),
    NotificationMessage(title: "Get a free cheeseburger", timeCreated: "1 hour ago", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent facilisis diam eu ipsum eleifend, vel pharetra felis sollicitudin. Nulla id justo purus. Nullam massa tellus, lacinia nec nisl quis, ultricies rutrum dolor. Integer eu metus est. Praesent laoreet tempor neque id commodo.", imageName: "burger")
  ]

  var body: some View {
    // Instead of List use ScrollView and VStack with Divider, navigation link in list add icon on right side
    ScrollView {
      Picker(selection: $selectedPickerValue, label: EmptyView()) {
        ForEach(pickerOptions, id: \.self.name) {
          Text($0.name)
        }
      }
      .segmentedWithMAULStyle

      VStack {
        ForEach(notificationMessages) { item in
          NavigationLink(destination: Text("Detail")) {
            NotificationMessageRow(data: item)
          }
          // do not style navigation link -> set plain button style
          .buttonStyle(PlainButtonStyle())
          Divider().withMAULStyle
        }
      }
    }.padding(.horizontal, 16)
      .navigationTitle("Notifications")
#if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Image(systemName: "ellipsis")
        }
      }
#endif
  }
}
