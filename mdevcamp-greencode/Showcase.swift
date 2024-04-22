import MAUL
import SwiftUI

struct Showcase: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink {
          List {
            Screen("Color", content: ColorScreen())
            Screen("Elevation", content: ElevationScreen())
            Screen("Typography", content: TypographyScreen())
            Screen("Spaces", content: SpacesScreen())
            Screen("Icons", content: IconsScreen())
            Screen("Multicolour icons", content: MultiColourIconsScreen())
            Screen("Logos", content: LogosScreen())
          }
          .listStyle(.plain)
          .navigationTitle("Visual")
        } label: {
          Image(systemName: "eye")
          Text("Visual")
        }
        NavigationLink {
          List {
            Section("Buttons") {
              Screen("Button", "A control that initiates an action.", content: ButtonPlayground())
              Screen("Chip", "Button styled control that toggles between on and off states", content: ChipPlayground())
              Screen("Menu", "A control for presenting a menu of actions.", content: MenuScreen())
              Screen("SegmentedControl", "A horizontal control that consists of multiple segments, each segment functioning as a discrete button.", content: SegmentedControlScreen())
            }
            Section(header: Text("Box views and dialogs")) {
              Screen("Banner", "A banner displays an important, succinct message", content: BannerPlayground())
              Screen("Bottom Sheet", "Presents a sheet", content: SheetPlayground())
              Screen("Card", "An actionable containers that help organise content", content: CardPlayground())
              Screen("Dialog", "Dialogs inform users about a task and can contain critical information, require decisions, or involve multiple tasks.", content: DialogPlayground())
              Screen("Label", "Labels are textual non-interactive UI elements. They are used as a visual way to organise and categorise items in a descriptive way", content: LabelPlayground())
              Screen("SnackBar", "Snackbars provide brief messages about app processes at the bottom of the screen.", content: SnackbarPlayground())
              Screen("Form", "A container for grouping controls used for data entry, such as in settings or inspectors.", content: FormPlayground())
              Screen("List", "A container that presents rows of data arranged in a single column, optionally providing the ability to select one or more members.", content: ListPlayground())
              Screen("Avatar", "Avatar display circular image or initials text of specified size", content: AvatarPlayground())
            }

            Section("Indicators") {
              Screen("Badge", "A small indicator used to communicate a numerical value and status", content: BadgePlayground())
              Screen("Status", "A small circle indicator showing the status", content: StatusPlayground())
              Screen("Progress View", "A view that shows the progress towards completion of a task.", content: ProgressViewPlayground())
              Screen("Numbering Page Control", "A view that shows the numbering page control", content: NumberingPageControlPlayground())
              Screen("Native Page Control", "A view that shows the native indicator page control.", content: NativePageControlScreen())
              Screen("Timestamp Page Control", "A view that shows the timestamp page control", content: TimestampPageControlPlayground())
            }
            Section("Pickers") {
              Screen("DatePicker", "A control for selecting an absolute date.", content: DatePickerScreen())
              Screen("Checkbox", "Checkboxes are input controls that allow users to select any number of items on a list, whether it’s none, one, or multiple.", content: CheckboxPlayground())
              Screen("ColorPicker", "A control used to select a color from the system color picker UI.", content: ColorPickerScreen())
              Screen("Picker", "A control for selecting from a set of mutually exclusive values.", content: PickerPlayground())
              Screen("RadioButton", "Radiobuttons are input controls that allow users to select only one item from group.", content: RadioGroupPlayground())
            }
            Section("Text Entry") {
              Screen("Custom SearchField", "Displays an interactive text field used to search for content.", content: SearchFieldPlayground())
              Screen("TextField", "A control that displays an editable text interface.", content: TextFieldPlayground())
              Screen("SecureField", "A control into which the user securely enters private text.", content: SecureFieldPlayground())
              // TextEditor in Figma as text area component
              Screen("TextEditor", "A view that can display and edit long-form text.", content: TextEditorPlayground())
            }
            Section("Value Inputs") {
              Screen("Slider", "A control for selecting a value from a bounded linear range of values.", content: SliderPlayground())
              Screen("Stepper", "A control that performs increment and decrement actions.", content: StepperPlayground())
              Screen("Toggle", "A control that toggles between on and off states.", content: ToggleSwitchPlayground())
            }
            Section("Map") {
              Screen("Map pin", "A view that show marker in map", content: MapPinPlayground())
            }
          }
          .listStyle(.plain)
          .navigationTitle("Components")
        } label: {
          Image(systemName: "uiwindow.split.2x1")
          Text("Components")
        }
        NavigationLink {
          List {
            Screen("Home screen", content: HomeScreen())
            Screen("Notification screen", content: NotificationsScreen())
            Screen("Defect Detail screen", content: DefectDetailScreen())
            Screen("Sheet screen", content: SheetNavigationScreen())
            Screen("Accessibility screen", content: AccessibilityScreen())
              .accessibilityIdentifier("accesibility_screen_nav_button")
          }
          .listStyle(.plain)
          .navigationTitle("Screens")
        } label: {
          Image(systemName: "display")
          Text("Screens")
        }
        .accessibilityIdentifier("screens_navigation_button")
      }
      .listStyle(.plain)
      .navigationTitle("MAUL")
    }
    .withMAULStyle
    // Fix constraints error from set navigationTitle
    .navigationViewStyle(.stack)
  }
}

#Preview {
  Showcase()
    .setupMAULForPreviews()
}
