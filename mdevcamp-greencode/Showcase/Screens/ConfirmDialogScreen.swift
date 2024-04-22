import SwiftUI
import MAUL

struct ConfirmDialogScreen: View {

  @State private var isShowingInfo = false
  @State private var isShowingDestructive = false

  var body: some View {
    VStack(spacing: .MAUL.M) {
      Text("To apply color scheme changes, change scheme in mobile settings")
      Button("Information") {
        isShowingInfo = true
      }
      .buttonStyle(.maulPrimary(layout: .standard))
      .confirmationDialog(
        "Information dialog",
        isPresented: $isShowingInfo
      ) {
        // empty to show only info with button OK
      } message: {
        Text("Information dialog").maulFontStyle(.h1)
      }

      Button("Empty Trash") {
        isShowingDestructive = true
      }
      .buttonStyle(.maulPrimary(layout: .standard))
      .confirmationDialog(
        "Permanently erase the items in the Trash?",
        isPresented: $isShowingDestructive
      ) {
        Button("Empty Trash", role: .destructive) {
          isShowingDestructive = false
        }
      } message: {
        Text("You cannot undo this action.")
      }
      Spacer()
    }
    .background(Color.MAUL.Background.primary)
  }
}

struct SheetScreen_Previews: PreviewProvider {
  static var previews: some View {
    ConfirmDialogScreen()
      .setupMAULForPreviews()
  }
}
