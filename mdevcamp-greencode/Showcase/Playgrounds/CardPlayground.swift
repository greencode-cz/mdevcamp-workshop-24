import SwiftUI
import MAUL

struct CardPlayground: View {

  @State private var isSelected = false

  @ViewBuilder func buildCard() -> some View {
    GroupBox {
      // custom content
      Text("custom content")
    }
    .groupBoxStyle(.maulCard(isSelected: isSelected))
  }

  func builtText() -> String {
    return """
        GroupBox {
            Text("custom content")
        }
        .groupBoxStyle(.maulCard(selected: \(isSelected ? "true" : "false")))
        """
  }
  
  var controls: some View {
    Toggle("Selected", isOn: $isSelected)
      .toggleStyle(.maul())
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildCard()
    } modalScreen: {
      CardScreen()
    }
    .navigationTitle("Card")
  }
}

struct CardPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CardPlayground()
    }
    .setupMAULForPreviews()
  }
}
