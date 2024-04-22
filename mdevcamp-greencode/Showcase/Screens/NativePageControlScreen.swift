import SwiftUI
import MAUL

#if os(iOS)
struct NativePageControlScreen: View {

  var body: some View {
    let tab = TabView {
      ZStack {
        Color.MAUL.Background.primary
        Text("Page 1")
      }
      ZStack {
        Color.MAUL.Background.primary
        Text("Page 2")
      }
      ZStack {
        Color.MAUL.Background.primary
        Text("Page 3")
      }
      ZStack {
        Color.MAUL.Background.primary
        Text("Page 4")
      }
      ZStack {
        Color.MAUL.Background.primary
        Text("Page 5")
      }
    }
      .tabViewStyle(.page)
    VStack {
      tab.environment(\.colorScheme, .light)
      tab.environment(\.colorScheme, .dark)
    }
  }
}

struct NativePageControlScreen_Previews: PreviewProvider {
  static var previews: some View {
    NativePageControlScreen()
  }
}
#endif
