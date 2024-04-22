import SwiftUI
import MAUL

struct NumberingPageControlPlayground: View {

  @State private var pageCount = 20
  @State private var currentPage = 1

  @ViewBuilder private func buildComponent() -> some View {
    VStack {
      MAULNumberingPageControl(config: .init(
        pageCount: pageCount,
        currentPage: currentPage)
      )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.MAUL.Text.primary)
  }

  private func builtText() -> String {
    return """
        MAULNumberingPageControl(config: .init(
            numberOfPages: \(pageCount),
            currentPage: \(currentPage))
        )
        """
  }

  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    formatter.decimalSeparator = ""
    formatter.groupingSeparator = ""
    return formatter
  }()

  private var controls: some View {
    Group {
      TextField("Number of pages", value: $pageCount, formatter: numberFormatter)
      TextField("current page", value: $currentPage, formatter: numberFormatter)
    }
    .textFieldStyle(.maul)
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      NumberingPageControlScreen()
    }
    .navigationTitle("Page Control")
  }
}

struct NumberingPageControlPlayground_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NumberingPageControlPlayground()
    }
    .setupMAULForPreviews()
  }
}
