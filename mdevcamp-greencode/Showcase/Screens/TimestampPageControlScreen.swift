import SwiftUI
import MAUL

struct TimestampPageControlScreen: View {

  var body: some View {

    let view = VStack {
      MAULTimestampPageControl(timeInterval: 0)
      MAULTimestampPageControl(timeInterval: 1)
      MAULTimestampPageControl(timeInterval: 666)
      MAULTimestampPageControl(timeInterval: 9999)
      MAULTimestampPageControl(timeInterval: 111111)
      MAULTimestampPageControl(timeInterval: 0, format: .HMS)
      MAULTimestampPageControl(timeInterval: 1, format: .HMS)
      MAULTimestampPageControl(timeInterval: 666, format: .HMS)
      MAULTimestampPageControl(timeInterval: 9999, format: .HMS)
      MAULTimestampPageControl(timeInterval: 111111, format: .HMS)
    }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.MAUL.Text.primary)

    VStack {
      view.environment(\.colorScheme, .light)
      view.environment(\.colorScheme, .dark)
    }
  }
}

struct TimestampPageControlScreen_Previews: PreviewProvider {
  static var previews: some View {
    TimestampPageControlScreen()
      .setupMAULForPreviews()
  }
}
