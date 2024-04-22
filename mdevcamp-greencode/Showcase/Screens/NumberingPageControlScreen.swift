import SwiftUI
import MAUL

struct NumberingPageControlScreen: View {

  var body: some View {

    let view = VStack {
      MAULNumberingPageControl(config: .init(
        pageCount: 20,
        currentPage: 1)
      )
      MAULNumberingPageControl(config: .init(
        pageCount: 9,
        currentPage: 1)
      )
      MAULNumberingPageControl(config: .init(
        pageCount: 99,
        currentPage: 99)
      )
      MAULNumberingPageControl(config: .init(
        pageCount: 20,
        currentPage: 12)
      )
    }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.MAUL.Text.primary)

    VStack {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct NumberingPageControlScreen_Previews: PreviewProvider {
  static var previews: some View {
    NumberingPageControlScreen()
      .setupMAULForPreviews()
  }
}
