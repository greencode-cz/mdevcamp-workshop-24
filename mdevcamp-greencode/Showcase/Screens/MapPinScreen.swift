import SwiftUI
import MAUL

struct MapPinScreen: View {

  @ObservedObject var imagePinData = MAULPinModel(image: Image.MAUL.mapMarkerFill, selected: false)
  @ObservedObject var imagePinData2 = MAULPinModel(image: Image.MAUL.carFill, selected: false)

  var timeDataArray = [
    MAULTimePinModel(text: "10 min", side: .bottomTrailing),
    MAULTimePinModel(text: "10 min", side: .topTrailing),
    MAULTimePinModel(text: "10 min", side: .topLeading),
    MAULTimePinModel(text: "10 min", side: .bottomLeading)
  ]

  var body: some View {
    let view = VStack(alignment: .center, spacing: .MAUL.S) {
      MAULPin(model: imagePinData)
        .onTapGesture {
          imagePinData.selected.toggle()
        }
      MAULPin(model: imagePinData2)
        .onTapGesture {
          imagePinData2.selected.toggle()
        }
      MAULTimePin(model: timeDataArray[0])
      MAULTimePin(model: timeDataArray[1])
      MAULTimePin(model: timeDataArray[2])
      MAULTimePin(model: timeDataArray[3])
      MAULRoutePin(model: .init(image: Image.MAUL.boltFill, isAlternative: false))
      MAULRoutePin(model: .init(letter: "A", isAlternative: false))
      MAULRoutePin(model: .init(image: Image.MAUL.boltFill, isAlternative: true))
      MAULRoutePin(model: .init(letter: "A", isAlternative: true))
    }
      .padding()
      .background(Color.MAUL.Background.primary)

    ScrollView {
      view
        .environment(\.colorScheme, .light)

      view
        .environment(\.colorScheme, .dark)
    }
  }
}

struct MapPinScreen_Previews: PreviewProvider {
  static var previews: some View {
    MapPinScreen()
      .setupMAULForPreviews()
  }
}
