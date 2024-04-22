import SwiftUI
import MAUL

struct ProgressComponent: View {
  @ObservedObject private var model: ProgressViewModel

  public init(model: ProgressViewModel) {
    self.model = model
  }

  @ViewBuilder var body: some View {
    let progress = ProgressView(value: model.value, total: 100)
      .padding()
    let indetermineProgress = ProgressView().padding()
    switch model.style {
    case .linear :
      switch model.kind {
      case .determinate:
        progress.progressViewStyle(.maulLinear)
      case .indeterminate:
        indetermineProgress.progressViewStyle(.maulLinear)
      }
    case .circular :
      switch model.kind {
      case .determinate:
        progress.progressViewStyle(model.size == .large ? .maulCircularLarge : .maulCircularSmall)
      case .indeterminate:
        indetermineProgress.progressViewStyle(MAULCircularProgressViewStyle(model.size == .large ? .large : .small))
      }
    }
  }
}

class ProgressViewModel: ObservableObject {
  @Published var value = 33.0
  @Published var kind: Kind = .determinate
  @Published var style: Style = .linear
  @Published var size: Size = .large

  public enum Kind: String, CaseIterable {
    case indeterminate = "Indeterminate"
    case determinate = "Determinate"
  }

  public enum Style: String, CaseIterable {
    case linear = "Linear"
    case circular = "Circular"
  }

  public enum Size {
    case large
    case small
  }
}

struct ProgressViewPlayground: View {

  @ObservedObject var model = ProgressViewModel()

  @FocusState private var isFocused

  func builtText() -> String {
    let initValues =  model.kind == .determinate ? "value: value, total: 100" : ""
    var code = "ProgressView(\(initValues))"
    switch model.style {
    case .linear :
      code.append("\n\t.progressViewStyle(.maulLinear)")
    case .circular :
      code.append("\n\t.progressViewStyle(\(model.size == .large ? ".maulCircularLarge" : ".maulCircularSmall"))")
    }
    if model.kind == .indeterminate {
      code += """

        OR
        // Use 3rd party library - Lottie
        /// - View documentation, FAQ, help, examples, and more at [airbnb.io/lottie](http://airbnb.io/lottie/)

        // Animation JSON files are available at the following URLs:

        URL.MAUL.Lottie.circleLargeProgressAnimationDark
        URL.MAUL.Lottie.circleLargeProgressAnimationLight
        URL.MAUL.Lottie.circleSmallProgressAnimationDark
        URL.MAUL.Lottie.circleSmallProgressAnimationLight
        URL.MAUL.Lottie.linearProgressAnimationDark
        URL.MAUL.Lottie.linearProgressAnimationLight
        """
    }

    return code
  }

  private let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimum = 0
    formatter.maximum = 100
    return formatter
  }()

  var controls: some View {
    Group {
      Picker("Type", selection: $model.kind) {
        ForEach(ProgressViewModel.Kind.allCases, id: \.self) {
          Text($0.rawValue)
        }
      }.pickerStyle(.segmented)
      Picker("", selection: $model.style) {
        ForEach(ProgressViewModel.Style.allCases, id: \.self) {
          Text($0.rawValue)
        }
      }.pickerStyle(.segmented)

      if model.style == .circular {
        Picker("", selection: $model.size) {
          Text("Large").tag(ProgressViewModel.Size.large)
          Text("Small").tag(ProgressViewModel.Size.small)
        }.pickerStyle(.segmented)
      }
      if model.kind == .determinate {
        Divider().withMAULStyle
        VStack {
          TextField("Value input", value: $model.value, formatter: numberFormatter)
            .withMAULStyle
            .focused($isFocused)

          Slider(value: $model.value, in: 0...100, onEditingChanged: { _ in
            isFocused = false
          })
          .modifier(MAULStyle())

        }
      }
    }
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      ProgressComponent(model: model)
    } modalScreen: {
      ProgressViewScreen()
    }
    .navigationTitle("Progress View")
  }
}

struct ProgressViewPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ProgressViewPlayground()
    }
    .setupMAULForPreviews()
  }
}
