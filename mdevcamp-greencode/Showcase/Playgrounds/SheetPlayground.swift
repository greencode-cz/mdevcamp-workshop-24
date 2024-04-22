import SwiftUI
import MAUL
import BottomSheet

struct SheetPlayground: View {

  enum SheetType: String, CaseIterable {
    case sheet = "Sheet"
    case bottomSheet = "Bottom Sheet"
  }

  @State var sheetType: SheetType = .bottomSheet
  @State var isPresented: Bool = false
  @State var bottomSheetPosition: BottomSheetPosition = .hidden

  @State var showCloseButton = false
  @State var swipeToDismiss = false
  @State var tapToDismiss = false
  @State var shadow = false
  @State var noDragIndicator = false
  @State var backgroundBlur = false

  private var sheetContent: some View {
    Rectangle()
      .fill(Color.MAUL.Background.secondary)
      .frame(width: 200, height: 200)
      .overlay(
        Button("dismiss") {
          isPresented = false
          bottomSheetPosition = .hidden
        }
      )
  }

  @ViewBuilder func buildComponent() -> some View {
    let button = Button("present sheet") {
      isPresented.toggle()
      if bottomSheetPosition != .hidden {
        bottomSheetPosition = .hidden
      } else {
        bottomSheetPosition = .middle
      }
    }
      .buttonStyle(.maulPrimary(layout: .standard))

    VStack {
      switch sheetType {
      case .bottomSheet:
#if os(iOS)
        button
#else
        Text("Not available for Mac")
#endif
      case .sheet:
        button.sheet(isPresented: $isPresented) {
          sheetContent
        }
      }
    }
  }

  // swiftlint:disable function_body_length
  func buildCode() -> String {
    let buttonAction =
    sheetType == .sheet
    ? "isPresented.toggle()"
    :   """
                    if bottomSheetPosition != .hidden {
                        bottomSheetPosition = .hidden
                    } else {
                        bottomSheetPosition = .middle
                    }
                    """

    let buttonDismissAction =
    sheetType == .sheet
    ? " isPresented = false"
    : "bottomSheetPosition = .hidden"

    let button = """
        Button("present sheet") {
            \(buttonAction)
        }
        """
    let content = """
        // Custom content
            Rectangle()
                .fill(Color.MAUL.Background.secondary)
                .overlay(
                    Button("dismiss") {
                        \(buttonDismissAction)
                    }
                )
        """
    switch sheetType {
    case .bottomSheet:
      return """
            Screen {
                //screen content
            }
            .bottomSheet(bottomSheetPosition: $position, content: {
                \(content)
            }
            """
    case .sheet:
      return """
            \(button)
            .sheet(isPresented: $isPresented) {
                \(content)
            }
            """
    }
  }

  var controls: some View {

    // SwiftUI Picker problem after dismissing .fullScreenCover or .sheet
    // Look here for more info:
    // https://stackoverflow.com/questions/69697944/swiftui-picker-problem-after-dismissing-fullscreencover-or-sheet
    VStack {
      Text("To apply color scheme changes on sheet, change scheme in mobile settings")
      HStack {
        Text("Type")
        Spacer()
        Picker("", selection: $sheetType) {
          ForEach(SheetType.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }.pickerStyle(for: .menu)
      }

      if sheetType == .bottomSheet {
        Toggle("Swipe to dismiss", isOn: $swipeToDismiss)
          .toggleStyle(.maul())
        Toggle("Tap to dismiss", isOn: $tapToDismiss)
          .toggleStyle(.maul())
        Toggle("Show close button", isOn: $showCloseButton)
          .toggleStyle(.maul())
        Toggle("Shadow", isOn: $shadow)
          .toggleStyle(.maul())
        Toggle("No drag indicator", isOn: $noDragIndicator)
          .toggleStyle(.maul())
        Toggle("background blur/disable background", isOn: $backgroundBlur)
          .toggleStyle(.maul())
      }
    }
  }

#if os(iOS)
  var bottomSheetOptions: [BottomSheet.Options] {
    var options: [BottomSheet.Options] = []
    if swipeToDismiss {
      options.append(.swipeToDismiss)
    }
    if tapToDismiss {
      options.append(.tapToDissmiss)
    }
    if showCloseButton {
      options.append(.showCloseButton(action: {
        bottomSheetPosition = .hidden
      }))
    }
    if shadow {
      options.append(.shadow(color: Color.black, radius: 4, x: 2, y: 3))
    }
    if noDragIndicator {
      options.append(.noDragIndicator)
    }
    if backgroundBlur {
      options.append(.backgroundBlur(effect: .dark))
    } else {
      options.append(.background(
        AnyView(Color.MAUL.Background.secondary)
      ))
    }
    return options
  }
#endif

  var body: some View {
    let playground = PlaygroundScreen(code: buildCode()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      EmptyView()
    }
      .navigationTitle("Bottom Sheet")

    if sheetType == .bottomSheet {
      playground
#if os(iOS)
        .bottomSheet(
          bottomSheetPosition: $bottomSheetPosition,
          options: bottomSheetOptions,
          title: "Title",
          content: { sheetContent }
        )
#endif
    } else {
      playground
    }
  }
}

struct SheetPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SheetPlayground()
    }
    .setupMAULForPreviews()
  }
}
