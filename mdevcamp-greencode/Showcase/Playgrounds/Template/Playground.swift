import SwiftUI
import MapKit

struct PlaygroundGroupBoxStyle: GroupBoxStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct Playground<Content: View>: View {

  var content: Content

  init(content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    GroupBox(label: EmptyView(), content: {
      content
    })
    .groupBoxStyle(PlaygroundGroupBoxStyle())
  }
}

struct PlaygroundScreen<ControlPanel: View, Component: View, ModalScreen: View>: View {
  var code: String
  var controlPanel: ControlPanel
  var component: Component
  var modalScreen: ModalScreen?

  @State private var showingSheet = false
  @State var sliderControlViewModel: SliderControlViewModel = SliderControlViewModel()
  @State var componentAppearance: ColorScheme = .light

  init(code: String, controlPanel: () -> ControlPanel, component: () -> Component, @ViewBuilder modalScreen: @escaping () -> ModalScreen) {
    self.code = code
    self.controlPanel = controlPanel()
    self.component = component()
    self.modalScreen = modalScreen()
  }

  var body: some View {
    SplitView(
      viewModel: sliderControlViewModel,
      topView: {
        ScrollView {
          Group {
            Picker("Appearance", selection: $componentAppearance) {
              Text("Light").tag(ColorScheme.light)
              Text("Dark").tag(ColorScheme.dark)
            }
            .pickerStyle(.segmented)

            Divider().withMAULStyle

            controlPanel

            Divider().withMAULStyle

            VStack(alignment: .leading) {
              Text("Code:")
              Text(code)
                .textSelection(.enabled)
                .padding()
                .border(Color.MAUL.Text.primary, width: 1.0)
            }
          }
          .padding(.MAUL.S)
        }
        .background(Color.MAUL.Background.primary)
      },
      bottomView: {
        Playground {
          component
        }
        .background(Color.MAUL.Background.primary)
        .environment(\.colorScheme, componentAppearance)
      }
    )
    .toolbar {
      if let modalView = modalScreen {
        Button("Info") {
          showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
          VStack {
            HStack {
              Spacer()
              Button {
                showingSheet.toggle()
              } label: {
                Image(systemName: "xmark")
              }
              .padding(.all, .MAUL.XS)
            }
            modalView.padding(.all, .MAUL.S)
          }
        }
      }
    }
  }
}
