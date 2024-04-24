import MAUL
import SwiftUI

@main
struct mdevcamp_greencodeApp: App {
  init() {
      MAULGlobalAppearance.setup()
  }

  var body: some Scene {
    WindowGroup {
      MainView()
    }
  }
}
